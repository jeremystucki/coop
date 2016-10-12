//
//  Router.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


protocol LocationsRouterInput {
    associatedtype AvailableView
    func display(view: AvailableView)
}


class LocationsRouter: Router {

    let viewController: UIViewController

    init() {
        let presenter = LocationsPresenter()
        let viewController = LocationsViewController()
        let interactor = LocationsInteractor()

        interactor.presenter = presenter
        viewController.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        self.viewController = viewController

        presenter.router = self
    }

}


extension LocationsRouter: LocationsRouterInput {

    enum AvailableView {
        case Settings
        case Menus
    }

    func display(view: AvailableView) {

    }

}
