//
//  PrettyString.swift
//  Coop
//
//  Created by Jeremy Stucki on 01/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

extension String {
    
    var bold: String {
        return "\u{001B}[1m\(self)\u{001B}[0m"
    }

    var blue: String {
        return "\u{001B}[36m\(self)\u{001B}[0m"
    }
    
}
