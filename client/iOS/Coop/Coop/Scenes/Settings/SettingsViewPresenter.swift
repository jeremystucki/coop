//
//  SettingsViewPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 05/10/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

class SettingsViewPresenter: SettingsViewInteractorOutput {

    private var output: SettingsViewPresenterOutput!

    func setOutput(_ output: SettingsViewPresenterOutput) {
        self.output = output
    }

}
