//
//  LocationsViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController, LocationsViewPresenterOutput, LocationsTableViewOutput {
    
    private var output: LocationsViewControllerOutput!
    private var tableView: UITableView!
    private var tableViewDelegate: UITableViewDelegate?
    private var tableViewDataSource: UITableViewDataSource?
    
    func setOutput(output: LocationsViewControllerOutput) {
        navigationItem.title = "Locations"
        self.output = output
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame, style: .Plain)
        view.addSubview(tableView)
        
        output.fetchLocations()
    }
    
    func showLocations(locations: [Location]) {
        tableViewDelegate = LocationsTableViewDelegate(locations: locations, output: self)
        tableViewDataSource = LocationsTableViewDataSource(locations: locations)
        
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        tableView.reloadData()
    }
    
    func didSelectLocation(location: Location) {
        let viewController = ViewControllerFactory.createMenusViewController(location)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
