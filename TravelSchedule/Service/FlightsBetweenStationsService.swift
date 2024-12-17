import OpenAPIRuntime
import OpenAPIURLSession

typealias FlightsBetweenStations = Components.Schemas.SearchInfo

protocol FlightsBetweenStationsServiceProtocol {
    func getFlightsBetweenStations(from: String, to: String, date: String) async throws -> FlightsBetweenStations
    
}

final class FlightsBetweenStationsService: FlightsBetweenStationsServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getFlightsBetweenStations(from: String, to: String, date: String) async throws -> FlightsBetweenStations {
        
        let response = try await client.getFlightsBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date
        ))
        return try response.ok.body.json
    }
}
