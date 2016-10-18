//
//  Configuration.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation


struct Configuration {

    private static let mode = Bundle.main.infoDictionary!["Configuration"] as! String

    private static let confiugrations = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Configuration", ofType: "plist")!)!

    private static let currentConfiguration = confiugrations[mode] as! NSDictionary

    static let baseUrl = URL(string: currentConfiguration["API-Endpoint"] as! String)!

    static var favoriteLocations: Set<String> {
        get { return Set(UserDefaults.standard.stringArray(forKey: "favoriteLocations") ?? []) }
        set(newValue) { UserDefaults.standard.set(Array(newValue), forKey: "favoriteLocations") }
    }

}
