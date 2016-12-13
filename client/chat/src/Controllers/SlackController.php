<?php

namespace Coop\Chat\Controllers
{

    use Coop\Chat\Http\Request;

    class SlackController extends AbstractController
    {
        protected function getLocation(Request $request): string
        {
            if (!$request->hasParameter('text')) {
                throw new \InvalidArgumentException('Missing required parameter "text"');
            }

            return $request->getParameter('text');
        }

        protected function isMenuRequest(Request $request): bool
        {
            return true;
        }

        protected function doExecute(Request $request): string
        {
            throw new \LogicException('Unimplemented');
        }
    }
}
