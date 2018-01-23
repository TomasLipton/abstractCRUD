<?php

namespace App\Controllers;

use App\Controller;

class Workers
    extends Controller
{
    protected function actionDefault()
    {
        $this->actionAll();
    }

}