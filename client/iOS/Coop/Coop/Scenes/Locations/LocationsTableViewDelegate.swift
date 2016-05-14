//
//  LocationsTableViewDelegate.swift
//  Coop
//
//  Created by Jeremy Stucki on 13/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class LocationsTableViewDelegate: NSObject, UITableViewDelegate {
        
    private let locations: [Location]
    private let output: LocationsTableViewOutput
    
    init(locations: [Location], output: LocationsTableViewOutput) {
        self.locations = locations
        self.output = output
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        output.didSelectLocation(locations[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
