<?php

namespace Coop\Chat\Bots
{

    use Coop\Chat\Bots\Message\Message;

    interface Bot
    {
        public function formatMessage(string $message): Message;
    }
}
