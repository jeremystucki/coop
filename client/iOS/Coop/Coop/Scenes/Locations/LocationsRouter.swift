//
//  LocationsRouter.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


protocol LocationsRouterOutput: NetworkRouterOutput {

}


class LocationsRouter: NetworkRouter {

    let viewController: UIViewController
    let presenter: NetworkRouterOutput    // TODO: figure out why LocationsRouterOutput does not work here

    init() {
        let viewController = LocationsViewController()
        let interactor = LocationsInteractor()
        let presenter = LocationsPresenter()

        viewController.title = NSLocalizedString("Locations", comment: "")

        interactor.presenter = presenter
        viewController.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        self.presenter = presenter
        self.viewController = viewController

        presenter.router = self
    }

    func showMenus(forLocation location: Location) {
        viewController.navigationController!.pushViewController(MenusRouter(forLocation: location).viewController, animated: true)
    }

}
