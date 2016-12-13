<?php

namespace Coop\Chat\Controllers
{

    use Coop\Chat\Api;
    use Coop\Chat\Bots\Bot;
    use Coop\Chat\Bots\Commands\Command;
    use Coop\Chat\Bots\Message\Message;
    use Coop\Chat\Exceptions\NoMenusException;
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
            try {
                $command = $this->bot->getCommand($this->getRequestString($request));
            } catch (\InvalidArgumentException $e) {
                // @todo error
                return;
            }

            try {
                $message = $this->bot->formatMessage($this->getResponse($command));
            } catch (NoMenusException $e) {
                // @todo error message for slack
                return;
            } catch (\Throwable $e) {
                return;
            }

            return $message;
        }

        abstract protected function getRequestString(Request $request): string;

        private function getResponse(Command $command): string
        {
            switch ((string) $command) {
                case 'start':
                    return 'Hi, I can look up the menu plan of a coop restaurant for you. Just send me "/menus LOCATION" and I will look it up.';
                case 'menus':
                    return $this->getMenu($command->getLocation());
            }

            throw new \InvalidArgumentException('Unknown Command "' . $command . '" ');
        }

        private function getMenu(string $location): string
        {
            $result = $this->api->getMenus($location, new \DateTime);
            if (empty($result)) {
                throw new NoMenusException;
            }

            return $this->formatter->format($result);
        }
    }
}
