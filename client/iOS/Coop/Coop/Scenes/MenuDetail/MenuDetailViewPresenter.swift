//
//  MenuDetailViewPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

class MenuDetailViewPresenter: MenuDetailViewInteractorOutput {

    private var output: MenuDetailViewPresenterOutput!
    
    func setOutput(output: MenuDetailViewPresenterOutput) {
        self.output = output
    }
    
}
