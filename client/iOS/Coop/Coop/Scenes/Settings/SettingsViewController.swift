//
//  SettingsViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 05/10/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewPresenterOutput {

    private var output: SettingsViewControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setOutput(_ output: SettingsViewControllerOutput) {
        self.output = output
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
