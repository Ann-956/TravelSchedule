import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol  {
    func getCopyrightYandex() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyrightYandex() async throws -> Copyright {
        let response = try await client.getCopyrightYandex(query: .init(
            apikey: apikey
        ))
        
        return try response.ok.body.json
    }
}
