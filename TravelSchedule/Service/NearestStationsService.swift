
import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations

struct NearestStationsServiceRequest {
    let lat: Double
    let lng: Double
    let distance: Int
    let stationTypes: String
    let transportTypes: String
}

protocol NearestStationsServiceProtocol {
    func getNearestStations(request: NearestStationsServiceRequest) async throws -> NearestStations
}

actor NearestStationsService: NearestStationsServiceProtocol, Sendable {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestStations(request: NearestStationsServiceRequest) async throws -> NearestStations {
        
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: request.lat,
            lng: request.lng,
            distance: request.distance,
            station_types: request.stationTypes,
            transport_types: request.transportTypes
        ))
        return try response.ok.body.json
    }
}
