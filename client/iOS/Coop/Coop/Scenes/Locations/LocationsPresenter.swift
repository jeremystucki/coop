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

}


extension LocationsPresenter: LocationsViewControllerOutput {

    func viewInitialized() {
        interactor.fetchFavoriteLocations()
        interactor.fetchLocations()
    }

    func viewWillBecomeVisible() {
        interactor.fetchFavoriteLocations()
    }

    func showMenus(forLocation location: Location) {
        router.showMenus(forLocation: location)
    }

}


extension LocationsPresenter: LocationsInteractorOutput {

    func locationsFetched(_ locations: [Location]) {
        viewController.displayLocations(locations.sorted())
    }

    func favoriteLocationsFetched(_ favoriteLocations: [Location]) {
        viewController.displayFavoriteLocations(favoriteLocations.sorted())
    }

    func connectionErrorOccured() {
        router.showConnectionError()
    }

}


extension LocationsPresenter: LocationsRouterOutput {

    func retryPressed() {
        interactor.fetchLocations()
    }

}
