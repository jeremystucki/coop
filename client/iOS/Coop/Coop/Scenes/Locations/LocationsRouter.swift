//
//  Router.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


class LocationsRouter: Router {

    enum AvailableView {
        case Settings
        case Menus
    }

    let viewController: UIViewController

    init() {
        let presenter = LocationsPresenter()
        viewController = LocationsViewController()

        presenter.viewController = viewController as! LocationsViewController
        presenter.interactor = LocationsInteractor()
        presenter.router = self
    }

    var presenter: LocationsPresenter!

    func display(view: AvailableView) {

    }

}
