//
//  LocationsTableViewDataSource.swift
//  Coop
//
//  Created by Jeremy Stucki on 13/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class LocationsTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let locations: [Location]
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        cell.textLabel?.text = locations[indexPath.row].getName()
        
        return cell
    }
}
