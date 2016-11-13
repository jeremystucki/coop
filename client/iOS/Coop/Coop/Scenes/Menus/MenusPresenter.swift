//
//  MenusPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 13.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

class MenusPresenter {

    var viewController: MenusViewControllerInput!

    var interactor: MenusInteractorInput!

    var router: MenusRouter!

    fileprivate func displayStar() {
        if interactor.location.isFavorite {
            viewController.showFullStar()
        } else {
            viewController.showEmptyStar()
        }
    }

}


extension MenusPresenter: MenusViewControllerOutput {

    func showMenuDetails(forMenu menu: Menu) {
        router.showMenuDetails(forMenu: menu)
    }

    func starClicked() {
        interactor.location.isFavorite = !interactor.location.isFavorite
        displayStar()
    }

    func viewInitialized() {
        displayStar()
        interactor.fetchMenus()
    }

}


extension MenusPresenter: MenusInteractorOutput {

    func menusFetched(_ menus: [Menu]) {
        let sortedMenus = menus.sorted()

        viewController.displayMenus(sortedMenus.categorise({ $0.date }).sorted(by: { $0.key < $1.key }))
    }

    func connectionErrorOccured() {
        router.showConnectionError()
    }

}


extension MenusPresenter: MenusRouterOutput {

    func retryPressed() {
        interactor.fetchMenus()
    }

}
