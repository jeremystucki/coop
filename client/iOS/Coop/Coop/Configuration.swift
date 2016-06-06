//
//  Configuration.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

class Configuration {
    
    private static var instance: Configuration?
    
    private let _apiEndpoint: NSURL
    
    init() {
        let mode = NSBundle.mainBundle().infoDictionary!["Configuration"] as! String
        
        let configurationFile = NSBundle.mainBundle().pathForResource("Configuration", ofType: "plist")!
        let allConfigurations = NSDictionary(contentsOfFile: configurationFile)!
        let configuration = allConfigurations[mode] as! NSDictionary
        
        self._apiEndpoint = NSURL(string: configuration["API-Endpoint"] as! String)!
    }
    
    private static func getInstance() -> Configuration {
        if self.instance == nil {
            self.instance = Configuration()
        }
        
        return self.instance!
    }
    
    static var apiEndpoint: NSURL {
        get { return Configuration.getInstance()._apiEndpoint }
    }

}
