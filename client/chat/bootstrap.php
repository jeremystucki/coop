<?php

$frontController = new \Coop\Chat\FrontController(
    new \Coop\Chat\Routers\RequestRouter
);

echo json_encode($frontController->run());