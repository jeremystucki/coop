<?php

namespace Coop\Chat\Routers
{

    use Coop\Chat\Controllers\ControllerInterface;
    use Coop\Chat\Controllers\SlackController;
    use Coop\Chat\Controllers\TelegramController;

    class RequestRouter
    {
        public function route(string $path): ControllerInterface
        {
            switch ($path) {
                case '/telegram':
                    return new TelegramController();
                case '/slack':
                    return new SlackController();
            }

            throw new \RuntimeException('Unknown Path');
        }
    }
}
