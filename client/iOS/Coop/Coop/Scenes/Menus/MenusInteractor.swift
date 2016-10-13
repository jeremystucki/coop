//
//  MenusInteractor.swift
//  Coop
//
//  Created by Jeremy Stucki on 13.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Alamofire


protocol MenusInteractorInput {
    func fetchMenus()
}


protocol MenusInteractorOutput {
    func menusFetched(_ menus: [Menu])
}


class MenusInteractor: MenusInteractorInput {

    var presenter: MenusInteractorOutput!
    private let url = Configuration.baseUrl.appendingPathComponent("menus")
    private let location: Location

    init(forLocation location: Location) {
        self.location = location
    }

    func fetchMenus() {

        Alamofire.request(url.appendingPathComponent(location.name)).responseJSON { response in

            var menus = [Menu]()

            if response.result.isFailure {
                self.presenter.menusFetched([Menu]())
            }

            for menu in (response.result.value! as! NSDictionary)["results"] as! NSArray {
                if let menu = self.parseMenu(menu as! NSDictionary) {
                    menus.append(menu)
                }
            }

            self.presenter.menusFetched(menus)
        }
    }

    func parseMenu(_ menu: NSDictionary) -> Menu? {

        guard let title = menu["title"] as? String else {
            return nil
        }

        guard let price = menu["price"] as? Double else {
            return nil
        }

        guard let dishes = menu["menu"] as? [String] else {
            return nil
        }

        guard let date = menu["timestamp"] as? Double else {
            return nil
        }

        return Menu(title: title, price: price, dishes: dishes, date: Date(timeIntervalSince1970: date + 7200), location: location)
    }

}
