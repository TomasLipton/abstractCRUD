<?php

namespace App\Controllers;

use App\Controller;

class Buildings
    extends Controller
{
    protected function actionDefault()
    {
        $this->actionAll();
    }
}