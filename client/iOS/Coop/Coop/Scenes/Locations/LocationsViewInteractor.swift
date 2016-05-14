//
//  LocationsViewInteractor.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

class LocationsViewInteractor: LocationsViewControllerOutput {
    
    private var output: LocationsViewInteractorOutput!
    private let apiManager = ApiManager()
    
    func setOutput(output: LocationsViewInteractorOutput) {
        self.output = output
    }
    
    func fetchLocations() {
        output.showLoading()
        
        apiManager.fetchLocations { (locations) in
            self.output.hideLoading()
            self.output.updateLocations(locations)
        }
    }
}
