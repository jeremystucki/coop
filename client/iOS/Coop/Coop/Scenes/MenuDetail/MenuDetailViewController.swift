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

        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        let dishes = UILabel()
        dishes.numberOfLines = menu.getDishes().count
        dishes.text = menu.getDishes().joinWithSeparator("\n")
        
        var topSpacing = UIApplication.sharedApplication().statusBarFrame.size.height
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            let titleLabel = UILabel()
            titleLabel.font = titleLabel.font.fontWithSize(30)
            titleLabel.text = menu.getTitle()
            titleLabel.frame = CGRect(x: 20, y: topSpacing + 20, width: 0, height: 0)
            titleLabel.sizeToFit()
            view.addSubview(titleLabel)
                
            dishes.frame = CGRect(x: 20, y: titleLabel.frame.maxY + 10, width: 0, height: 0)
        }
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            topSpacing += navigationController!.navigationBar.bounds.size.height
            dishes.frame = CGRect(x: 20, y: topSpacing + 20, width: 0, height: 0)
        }
        
        dishes.sizeToFit()
        view.addSubview(dishes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
