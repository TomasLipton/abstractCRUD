<?php

namespace App\Controllers;

use App\Controller;

class Components
    extends Controller
{
    protected function actionDefault()
    {
        $this->actionAll();
    }

}