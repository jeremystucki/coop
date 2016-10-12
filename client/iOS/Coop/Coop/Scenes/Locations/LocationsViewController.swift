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
    private let searchController: UISearchController

    fileprivate let errorView = UIAlertController(title: "Could not load locations", message: nil, preferredStyle: .alert)
    fileprivate var locations = [Location]()
    fileprivate var filteredLocations: [Location] {
        guard let searchText = searchController.searchBar.text?.lowercased() else {
            return locations
        }

        return locations.filter({ $0.name.lowercased().hasPrefix(searchText) })
    }

    init() {
        searchController = UISearchController(searchResultsController: nil)

        super.init(style: .plain)

        title = "Locations"
    }

    override func viewDidLoad() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false

        tableView.tableHeaderView = searchController.searchBar

        presenter.viewInitialized()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.textLabel!.text = filteredLocations[(indexPath as NSIndexPath).row].name
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    convenience required init(coder aDecoder: NSCoder) {
        self.init()
    }

}


extension LocationsViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }

}


extension LocationsViewController: LocationsViewControllerInput {

    func displayNoLocationsError() {
        present(errorView, animated: true)
    }

    func displayLocations(_ locations: [Location]) {
        self.locations = locations
        tableView.reloadData()
    }

}
