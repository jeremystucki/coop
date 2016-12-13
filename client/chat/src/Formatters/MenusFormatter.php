<?php

namespace Coop\Chat\Formatters
{
    interface MenusFormatter
    {
        public function format(array $menus): string;
    }
}
