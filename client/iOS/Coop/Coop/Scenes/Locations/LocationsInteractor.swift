//
//  LocationsInteractor.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Alamofire


protocol LocationsInteractorInput {
    func fetchLocations()
    func fetchFavoriteLocations(allLocations locations: [Location])
}


protocol LocationsInteractorOutput {
    func locationsFetched(_ locations: [Location])
    func favoriteLocationsFetched(_ favoriteLocations: [Location])
    func connectionErrorOccured()
}


class LocationsInteractor: LocationsInteractorInput {

    var presenter: LocationsInteractorOutput!
    private let url = Configuration.baseUrl.appendingPathComponent("locations")

    func fetchLocations() {
        Alamofire.request(url).responseJSON { response in

            var locations = [Location]()

            if response.result.isFailure {
                return self.presenter.connectionErrorOccured()
            }

            for location in (response.result.value! as! NSDictionary)["results"] as! [NSDictionary] {
                let name = location["name"] as! String
                let id = location["id"] as! Int
                locations.append(Location(name: name, id: id))
            }

            self.presenter.locationsFetched(locations)
        }
    }

    func fetchFavoriteLocations(allLocations locations: [Location]) {
        var favoriteLocations = [Location]()
        for locationName in Configuration.favoriteLocations {
            if let location = locations.first(where: { $0.name == locationName }) {
                favoriteLocations.append(location)
            }
        }

        presenter.favoriteLocationsFetched(favoriteLocations)
    }

}
