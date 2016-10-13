//
//  MenusPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 13.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


class MenusPresenter {

    var viewController: MenusViewControllerInput!

    var interactor: MenusInteractorInput!

    var router: MenusRouter!

}


extension MenusPresenter: MenusViewControllerOutput {

    func viewInitialized() {
        interactor.fetchMenus()
    }

}


extension MenusPresenter: MenusInteractorOutput {

    func menusFetched(_ menus: [Menu]) {
        let sortedMenus = menus.sorted(by: {
            if $0.title.lowercased() == $1.title.lowercased() {
                return $0.price < $1.price
            }

            return $0.title.lowercased() < $1.title.lowercased()
        })

        viewController.displayMenus(sortedMenus.categorise({ $0.date }).sorted(by: { $0.key < $1.key }))
    }

}
