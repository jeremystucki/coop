//
//  MenusRouter.swift
//  Coop
//
//  Created by Jeremy Stucki on 13.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


class MenusRouter {

    let viewController: UIViewController

    init(forLocation location: Location) {
        let viewController = MenusViewController(style: .grouped)
        let interactor = MenusInteractor(forLocation: location)
        let presenter = MenusPresenter()

        viewController.title = location.name

        interactor.presenter = presenter
        viewController.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        self.viewController = viewController

        presenter.router = self
    }

    func showMenuDetails(forMenu menu: Menu) {

    }

}
