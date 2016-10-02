//
//  ApiManager.swift
//  Coop
//
//  Created by Jeremy Stucki on 13/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Alamofire

class ApiManager {
    
    let baseUrl: URL = Configuration.apiEndpoint
    
    func fetchLocations(_ callback: @escaping ([Location]) -> Void) {
        
        Alamofire.request("\(baseUrl)/locations").responseJSON { (completionHandler) in
        
            if completionHandler.result.isSuccess && completionHandler.response?.statusCode == 200 {
                self.handleLocationsResponse(completionHandler.result.value! as AnyObject, callback: callback)
                return
            }
            
            callback([Location]())
        }
    }
    
    func handleLocationsResponse(_ data: AnyObject, callback: (([Location]) -> Void)) {
        var locations = [Location]()
        
        for location in (data as! NSDictionary)["results"] as! NSArray {
            locations.append(Location(name: location as! String))
        }
        
        callback(locations)
    }
    
    func fetchMenus(_ location: Location, callback: @escaping ([Menu]) -> Void) {
        
        let url = "\(baseUrl)/menus/\(location.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
        
        Alamofire.request(url).responseJSON { (completionHandler) in
            
            if completionHandler.result.isSuccess && completionHandler.response?.statusCode == 200 {
                return self.handleMenusResponse(completionHandler.result.value! as AnyObject, location: location, callback: callback)
            }
            
            callback([Menu]())
        }
    }
    
    func handleMenusResponse(_ data: AnyObject, location: Location, callback: ([Menu]) -> Void) {
        var menus = [Menu]()
        
        for menu in (data as! NSDictionary)["results"] as! NSArray {
            menus.append(Menu(
                title: (menu as! NSDictionary)["title"] as! String,
                price: (menu as! NSDictionary)["price"] as! Double,
                dishes: (menu as! NSDictionary)["menu"] as! [String],
                date: Date(timeIntervalSince1970: (menu as! NSDictionary)["timestamp"] as! Double + 7200),
                location: location))
        }
        
        callback(menus)
    }
}
