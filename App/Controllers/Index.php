<?php

namespace App\Controllers;

use App\Controller;

class Index
    extends Controller
{
    protected function actionDefault()
    {
        $this->twigArgs['title'] = 'Главная страница!';
        $this->twig->render( '/index.twig', $this->twigArgs);
    }
}