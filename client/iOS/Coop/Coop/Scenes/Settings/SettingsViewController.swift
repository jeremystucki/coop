//
//  SettingsViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 05/10/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, SettingsViewPresenterOutput {

    private var output: SettingsViewControllerOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setOutput(_ output: SettingsViewControllerOutput) {
        self.output = output
    }

    func close(_ sender : UITapGestureRecognizer) {
        dismiss(animated: true)
    }

    init() {
        super.init(style: .grouped)

        tableView.delegate = self
        tableView.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Extensions"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)

        cell.textLabel!.text = "Default location"
        cell.accessoryType = .disclosureIndicator

        if Configuration.instance.defaultLocation != nil {
            cell.detailTextLabel!.text = Configuration.instance.defaultLocation!.name
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ViewControllerFactory.createLocationsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

}
