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
    private var loadingView = UIAlertController(title: NSLocalizedString("Fetching locations", comment: ""), message: nil, preferredStyle: .Alert)
    private var errorView = UIAlertController(title: NSLocalizedString("Could not load locations", comment: ""), message: NSLocalizedString("Make sure that you are connected to the internet.", comment: ""), preferredStyle: .Alert)

    init() {
        errorView.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .Default, handler: { (action) in
            self.errorView.dismissViewControllerAnimated(true, completion: nil)
            self.output.fetchLocations()
        }))
    }
    
    func setOutput(output: LocationsViewPresenterOutput) {
        self.output = output
    }
    
    func showLoading() {
        UIApplication.sharedApplication().delegate!.window!!.rootViewController?.presentViewController(loadingView, animated: true, completion: nil)
    }
    
    func hideLoading() {
        loadingView.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showError() {
        if !loadingView.isBeingPresented() {
            return hideLoading()
        }
        
        loadingView.dismissViewControllerAnimated(true) { 
            UIApplication.sharedApplication().delegate!.window!!.rootViewController?.presentViewController(self.errorView, animated: true, completion: nil)
        }
    }
    
    func updateLocations(locations: [Location]) {
        output.showLocations(locations.sort({ $0.getName() < $1.getName() }))
    }
}
