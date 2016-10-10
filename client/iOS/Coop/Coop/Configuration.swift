//
//  Configuration.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

class Configuration {

    static var instance = Configuration()
    private let configurations: NSDictionary
    private let mode = Bundle.main.infoDictionary!["Configuration"] as! String

    let apiEndpoint: URL
    var defaultLocation: Location? {
        willSet(newLocation) {
            (configurations[mode] as! NSDictionary).setValue(newLocation?.name, forKey: "DefaultLocation")
            configurations.write(toFile: "Configuration.plist", atomically: true)
        }
    }

    init() {
        let configurationFile = Bundle.main.path(forResource: "Configuration", ofType: "plist")!
        self.configurations = NSDictionary(contentsOfFile: configurationFile)!

        let configuration = configurations[mode] as! NSDictionary

        apiEndpoint = URL(string: configuration["API-Endpoint"] as! String)!

        if let locationName = configuration["DefaultLocation"] as? String {
            defaultLocation = Location(name: locationName)
        }
    }

}
