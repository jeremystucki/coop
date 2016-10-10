//
//  MenusViewInteractorOutput.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

protocol MenusViewInteractorOutput {

    func showLoading()

    func hideLoading()

    func updateMenus(_ menus: [Menu])

}
