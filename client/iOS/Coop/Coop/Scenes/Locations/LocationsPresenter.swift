//
//  LocationsPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


class LocationsPresenter {

    var viewController: LocationsViewControllerInput! {
        didSet { (viewController as! LocationsViewController).presenter = self }
    }

    var interactor: LocationsInteractorInput! {
        didSet { (interactor as! LocationsInteractor).presenter = self }
    }

    var router: LocationsRouter! {
        didSet { router.presenter = self }
    }

    fileprivate func showLocations() {
        interactor.fetchLocations()
    }

}


extension LocationsPresenter: LocationsViewControllerOutput {

    func viewInitialized() {
        showLocations()
    }

}


extension LocationsPresenter: LocationsInteractorOutput {

    func locationsFetched(_ locations: [Location]) {
        if locations.count == 0 {
            return viewController.displayNoLocationsError()
        }

        viewController.displayLocations(locations)
    }

}
