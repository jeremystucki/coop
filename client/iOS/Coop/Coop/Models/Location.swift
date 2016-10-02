//
//  Location.swift
//  Coop
//
//  Created by Jeremy Stucki on 13/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

struct Location {
    
    fileprivate let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return name
    }
}
