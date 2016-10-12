//
//  LocationsPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


class LocationsPresenter {

    var viewController: LocationsViewController! {
        didSet { viewController.presenter = self }
    }

    var interactor: LocationsInteractor! {
        didSet { interactor.presenter = self }
    }

    var router: LocationsRouter! {
        didSet { router.presenter = self }
    }

    func viewInitialized() {
        showLocations()
    }

    private func showLocations() {
        interactor.fetchLocations()
    }

    func locationsFetched(_ locations: [Location]) {
        if locations.count == 0 {
            return viewController.showNoLocationsFoundError()
        }

        viewController.locations = locations.sorted()
    }
    
}
