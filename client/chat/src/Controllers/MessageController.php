<?php

namespace Coop\Chat\Controllers
{

    use Coop\Chat\Api;
    use Coop\Chat\Bots\Bot;
    use Coop\Chat\Bots\Commands\Command;
    use Coop\Chat\Bots\Message\Message;
    use Coop\Chat\Formatters\MenusFormatter;
    use Coop\Chat\Http\Request;

    abstract class MessageController implements ControllerInterface
    {
        /**
         * @var Bot
         */
        private $bot;

        /**
         * @var Api
         */
        private $api;

        /**
         * @var MenusFormatter
         */
        private $formatter;

        public function __construct(Bot $bot, Api $api, MenusFormatter $formatter)
        {
            $this->bot = $bot;
            $this->api = $api;
            $this->formatter = $formatter;
        }

        public function execute(Request $request): Message
        {
            $command = $this->bot->getCommand($this->getRequestString($request));
            try {

            } catch (\Throwable $e) {
                // @todo catch getResponse incase a location doesn't exist, then we can return a new message that can be of error type for slack
            }

            $message = $this->bot->formatMessage($this->getResponse($command));

            return $message;
        }

        abstract protected function getRequestString(Request $request): string;

        private function getResponse(Command $command): string
        {
            switch ((string) $command) {
                case 'start':
                    return '';
                case 'menus':
                    return $this->formatter->format($this->api->getMenus($command->getLocation(), new \DateTime));
            }

            throw new \InvalidArgumentException('Unknown Command "' . $command . '" ');
        }
    }
}
