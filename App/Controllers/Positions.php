<?php

namespace App\Controllers;

use App\Controller;

class Positions
    extends Controller
{
    protected function actionDefault()
    {
        $this->actionAll();
    }

}