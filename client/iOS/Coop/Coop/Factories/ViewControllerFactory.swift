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
    
    class func createMenusViewController(_ location: Location) -> MenusViewController {
        let viewController = MenusViewController(location: location)
        let presenter = MenusViewPresenter()
        let interactor = MenusViewInteractor()
        
        viewController.setOutput(interactor)
        presenter.setOutput(viewController)
        interactor.setOutput(presenter)
                
        return viewController
    }
    
    class func createMenuDetailViewController(_ menu: Menu) -> MenuDetailViewController {
        let viewController = MenuDetailViewController(menu: menu)
        let presenter = MenuDetailViewPresenter()
        let interactor = MenuDetailViewInteractor()
        
        viewController.setOutput(interactor)
        presenter.setOutput(viewController)
        interactor.setOutput(presenter)
        
        return viewController
    }
    
    class func createSettingsViewController() -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsViewPresenter()
        let interactor = SettingsViewInteractor()
        
        viewController.setOutput(interactor)
        presenter.setOutput(viewController)
        interactor.setOutput(presenter)
        
        
        return viewController
    }
    
}
