//
//  LocationsTableViewDataSource.swift
//  Coop
//
//  Created by Jeremy Stucki on 13/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class LocationsTableViewDataSource: NSObject, UITableViewDataSource {
    
    fileprivate let locations: [Location]
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = locations[(indexPath as NSIndexPath).row].getName()
        
        return cell
    }
}
