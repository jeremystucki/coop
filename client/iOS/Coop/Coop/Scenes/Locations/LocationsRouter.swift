//
//  LocationsRouter.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


class LocationsRouter {

    let viewController: UIViewController

    init() {
        let viewController = LocationsViewController(style: .plain)
        let interactor = LocationsInteractor()
        let presenter = LocationsPresenter()

        viewController.title = "Locations"

        interactor.presenter = presenter
        viewController.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        self.viewController = viewController

        presenter.router = self
    }

    func showMenus(forLocation location: Location) {
        viewController.navigationController!.pushViewController(MenusRouter(forLocation: location).viewController, animated: true)
    }

}
