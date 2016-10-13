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
        interactor.fetchLocations()
    }

    func showMenus(forLocation location: Location) {
        router.showMenus(forLocation: location)
    }

}


extension LocationsPresenter: LocationsInteractorOutput {

    func locationsFetched(_ locations: [Location]) {
        if locations.count == 0 {
            return viewController.displayNoLocationsError()
        }

        viewController.displayLocations(locations.sorted())
    }

}
