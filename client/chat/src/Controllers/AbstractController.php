<?php

namespace Coop\Chat\Controllers
{

    use Coop\Chat\Api;
    use Coop\Chat\Bots\Bot;
    use Coop\Chat\Bots\Message\Message;
    use Coop\Chat\Http\Request;

    abstract class AbstractController implements ControllerInterface
    {
        /**
         * @var Bot
         */
        private $bot;

        /**
         * @var Api
         */
        private $api;

        public function __construct(Bot $bot, Api $api)
        {
            $this->bot = $bot;
            $this->api = $api;
        }

        public function execute(Request $request): Message
        {
            if (!$this->isMenuRequest($request)) {
                $message = $this->handleMenuRequest($request);
            }

            if (!isset($message)) {
                $message = $this->bot->formatMessage($this->doExecute($request));
            }

            return $message;
        }

        private function handleMenuRequest(Request $request): Message
        {
            $location = $this->getLocation($request);
            $menus = $this->api->getMenus($location, new \DateTime);

            return $this->bot->formatMessage($menus);
        }

        abstract protected function isMenuRequest(Request $request): bool;

        abstract protected function doExecute(Request $request): string;

        abstract protected function getLocation(Request $request): string;
    }
}
