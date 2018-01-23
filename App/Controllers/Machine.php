<?php

namespace App\Controllers;

use App\Controller;

class Machine
    extends Controller
{
    protected function actionDefault()
    {
        $this->actionAll();
    }

}