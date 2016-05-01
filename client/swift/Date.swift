//
//  Date.swift
//  Coop
//
//  Created by Jeremy Stucki on 01/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

extension NSDate {
    
    func getTimestampForToday() -> Int {
        let date = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
        return Int(date.timeIntervalSince1970)
    }

}
