//
//  ApiManager.swift
//  Coop
//
//  Created by Jeremy Stucki on 13/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Alamofire

class ApiManager {
    
    let baseUrl: NSURL = Configuration.apiEndpoint
    
    func fetchLocations(callback: ([Location]) -> Void) {
        
        Alamofire.request(.GET, "\(baseUrl)/locations").responseJSON { (completionHandler) in
        
            if completionHandler.result.isSuccess && completionHandler.response?.statusCode == 200 {
                self.handleLocationsResponse(completionHandler.result.value!, callback: callback)
                return
            }
            
            callback([Location]())
        }
    }
    
    func handleLocationsResponse(data: AnyObject, callback: ([Location] -> Void)) {
        var locations = [Location]()
        
        for location in (data as! NSDictionary)["results"] as! NSArray {
            locations.append(Location(name: location as! String))
        }
        
        callback(locations)
    }
    
    func fetchMenus(location: Location, callback: ([Menu]) -> Void) {
        
        let url = "\(baseUrl)/menus/\(location.getName().stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!)"
        
        Alamofire.request(.GET, url).responseJSON { (completionHandler) in
            
            if completionHandler.result.isSuccess && completionHandler.response?.statusCode == 200 {
                return self.handleMenusResponse(completionHandler.result.value!, location: location, callback: callback)
            }
            
            callback([Menu]())
        }
    }
    
    func handleMenusResponse(data: AnyObject, location: Location, callback: ([Menu]) -> Void) {
        var menus = [Menu]()
        
        for menu in (data as! NSDictionary)["results"] as! NSArray {
            menus.append(Menu(
                title: menu["title"] as! String,
                price: menu["price"] as! Double,
                dishes: menu["menu"] as! [String],
                date: NSDate(timeIntervalSince1970: menu["timestamp"] as! Double + 7200),
                location: location))
        }
        
        callback(menus)
    }
}
