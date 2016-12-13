<?php

namespace Coop\Chat\Controllers
{

    use Coop\Chat\Bots\Message\Message;
    use Coop\Chat\Http\Request;

    interface ControllerInterface
    {
        public function execute(Request $request): Message;
    }
}
