<?php

namespace App\Controllers;

use App\Controller;

class Log
    extends Controller
{
    protected function actionDefault()
    {
        $this->actionAll();
    }

}