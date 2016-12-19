<?php

namespace Coop\Chat\Bots\Commands
{
    class MenusCommand implements Command
    {
        /**
         * @var string
         */
        private $location;

        public function __construct(string $location)
        {
            $this->location = $location;
        }

        public function getLocation(): string
        {
            return $this->location;
        }
    }
}
