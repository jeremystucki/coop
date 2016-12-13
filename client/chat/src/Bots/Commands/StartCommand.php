<?php

namespace Coop\Chat\Bots\Commands
{
    class StartCommand implements Command
    {

        public function __toString(): string
        {
            return 'start';
        }
    }
}
