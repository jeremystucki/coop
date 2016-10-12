//
//  Interactor.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Alamofire


protocol LocationsInteractorInput {
    func fetchLocations()
}


protocol LocationsInteractorOutput {
    func locationsFetched(_ locations: [Location])
}


class LocationsInteractor: LocationsInteractorInput {

    var presenter: LocationsPresenter!
    private let url = Configuration.baseUrl.appendingPathComponent("locations")

    func fetchLocations() {

        Alamofire.request(url).responseJSON { response in

            var locations = [Location]()

            if response.result.isFailure {
                return self.presenter.locationsFetched(locations)
            }

            for locationName in (response.result.value! as! NSDictionary)["results"] as! NSArray {
                locations.append(Location(name: locationName as! String))
            }

            self.presenter.locationsFetched(locations)
        }
    }

}
