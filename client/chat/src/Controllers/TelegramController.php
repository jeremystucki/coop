<?php

namespace Coop\Chat\Controllers
{

    use Coop\Chat\Http\Request;

    class TelegramController extends AbstractController
    {

        protected function isMenuRequest(Request $request): bool
        {
            return true;
        }

        protected function doExecute(Request $request): string
        {
            // TODO: Implement doExecute() method.
        }

        protected function getLocation(Request $request): string
        {
            // TODO: Implement getLocation() method.
        }
    }
}
