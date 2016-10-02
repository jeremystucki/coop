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
    
    func setOutput(_ output: LocationsViewInteractorOutput) {
        self.output = output
    }
    
    func fetchLocations() {
        output.showLoading()
        
        apiManager.fetchLocations { (locations) in
            if locations.count == 0 {
                return self.output.showError()
            }
            
            self.output.hideLoading()
            self.output.updateLocations(locations)
        }
    }
}
