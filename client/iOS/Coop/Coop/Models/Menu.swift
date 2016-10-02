//
//  Menu.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

struct Menu {
    
    fileprivate let title: String
    fileprivate let price: Double
    fileprivate let dishes: [String]
    fileprivate let date: Date
    fileprivate let location: Location
    
    init(title: String, price: Double, dishes: [String], date: Date, location: Location) {
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
    
    func getDate() -> Date {
        return date
    }
    
    func getLocation() -> Location {
        return location
    }
}
