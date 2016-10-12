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
    var presenter: LocationsPresenter!

    init() {
        let presenter = LocationsPresenter()
        viewController = LocationsViewController()

        presenter.viewController = viewController as! LocationsViewController
        presenter.interactor = LocationsInteractor()
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
