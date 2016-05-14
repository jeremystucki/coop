//
//  ViewControllerFactory.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

class ViewControllerFactory {
    
    class func createLocationsViewController() -> LocationsViewController {        
        let viewController = LocationsViewController()
        let presenter = LocationsViewPresenter()
        let interactor = LocationsViewInteractor()
        
        viewController.setOutput(interactor)
        presenter.setOutput(viewController)
        interactor.setOutput(presenter)
        
        return viewController
    }
    
    class func createMenusViewController(location: Location) -> MenusViewController {
        let viewController = MenusViewController(location: location)
        let presenter = MenusViewPresenter()
        let interactor = MenusViewInteractor()
        
        viewController.setOutput(interactor)
        presenter.setOutput(viewController)
        interactor.setOutput(presenter)
        
        return viewController
    }
}
