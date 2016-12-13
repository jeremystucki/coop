<?php

namespace Coop\Chat\Bots\Commands
{
    interface Command
    {
        public function __toString(): string;
    }
}
