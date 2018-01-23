<?php

namespace App;

use Twig_Environment;
use Twig_Extension_Debug;
use Twig_Loader_Filesystem;

class TwigView
    //implements IView
{
    /**
     * @var Twig_Environment
     */
    private $twig;
    /**
     * @var Twig_Loader_Filesystem
     */
    private $loader;
    /**
     * @var string
     */
    private $template;
    /**
     * @var array
     */
    private $params;

    public function __construct($arg)
    {
       // print_r($arg);
        $this->params = $arg;
        $this->loader = new Twig_Loader_Filesystem(__DIR__ . '/templates/', array(
            'debug' => false,
            // ...
        ));
        $this->twig = new Twig_Environment($this->loader);

        $this->twig->addExtension(new Twig_Extension_Debug());
       /* $this->template = $template;
        $this->params = $params;*/
    }

    /**
     * @return string
     * @param string $template Имя шаблона
     * @param array $params Передаваемые параметры
     */
    public function render($template, $params)
    {
        $this->template = $template;
        $this->params = $params;
        try {
            echo $this->twig->render($this->template, $this->params);
        } catch (\Twig_Error_Loader $e) {
            echo '<pre>';
            print_r($e);
            echo '</pre>';
        }
    }
}