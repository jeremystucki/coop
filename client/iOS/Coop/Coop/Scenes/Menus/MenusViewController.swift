//
//  MenusViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class MenusViewController: UIViewController, MenusViewPresenterOutput, MenusTableViewOutput {

    fileprivate var output: MenusViewControllerOutput!
    fileprivate let location: Location
    fileprivate var menus: [(Date, [Menu])]?
    
    fileprivate var tableView: UITableView!
    fileprivate var tableViewDelegate: UITableViewDelegate?
    fileprivate var tableViewDataSource: UITableViewDataSource?

    func setOutput(_ output: MenusViewControllerOutput) {
        navigationItem.title = location.getName()
        self.output = output
    }

    init(location: Location) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()

        tableView = UITableView(frame: view.frame, style: .grouped)
        view.addSubview(tableView)

        if menus == nil {
            output.fetchMenus(location)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.frame
        
        var insets = tableView.contentInset
        insets.top = navigationController!.navigationBar.bounds.size.height + UIApplication.shared.statusBarFrame.size.height
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
    }
    
    func showMenus(_ menus: [(Date, [Menu])]) {
        self.menus = menus
        
        tableViewDelegate = MenusTableViewDelegate(menus: menus, output: self)
        tableViewDataSource = MenusTableViewDataSource(menus: menus)
        
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        tableView.reloadData()
    }
    
    func didSelectMenu(_ menu: Menu) {
        let viewController = ViewControllerFactory.createMenuDetailViewController(menu)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            splitViewController?.showDetailViewController(viewController, sender: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
