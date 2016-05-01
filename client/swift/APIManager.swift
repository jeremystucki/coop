//
//  main.swift
//  Coop
//
//  Created by Jeremy Stucki on 01/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation
import Darwin

class APIManager {

    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func getMenusForLocation(location: String, timestamp: Int) -> [Menu] {

        let url = NSURL(string: "\(baseURL)/menus/\(location)/\(timestamp)")!
        let data = NSData(contentsOfURL: url)

        if data == nil {
            print("no data retrieved")
            exit(1)
        }

        let json = parseJSON(data!)

        if (json["results"] as! NSArray).count == 0 {
            print("no menus found")
            exit(0)
        }

        var menus = [Menu]()

        for menuJSON in json["results"] as! NSArray {
            menus.append(Menu(
                title: menuJSON["title"] as! String,
                menu: menuJSON["menu"] as! [String],
                price: menuJSON["price"] as! Double,
                location: location,
                timestamp: timestamp
            ))
        }

        return menus
    }

    private func parseJSON(data: NSData) -> NSDictionary {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)

            if let dict = json as? NSDictionary {
                return dict
            }
        } catch { }

        print("invalid data received")
        exit(1)
    }
}
