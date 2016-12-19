<?php

namespace Coop\Chat
{

    use Coop\Chat\Bots\Message\Message;
    use Coop\Chat\Http\Request;
    use Coop\Chat\Routers\RequestRouter;

    class FrontController
    {
        /**
         * @var RequestRouter
         */
        private $requestRouter;

        public function __construct(RequestRouter $requestRouter)
        {
            $this->requestRouter = $requestRouter;
        }

        public function run(): Message
        {
            $controller = $this->requestRouter->route('/foo');
            $message = $controller->execute(new Request);

            return $message;
        }
    }
}
