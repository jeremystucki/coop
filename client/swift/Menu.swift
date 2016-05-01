//
//  main.swift
//  Coop
//
//  Created by Jeremy Stucki on 01/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

struct Menu {

    private let title: String
    private let menu: [String]
    private let price: Double
    private let location: String
    private let timestamp: Int

    init(title: String, menu: [String], price: Double, location: String, timestamp: Int) {
        self.title = title
        self.menu = menu
        self.price = price
        self.location = location
        self.timestamp = timestamp
    }

    var description: String {
        var result = "\(title.bold) \(String(price).bold.blue)\n"

        for item in menu {
            result += "- \(item)\n"
        }

        return result
    }
}
