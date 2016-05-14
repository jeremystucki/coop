//
//  LocationsViewInteractorOutput.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

protocol LocationsViewInteractorOutput {
    
    func showLoading()
    
    func hideLoading()
    
    func updateLocations(locations: [Location])
}
