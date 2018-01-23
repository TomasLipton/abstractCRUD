<?php

namespace App\Controllers;


use App\Controller;
use App\Models\Users as UserModer;

class Users
    extends Controller
{
    protected function actionDefault()
    {
        $this->actionAll();
    }

    protected function actionLogout()
    {
        $_SESSION = [];
        header("Location: /");
    }

    protected function actionLogin()
    {

        if (!empty($_POST['login']) && !empty($_POST['passwd'])){
            $login = trim($_POST['login']);
            $passwd = trim($_POST['passwd']);
            $user = UserModer::findOneByColumn('login', $login);
            if ($user->passwd == md5($passwd)){
                $_SESSION['user']['access'] = true;
                $_SESSION['user']['login'] = $user->login;
                $_SESSION['user']['role'] = $user->role;
                /*
                setcookie("user[access]",true,time()+3600*8, "/");
                setcookie("user[login]",$user->login,time()+3600*8, "/");
                setcookie("user[role]",$user->role,time()+3600*8, "/");
                */
                header("Location: /");
            }else{
               header("Location: /users/login/?error=true");
            }
        }else{
            $args = [];
            if($_GET['error'] == true){
                $args['error'] = 'true';
            }
            $args['title'] = 'ZAVOT';
           $this->twig->render( '/login.twig', $args);
        }
    }
}