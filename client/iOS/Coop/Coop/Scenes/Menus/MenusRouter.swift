//
//  MenusRouter.swift
//  Coop
//
//  Created by Jeremy Stucki on 13.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


protocol MenusRouterOutput: NetworkRouterOutput {

}


class MenusRouter: NetworkRouter {

    let viewController: UIViewController
    let presenter: NetworkRouterOutput    // TODO: figure out why MenusRouterOutput does not work here
    var detailViewController: UIViewController?

    init(forLocation location: Location) {
        let viewController = MenusViewController()
        let interactor = MenusInteractor(forLocation: location)
        let presenter = MenusPresenter()

        viewController.title = location.name

        interactor.presenter = presenter
        viewController.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        self.presenter = presenter
        self.viewController = viewController

        presenter.router = self
    }

    func showMenuDetails(forMenu menu: Menu) {

        let menuDetailViewController = MenuDetailRouter(forMenu: menu).viewController

        if UIDevice.current.userInterfaceIdiom == .phone {
            viewController.navigationController?.pushViewController(menuDetailViewController, animated: true)
        }

        if UIDevice.current.userInterfaceIdiom == .pad {
            viewController.splitViewController?.showDetailViewController(menuDetailViewController, sender: self)
        }

        self.detailViewController = menuDetailViewController
    }

}
