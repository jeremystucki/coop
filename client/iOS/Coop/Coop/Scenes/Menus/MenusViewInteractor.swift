//
//  MenusViewInteractor.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

class MenusViewInteractor: MenusViewControllerOutput {

    fileprivate var output: MenusViewInteractorOutput!
    fileprivate let apiManager = ApiManager()
    
    func setOutput(_ output: MenusViewInteractorOutput) {
        self.output = output
    }
    
    func fetchMenus(_ location: Location) {
        output.showLoading()
        
        apiManager.fetchMenus(location) { (menus) in
            self.output.hideLoading()
            self.output.updateMenus(menus)
        }
    }
}
