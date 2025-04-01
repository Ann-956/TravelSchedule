import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadStations = Components.Schemas.ThreadStationsResponse

protocol ThreadStationsServiceProtocol {
    func getThreadStations(uid: String) async throws -> ThreadStations
    
}

actor ThreadStationsService: ThreadStationsServiceProtocol, Sendable{
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThreadStations(uid: String) async throws -> ThreadStations {
        
        let response = try await client.getThreadStations(query: .init(
            apikey: apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}
