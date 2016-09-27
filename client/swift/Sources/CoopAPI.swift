class CoopAPI {

    let client: HTTPClientWrapper

    init() throws {
        client = try HTTPClientWrapper(baseUrl: "https://themachine.jeremystucki.com")
    }

    func getLocations() -> [String] {
        do {
            let content = try client.request(method: .GET, endpoint: "api/v1/coop/locations")

            if let locations: [String] = try content?.get("results") {
                return locations
            }
        } catch { }

        return []
    }
}
