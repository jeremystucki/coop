//
//  MenusViewPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

class MenusViewPresenter: MenusViewInteractorOutput {

    fileprivate var output: MenusViewPresenterOutput!
    
    func setOutput(_ output: MenusViewPresenterOutput) {
        self.output = output
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func updateMenus(_ menus: [Menu]) {
        let sortedMenus = menus.sorted(by: {
            if $0.title.lowercased() == $1.title.lowercased() {
                return $0.price < $1.price
            }
            
            return $0.title.lowercased() < $1.title.lowercased()
        })
        
        let groupedMenus = sortedMenus.categorise({ $0.date }).sorted(by: { $0.0 < $1.0 })
        
        output.showMenus(groupedMenus)
    }
}
