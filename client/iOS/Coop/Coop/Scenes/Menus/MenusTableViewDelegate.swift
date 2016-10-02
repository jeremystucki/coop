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
    
    fileprivate let menus: [(Date, [Menu])]
    fileprivate let output: MenusTableViewOutput
    
    init(menus: [(Date, [Menu])], output: MenusTableViewOutput) {
        self.menus = menus
        self.output = output
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectMenu(menus[(indexPath as NSIndexPath).section].1[(indexPath as NSIndexPath).row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
