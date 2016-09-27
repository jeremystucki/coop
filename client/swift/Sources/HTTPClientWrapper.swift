import HTTPClient
import Core

class HTTPClientWrapper {

    enum HTTPClientError: Error {
        case invalidUrlError
    }

    enum RequestMethod {
        case GET
    }

    let httpClient: Client
    let contentNegotiation = ContentNegotiationMiddleware(mediaTypes: [JSON.self], mode: .client)

    init(baseUrl: URL) throws {
        httpClient = try Client(url: baseUrl)
    }

    convenience init(baseUrl: String) throws {
        guard let url = URL(string: baseUrl) else {
            throw HTTPClientError.invalidUrlError
        }

        try self.init(baseUrl: url)
    }

    func request(method: RequestMethod, endpoint: String) throws -> Map? {
        return try httpClient.get(endpoint, middleware: [contentNegotiation]).content
    }
}
