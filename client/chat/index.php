<?php

$frontController = new \Coop\Chat\FrontController(
    new \Coop\Chat\Routers\RequestRouter
);

echo (string) $frontController->run();