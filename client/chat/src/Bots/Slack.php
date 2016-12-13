<?php

namespace Coop\Chat\Bots
{

    use Coop\Chat\Bots\Commands\Command;
    use Coop\Chat\Bots\Message\ErrorMessage;
    use Coop\Chat\Bots\Message\Message;
    use Coop\Chat\Bots\Message\SlackMessage;

    class Slack implements Bot
    {

        public function formatMessage(string $message): Message
        {
            return new SlackMessage();
        }

        public function formatErrorMessage(string $message): ErrorMessage
        {
            // TODO: Implement formatErrorMessage() method.
        }

        public function getCommand(string $body): Command
        {
            // TODO: Implement getCommand() method.
        }
    }
}
