//
//  MenusViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class MenusViewController: UIViewController, MenusViewPresenterOutput {

    private var output: MenusViewControllerOutput!
    private let location: Location
    
    private var tableView: UITableView!
    private var tableViewDelegate: UITableViewDelegate?
    private var tableViewDataSource: UITableViewDataSource?

    func setOutput(output: MenusViewControllerOutput) {
        self.output = output
    }
    
    init(location: Location) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = location.getName()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame, style: .Grouped)
        view.addSubview(tableView)
        
        output.fetchMenus(location)
    }
    
    func showMenus(menus: [NSDate: [Menu]]) {
        tableViewDelegate = MenusTableViewDelegate(menus: menus)
        tableViewDataSource = MenusTableViewDataSource(menus: menus)
        
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
