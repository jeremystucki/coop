<?php

namespace Coop\Chat\Controllers
{

    use Coop\Chat\Http\Request;

    class SlackController extends MessageController
    {
        protected function getRequestString(Request $request): string
        {
            return $request->getParameter('text');
        }
    }
}
