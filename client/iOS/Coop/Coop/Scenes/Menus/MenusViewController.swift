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
}


protocol MenusViewControllerOutput {
    func starClicked()
    func showMenuDetails(forMenu menu: Menu)
    func viewInitialized()
}


class MenusViewController: UITableViewController {

    var presenter: MenusViewControllerOutput!

    fileprivate var menus = [(Date, [Menu])]()

    init() {
        super.init(style: .grouped)
    }

    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showMenuDetails(forMenu: menus[indexPath.section].1[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func starClicked() {
        presenter.starClicked()
    }

    fileprivate func showBarButtonImage(_ image: UIImage) {
        let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(MenusViewController.starClicked))
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

}
