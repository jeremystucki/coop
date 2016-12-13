<?php

namespace Coop\Chat\Bots\Message
{
    class SlackMessage implements Message
    {

        public function jsonSerialize(): array
        {
            return [];
        }
    }
}
