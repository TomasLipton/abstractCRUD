<?php

namespace App\Controllers;

use App\Controller;
use App\Models\Access as AccessModel;

class Access
    extends Controller
{
    protected function actionDefault()
    {
        $this->actionAll();
    }

    protected function actionAll()
    {
        $accesses = AccessModel::findAll();
        $this->twigArgs['cols'] = AccessModel::getColComments();
        $this->twigArgs['title'] = AccessModel::getTableComment();
        $this->twigArgs['table'] = AccessModel::TABLE;
        $this->twigArgs['tables'] = AccessModel::getTables();
        $this->twigArgs['accesses'] = AccessModel::findAll();
        $this->twig->render(AccessModel::TEMPLATE, $this->twigArgs);
    }

    protected function actionUpdate()
    {
        $access = new AccessModel();

        $keys = array_keys($_POST);
        $data = $_POST;

        if (!isset($data['actionCreate'])) {
            $access->actionCreate = 'on';
        }
        if (!isset($data['actionRead'])) {
            $access->actionRead = 'on';
        }
        if (!isset($data['actionUpdate'])) {
            $access->actionUpdate = 'on';
        }
        if (!isset($data['actionDelete'])) {
            $access->actionDelete = 'on';
        }
        for ($i = 0; $i < count($_POST); $i++) {

            if ($data[$keys[$i]] == 'on') {
                $data[$keys[$i]] = 1;
            } else if ($data[$keys[$i]] == 'off') {
                $data[$keys[$i]] = 0;
            }


            $tmp = $keys[$i];
            $access->$tmp = $data[$keys[$i]];
        }

        $access->save();
        header('Location: /access/');
    }

    protected function actionAdd()
    {
        $this->actionUpdate();
    }
}