//
//  MenuDetailViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class MenuDetailViewController: UIViewController, MenuDetailViewPresenterOutput {

    private var output: MenuDetailViewControllerOutput!
    private let menu: Menu
    
    func setOutput(output: MenuDetailViewControllerOutput) {
        self.output = output
    }
    
    init(menu: Menu) {
        self.menu = menu
        super.init(nibName: nil, bundle: nil)
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            navigationItem.title = menu.getTitle()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.backgroundColor = UIColor.whiteColor()
        
        let dishes = UILabel()
        dishes.numberOfLines = menu.getDishes().count
        dishes.text = menu.getDishes().joinWithSeparator("\n")
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            dishes.frame = CGRect(x: 10, y: 10, width: 0, height: 0)
        }
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            dishes.frame = CGRect(x: 10, y: 10, width: 0, height: 0)
        }
        
        dishes.sizeToFit()
        view.addSubview(dishes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
