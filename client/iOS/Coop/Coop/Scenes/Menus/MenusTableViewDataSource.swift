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
    
    fileprivate let menus: [(Date, [Menu])]
    
    init(menus: [(Date, [Menu])]) {
        self.menus = menus
    }
    
    @objc func numberOfSections(in tableView: UITableView) -> Int {
        return menus.count
    }
    
    @objc func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let format = DateFormatter()
        format.dateFormat = "EEEE"
        
        return format.string(from: menus[section].0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = menus[(indexPath as NSIndexPath).section].1[(indexPath as NSIndexPath).row]
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = menu.getTitle()
        cell.detailTextLabel?.text = "CHF " + String(format: "%.2f", menu.getPrice())
        
        return cell
    }
}
