//
//  Configuration.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

class Configuration {
    
    fileprivate static var instance: Configuration?
    
    fileprivate let _apiEndpoint: URL
    
    init() {
        let mode = Bundle.main.infoDictionary!["Configuration"] as! String
        
        let configurationFile = Bundle.main.path(forResource: "Configuration", ofType: "plist")!
        let allConfigurations = NSDictionary(contentsOfFile: configurationFile)!
        let configuration = allConfigurations[mode] as! NSDictionary
        
        self._apiEndpoint = URL(string: configuration["API-Endpoint"] as! String)!
    }
    
    fileprivate static func getInstance() -> Configuration {
        if self.instance == nil {
            self.instance = Configuration()
        }
        
        return self.instance!
    }
    
    static var apiEndpoint: URL {
        get { return Configuration.getInstance()._apiEndpoint }
    }

}
