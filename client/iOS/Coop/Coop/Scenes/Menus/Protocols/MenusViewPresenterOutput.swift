//
//  MenusViewPresenterOutput.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

protocol MenusViewPresenterOutput {
    
    func showMenus(menus: [(NSDate, [Menu])])
}
