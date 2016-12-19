<?php

namespace Coop\Chat\Bots\Message
{
    class TelegramMessage implements Message
    {

        public function jsonSerialize(): array
        {
            return [];
        }
    }
}
