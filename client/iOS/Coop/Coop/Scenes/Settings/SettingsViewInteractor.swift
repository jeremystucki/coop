//
//  SettingsViewInteractor.swift
//  Coop
//
//  Created by Jeremy Stucki on 05/10/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

class SettingsViewInteractor: SettingsViewControllerOutput {

    private var output: SettingsViewInteractorOutput!
    private let apiManager = ApiManager()
    
    func setOutput(_ output: SettingsViewInteractorOutput) {
        self.output = output
    }
}
