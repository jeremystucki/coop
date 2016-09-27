import Foundation
import Core

class CoopAPI {

    let client: HTTPClientWrapper

    init() throws {
        client = try HTTPClientWrapper(baseUrl: "https://themachine.jeremystucki.com")
    }

    func getLocations() -> [String] {
        do {
            let content = try client.request(method: .GET, endpoint: "/api/v1/coop/locations")

            if let locations: [String] = try content?.get("results") {
                return locations
            }
        } catch { }

        return []
    }

    func getMenus(forLocation location: String) -> [Menu] {
        do {
            let content = try client.request(method: .GET, endpoint: "/api/v1/coop/menus/\(location)/\(Date().getTimestampForToday() - 7200)") // Random

            if let results: [Map] = try content?.get("results") {
                return try parseMenus(results)
            }
        } catch { }

        return []
    }

    private func parseMenus(_ menuMaps: [Map]) throws -> [Menu] {
        var menus = [Menu]()

        for menuMap in menuMaps {
            menus.append(try parseMenu(menuMap))
        }

        return menus
    }

    private func parseMenu(_ menuMap: Map) throws -> Menu {
        return Menu(title: try menuMap.get("title"),
                    menu: try menuMap.get("menu"),
                    price: try menuMap.get("price"))
    }
}
