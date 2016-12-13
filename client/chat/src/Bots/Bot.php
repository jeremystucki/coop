<?php

namespace Coop\Chat\Bots
{
    interface Bot
    {
        public function reply(string $message);
    }
}
