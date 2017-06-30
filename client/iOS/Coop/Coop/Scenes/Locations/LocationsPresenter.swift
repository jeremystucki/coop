//
//  LocationsPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

class LocationsPresenter {

    var viewController: LocationsViewControllerInput!
    
    var interactor: LocationsInteractorInput!

    var router: LocationsRouter!

    var locations = [Location]()

}


extension LocationsPresenter: LocationsViewControllerOutput {

    func viewInitialized() {
        interactor.fetchLocations()
    }

    func viewWillBecomeVisible() {
        interactor.fetchFavoriteLocations(allLocations: locations)
    }

    func showMenus(forLocation location: Location) {
        router.showMenus(forLocation: location)
    }

}


extension LocationsPresenter: LocationsInteractorOutput {

    func locationsFetched(_ locations: [Location]) {
        self.locations = locations

        interactor.fetchFavoriteLocations(allLocations: locations)
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
