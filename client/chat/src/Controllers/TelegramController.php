<?php

namespace Coop\Chat\Controllers
{

    use Coop\Chat\Http\Request;

    class TelegramController extends MessageController
    {

        protected function getRequestString(Request $request): string
        {
            return $request->getParameter('text');
        }
    }
}
