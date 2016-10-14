//
//  LocationsViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


protocol LocationsViewControllerInput {
    func displayLocations(_ locations: [Location])
    func displayFavoriteLocations(_ favoriteLocations: [Location])
    func displayNoLocationsError()
}


protocol LocationsViewControllerOutput {
    func viewInitialized()
    func viewWillBecomeVisible()
    func showMenus(forLocation location: Location)
}


class LocationsViewController: UITableViewController {

    var presenter: LocationsViewControllerOutput!
    private let searchController = UISearchController(searchResultsController: nil)

    fileprivate let errorView = UIAlertController(title: "Could not load locations", message: nil, preferredStyle: .alert)

    private var hasFavorites: Bool {
        return !filteredFavoriteLocations.isEmpty
    }

    fileprivate var locations = [Location]()
    fileprivate var filteredLocations: [Location] {
        guard let searchText = searchController.searchBar.text?.lowercased() else {
            return locations
        }

        return locations.filter({ $0.name.lowercased().hasPrefix(searchText) })
    }

    fileprivate var favoriteLocations = [Location]()
    fileprivate var filteredFavoriteLocations: [Location] {
        guard let searchText = searchController.searchBar.text?.lowercased() else {
            return favoriteLocations
        }

        return favoriteLocations.filter({ $0.name.lowercased().hasPrefix(searchText) })
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillBecomeVisible()
    }

    override func viewDidLoad() {
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false

        tableView.tableHeaderView = searchController.searchBar

        presenter.viewInitialized()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if hasFavorites {
            return 2
        }

        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && hasFavorites {
            return "Favorites"
        }

        if hasFavorites {
            return "All"
        }

        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && hasFavorites {
            return filteredFavoriteLocations.count
        }

        return filteredLocations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator


        if indexPath.section == 0 && hasFavorites {
            cell.textLabel!.text = filteredFavoriteLocations[(indexPath as NSIndexPath).row].name
        } else {
            cell.textLabel!.text = filteredLocations[(indexPath as NSIndexPath).row].name
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasFavorites && indexPath.section == 0 {
            presenter.showMenus(forLocation: filteredFavoriteLocations[indexPath.row])
        } else {
            presenter.showMenus(forLocation: filteredLocations[indexPath.row])
        }

        tableView.deselectRow(at: indexPath, animated: true)
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

    func displayFavoriteLocations(_ favoriteLocations: [Location]) {
        self.favoriteLocations = favoriteLocations
        tableView.reloadData()
    }

}
