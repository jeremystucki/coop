//
//  Coop.swift
//  Coop
//
//  Created by Jeremy Stucki on 01/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation
import Darwin

class Coop {

    private let apiManager: APIManager

    init(baseURL: String) {
        self.apiManager = APIManager(baseURL: baseURL)
    }

    func runWithArguments(arguments: [String]) {
        
        if arguments.count == 1 {
            usage()
            exit(1)
        }

        let menus = self.apiManager.getMenusForLocation(arguments[1], timestamp: NSDate().getTimestampForToday())

        for menu in menus {
            print(menu.description)
        }
    }

    func usage() {
        print("\nUsage")
        print("  coop <location>\n")
    }
}
