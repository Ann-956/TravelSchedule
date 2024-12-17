import OpenAPIRuntime
import OpenAPIURLSession

typealias InfoCarrier = Components.Schemas.CarrierResponse

protocol InfoCarrierServiceProtocol {
    func getInfoCarrier(code: Int) async throws -> InfoCarrier
}

final class InfoCarrierService: InfoCarrierServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getInfoCarrier(code: Int) async throws -> InfoCarrier {
        let response = try await client.getInfoCarrier(query: .init(
            apikey: apikey,
            code: code
        ))
        return try response.ok.body.json
    }
}
