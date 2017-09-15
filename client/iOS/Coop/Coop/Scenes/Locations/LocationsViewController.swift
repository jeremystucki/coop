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
}


protocol LocationsViewControllerOutput {
    func viewInitialized()
    func viewWillBecomeVisible()
    func showMenus(forLocation location: Location)
}


class LocationsViewController: UITableViewController {

    var presenter: LocationsViewControllerOutput!
    private let searchController = UISearchController(searchResultsController: nil)

    private var hasFavorites: Bool {
        return !filteredFavoriteLocations.isEmpty
    }

    private var searchText: String {
        return searchController.searchBar.text!.lowercased()
    }

    fileprivate var locations = [Location]()
    private var filteredLocations: [Location] {
        return locations.filter({ $0.name.lowercased().hasPrefix(searchText) })
    }

    fileprivate var favoriteLocations = [Location]()
    private var filteredFavoriteLocations: [Location] {
        return favoriteLocations.filter({ $0.name.lowercased().hasPrefix(searchText) })
    }

    init() {
        super.init(style: .plain)
    }

    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillBecomeVisible()
    }

    override func viewDidLoad() {
        definesPresentationContext = true

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false

        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }

        presenter.viewInitialized()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return hasFavorites ? 2 : 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && hasFavorites {
            return NSLocalizedString("Favorites", comment: "")
        }

        return hasFavorites ? NSLocalizedString("All", comment: "") : nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0 && hasFavorites ? filteredFavoriteLocations : filteredLocations).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locations = indexPath.section == 0 && hasFavorites ? filteredFavoriteLocations : filteredLocations

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = locations[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locations = indexPath.section == 0 && hasFavorites ? filteredFavoriteLocations : filteredLocations

        presenter.showMenus(forLocation: locations[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


extension LocationsViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }

}


extension LocationsViewController: LocationsViewControllerInput {

    func displayLocations(_ locations: [Location]) {
        self.locations = locations
        tableView.reloadData()
    }

    func displayFavoriteLocations(_ favoriteLocations: [Location]) {
        self.favoriteLocations = favoriteLocations
        tableView.reloadData()
    }

}
