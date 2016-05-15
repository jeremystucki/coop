//
//  CompareDate.swift
//  Coop
//
//  Created by Jeremy Stucki on 15/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.isEqualToDate(rhs)
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSinceDate(rhs) < 0
}

extension NSDate: Comparable { }
