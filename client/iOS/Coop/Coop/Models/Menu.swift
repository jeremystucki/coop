//
//  Menu.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

struct Menu {
    
    private let title: String
    private let price: Double
    private let dishes: [String]
    private let date: NSDate
    private let location: Location
    
    init(title: String, price: Double, dishes: [String], date: NSDate, location: Location) {
        self.title = title
        self.price = price
        self.dishes = dishes
        self.date = date
        self.location = location
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getPrice() -> Double {
        return price
    }
    
    func getDishes() -> [String] {
        return dishes
    }
    
    func getDate() -> NSDate {
        return date
    }
    
    func getLocation() -> Location {
        return location
    }
}
