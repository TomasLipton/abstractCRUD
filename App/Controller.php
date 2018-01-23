<?php

namespace App;

use App\Controllers\Users;
use App\Models\Access;


abstract class Controller
{
    protected $twig;
    protected $twigArgs = [];
    protected $user = [];

    public function __construct()
    {
        $this->user = $_SESSION['user'];
        $this->twig = new TwigView($this->twigArgs);
        $this->twigArgs['user'] = $this->user;
        $this->twigArgs['sidebar'] = $this->getSidebarItems();

    }

    private function setAccess($userRole = 15, $actionRead = 1, $actionCreate = 1, $actionUpdate = 1, $actionDelete = 1)
    {
        $tmp = Model::getTables();
        for ($i = 0; $i < count($tmp); $i++) {
            $access = new Access();
            unset($access->id);
            $access->userRole = $userRole;
            $access->actionRead = $actionRead;
            $access->actionCreate = $actionCreate;
            $access->actionUpdate = $actionUpdate;
            $access->actionDelete = $actionDelete;
            $access->dataBaseTable = $tmp[$i]->TABLE_NAME;
            $access->save();
        }
    }

    protected function checkAccess($action)
    {
        if($action != 'All' && $action != 'Delete' && $action != 'Add' && $action != 'Update')
            return true;

        $table = $this->getActionName();
        $this->user['role'];

        try {
            $tmp = Access::findOneByColumns([
                'dataBaseTable' => strtolower($table),
                'userRole' => $this->user['role']
            ]);
        } catch (\App\Exceptions\Db $e) {
            return false;
        }

        switch ($action) {
            case 'All':
                return $tmp->actionRead;
                break;
            case 'Default':
                return $tmp->actionRead;
                break;
            case 'Delete':
                return $tmp->actionDelete;
                break;
            case 'Add':
                return $tmp->actionCreate;
                break;
            case 'Update':
                return $tmp->actionUpdate;
                break;
        }
    }

    protected function getSidebarItems()
    {
        if (!$this->user['role']) {
            return;
        }
        $tables = Model::getTables();
        $numbersOfTables = count($tables);
        $access = Access::findByColumns([
            'actionRead' => 1,
            'userRole' => $this->user['role']
        ]);

        for ($i = 0; $i < count($access); $i++) {
            $access[$i] = $access[$i]->dataBaseTable;
        }

        for ($i = 0; $i < $numbersOfTables; $i++) {
            if (!in_array($tables[$i]->TABLE_NAME, $access)) {
                unset($tables[$i]);
            }
        }
        return $tables;
    }

    protected function access($action)
    {
        if (!$this->checkAccess($action)) {
            $this->twigArgs['title'] = 'Доступ закрыт!';
            $this->twig->render('/accessDeny.twig', $this->twigArgs);
            die;
        }

        if (isset($_SESSION["user"]["access"]) || $action == "Login") {
            return true;
        } else {
            return false;
        }
    }

    public function action($name)
    {
        if ($this->access($name)) {
            $name = 'action' . $name;
            $this->$name();
        } else {
            $user = new Users();
            $user->action('Login');
        }
    }

    private function getModel()
    {
        $modelClassName = explode("\\", static::class);
        $modelClassName[1] = 'Models';
        $modelClassName = implode("\\", $modelClassName);
        return new $modelClassName;
    }

    private function getActionName()
    {
        return explode("\\", static::class)[2];
    }

    protected function actionAll()
    {
        $model = $this->getModel();

        $this->twigArgs['items'] = $model->findAll();
        $this->twigArgs['title'] = $model->getTableComment();
        $this->twigArgs['table'] = $model::TABLE;
        $this->twigArgs['cols'] = $model->getColComments();

        for ($i = 0; $i < count($this->twigArgs['items']); $i++) {
            $this->twigArgs['items'][$i] = (array)$this->twigArgs['items'][$i];
            $this->twigArgs['items'][$i] = array_values($this->twigArgs['items'][$i]);
        }

        $this->twig->render('/' . $model::TEMPLATE . '.twig', $this->twigArgs);
    }

    protected function actionDelete()
    {
        $id = $_GET['id'];

        $model = $this->getModel();
        $item = $model->findById($id);

        $item->delete();
        header("Location: /" . $this->getActionName() . "/");
    }

    protected function actionAdd()
    {
        $keys = array_keys($_POST);
        $data = $_POST;

        $model = $this->getModel();

        for ($i = 0; $i < count($_POST); $i++) {
            $tmp = $keys[$i];
            $model->$tmp = $data[$keys[$i]];
        }

        $model->save();

        header("Location: /" . $this->getActionName() . "/");
    }

    protected function actionUpdate()
    {
        $this->actionAdd();
    }

}