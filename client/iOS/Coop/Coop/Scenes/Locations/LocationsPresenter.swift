//
//  LocationsPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


class LocationsPresenter {

    var viewController: LocationsViewControllerInput!
    
    var interactor: LocationsInteractorInput!

    var router: LocationsRouter!

    fileprivate func showFavoriteLocations() {
        var favoriteLocations = [Location]()
        for locationName in Configuration.favoriteLocations {
            favoriteLocations.append(Location(name: locationName))
        }

        viewController.displayFavoriteLocations(favoriteLocations)
    }

}


extension LocationsPresenter: LocationsViewControllerOutput {

    func viewInitialized() {
        showFavoriteLocations()
        interactor.fetchLocations()
    }

    func viewWillBecomeVisible() {
        showFavoriteLocations()
    }

    func showMenus(forLocation location: Location) {
        router.showMenus(forLocation: location)
    }

}


extension LocationsPresenter: LocationsInteractorOutput {

    func locationsFetched(_ locations: [Location]) {
        if locations.isEmpty {
            return viewController.displayNoLocationsError()
        }

        viewController.displayLocations(locations.sorted())
    }

}
