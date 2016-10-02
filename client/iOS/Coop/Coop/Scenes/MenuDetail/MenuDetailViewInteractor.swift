//
//  MenuDetailViewInteractor.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

class MenuDetailViewInteractor: MenuDetailViewControllerOutput {

    fileprivate var output: MenuDetailViewInteractorOutput!
    fileprivate let apiManager = ApiManager()
    
    func setOutput(_ output: MenuDetailViewInteractorOutput) {
        self.output = output
    }
}
