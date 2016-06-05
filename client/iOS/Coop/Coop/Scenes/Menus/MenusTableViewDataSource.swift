//
//  MenusTableViewDataSource.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation
import UIKit

class MenusTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let menus: [(NSDate, [Menu])]
    
    init(menus: [(NSDate, [Menu])]) {
        self.menus = menus
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menus.count
    }
    
    @objc func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let format = NSDateFormatter()
        format.dateFormat = "EEEE"
        
        return format.stringFromDate(menus[section].0)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus[section].1.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let menu = menus[indexPath.section].1[indexPath.row]
        
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
        cell.textLabel?.text = menu.getTitle()
        cell.detailTextLabel?.text = "CHF " + String(format: "%.2f", menu.getPrice())
        
        return cell
    }
}
