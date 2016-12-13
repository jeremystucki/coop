<?php

namespace Coop\Chat\Bots
{

    use Coop\Chat\Bots\Message\Message;
    use Coop\Chat\Bots\Message\TelegramMessage;

    class Telegram implements Bot
    {
        public function formatMessage(string $message): Message
        {
            return new TelegramMessage;
        }
    }
}
