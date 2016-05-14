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
    private let output: MenusTableViewOutput
    
    init(menus: [NSDate: [Menu]], output: MenusTableViewOutput) {
        self.menus = menus
        self.output = output
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        output.didSelectMenu(menus[Array(menus.keys)[indexPath.section]]![indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
