<?php

namespace Coop\Chat\Bots
{

    use Coop\Chat\Bots\Commands\Command;
    use Coop\Chat\Bots\Message\ErrorMessage;
    use Coop\Chat\Bots\Message\Message;

    interface Bot
    {
        public function formatMessage(string $message): Message;

        public function formatErrorMessage(string $message): ErrorMessage;

        public function getCommand(string $body): Command;
    }
}
