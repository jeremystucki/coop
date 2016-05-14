//
//  MenusViewPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

class MenusViewPresenter: MenusViewInteractorOutput {

    private var output: MenusViewPresenterOutput!
    
    func setOutput(output: MenusViewPresenterOutput) {
        self.output = output
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func updateMenus(menus: [Menu]) {
        let sortedMenus = menus.sort({ $0.getTitle().lowercaseString < $1.getTitle().lowercaseString })
        let groupedMenus = sortedMenus.categorise({ $0.getDate() })
        
        output.showMenus(groupedMenus)
    }
}
