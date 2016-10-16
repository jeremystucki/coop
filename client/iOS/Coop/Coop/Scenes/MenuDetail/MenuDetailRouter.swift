//
//  MenuDetailRouter.swift
//  Coop
//
//  Created by Jeremy Stucki on 16.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


class MenuDetailRouter {

    let viewController: UIViewController

    init(forMenu menu: Menu) {
        viewController = MenuDetailViewController(forMenu: menu)
    }

}
