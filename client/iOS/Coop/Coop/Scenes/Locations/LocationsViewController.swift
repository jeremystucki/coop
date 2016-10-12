//
//  ViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


protocol LocationsViewControllerInput {
    func displayLocations(_ locations: [Location])
    func displayNoLocationsError()
}


protocol LocationsViewControllerOutput {
    func viewInitialized()
}


class LocationsViewController: UITableViewController {

    var presenter: LocationsViewControllerOutput!

    fileprivate let errorView = UIAlertController(title: "Could not load locations", message: nil, preferredStyle: .alert)
    fileprivate var locations = [Location]() {
        didSet { tableView.reloadData() }
    }

    init() {
        super.init(style: .plain)

        title = "Locations"
    }

    override func viewDidLoad() {
        presenter.viewInitialized()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.textLabel!.text = locations[(indexPath as NSIndexPath).row].name
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension LocationsViewController: LocationsViewControllerInput {

    func displayNoLocationsError() {
        present(errorView, animated: true)
    }

    func displayLocations(_ locations: [Location]) {
        self.locations = locations.sorted()
    }

}
