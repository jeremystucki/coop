//
//  Menu.swift
//  Coop
//
//  Created by Jeremy Stucki on 11.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation


struct Menu {

    let title: String
    let price: Double
    let dishes: [String]
    let date: Date
    let location: Location
    
}


// This allows the compiler to use whole module optimization
extension Menu: Comparable {

    public static func <(lhs: Menu, rhs: Menu) -> Bool {
        if lhs.title.lowercased() == rhs.title.lowercased() {
            return lhs.price < rhs.price
        }

        return lhs.title.lowercased() < rhs.title.lowercased()
    }

    public static func <=(lhs: Menu, rhs: Menu) -> Bool {
        if lhs.title.lowercased() == rhs.title.lowercased() {
            return lhs.price <= rhs.price
        }

        return lhs.title.lowercased() <= rhs.title.lowercased()
    }

    public static func >=(lhs: Menu, rhs: Menu) -> Bool {
        if lhs.title.lowercased() == rhs.title.lowercased() {
            return lhs.price >= rhs.price
        }

        return lhs.title.lowercased() >= rhs.title.lowercased()
    }

    public static func >(lhs: Menu, rhs: Menu) -> Bool {
        if lhs.title.lowercased() == rhs.title.lowercased() {
            return lhs.price > rhs.price
        }

        return lhs.title.lowercased() > rhs.title.lowercased()
    }

    public static func ==(lhs: Menu, rhs: Menu) -> Bool {
        return lhs.title == rhs.title
            && lhs.price == rhs.price
            && lhs.dishes == rhs.dishes
            && lhs.date == rhs.date
            && lhs.location == rhs.location
    }

}
