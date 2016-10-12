//
//  Location.swift
//  Coop
//
//  Created by Jeremy Stucki on 11.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

struct Location {

    let name: String

}


extension Location: Comparable {

    public static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name
    }

    public static func <(lhs: Location, rhs: Location) -> Bool {
        return lhs.name < rhs.name
    }

    public static func <=(lhs: Location, rhs: Location) -> Bool {
        return lhs.name <= rhs.name
    }

    public static func >=(lhs: Location, rhs: Location) -> Bool {
        return lhs.name >= rhs.name
    }

    public static func >(lhs: Location, rhs: Location) -> Bool {
        return lhs.name > rhs.name
    }

}
