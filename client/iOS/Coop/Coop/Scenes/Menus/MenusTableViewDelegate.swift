//
//  MenusTableViewDelegate.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation
import UIKit

class MenusTableViewDelegate: NSObject, UITableViewDelegate {
    
    private let menus: [NSDate: [Menu]]
    
    init(menus: [NSDate: [Menu]]) {
        self.menus = menus
    }
}
