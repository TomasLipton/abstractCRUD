<?php

namespace App\Controllers;

use App\Controller;

class Details
    extends Controller
{
    protected function actionDefault()
    {
        $this->actionAll();
    }

}