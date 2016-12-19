<?php

namespace Coop\Chat\Formatters
{
    class MarkdownMenusFormatter implements MenusFormatter
    {
        public function format(array $menus): string
        {
            $result = [];

            foreach ($menus as $menu) {
                $text = '*' . $menu['title'] . '* - ' . $menu['price'];

                foreach($menu['menu'] as $dish) {
                    $text .= PHP_EOL . '-' . $dish;
                }

                $result[] = $text;
            }

            return implode(PHP_EOL . PHP_EOL, $result);
        }
    }
}
