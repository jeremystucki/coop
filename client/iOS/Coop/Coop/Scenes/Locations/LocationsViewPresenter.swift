//
//  LocationsViewPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class LocationsViewPresenter: LocationsViewInteractorOutput {
    
    private var output: LocationsViewPresenterOutput!
    
    func setOutput(output: LocationsViewPresenterOutput) {
        self.output = output
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func updateLocations(locations: [Location]) {
        let sortedLocations = locations.sort({ $0.getName() < $1.getName() })
    
        output.showLocations(sortedLocations)
    }
}
