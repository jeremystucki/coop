//
//  MenusViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 13.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation
import UIKit


protocol MenusViewControllerInput {
    func showEmptyStar()
    func showFullStar()
    func displayMenus(_ menus: [(Date, [Menu])])
    func displayNoMenusError()
}


@objc protocol MenusViewControllerOutput {
    func starClicked()
    func viewInitialized()
}


class MenusViewController: UITableViewController {

    var presenter: MenusViewControllerOutput!

    fileprivate let errorView = UIAlertController(title: "Could not load menus", message: nil, preferredStyle: .alert)
    fileprivate var menus = [(Date, [Menu])]()

    override func viewDidLoad() {
        presenter.viewInitialized()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return menus.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let format = DateFormatter()
        format.dateFormat = "EEEE"

        return format.string(from: menus[section].0)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus[section].1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = menus[indexPath.section].1[indexPath.row]

        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = menu.title
        cell.detailTextLabel?.text = "CHF " + String(format: "%.2f", menu.price)

        return cell
    }

    fileprivate func showBarButtonImage(_ image: UIImage) {
        let button = UIBarButtonItem(image: image, style: .done, target: presenter, action: #selector(MenusViewControllerOutput.starClicked))
        navigationItem.setRightBarButton(button, animated: true)
    }

}


extension MenusViewController: MenusViewControllerInput {

    func showEmptyStar() {
        showBarButtonImage(UIImage(named: "empty star")!.withRenderingMode(.alwaysOriginal))
    }

    func showFullStar() {
        showBarButtonImage(UIImage(named: "full star")!.withRenderingMode(.alwaysOriginal))
    }

    func displayMenus(_ menus: [(Date, [Menu])]) {
        self.menus = menus
        tableView.reloadData()
    }

    func displayNoMenusError() {
        present(errorView, animated: true)
    }

}
