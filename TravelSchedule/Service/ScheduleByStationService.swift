import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleByStation = Components.Schemas.StationScheduleResponse

protocol ScheduleByStationServiceProtocol {
    func getScheduleByStation(station: String, date: String) async throws -> ScheduleByStation
    
}

final class ScheduleByStationService: ScheduleByStationServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleByStation(station: String, date: String) async throws -> ScheduleByStation {
        
        let response = try await client.getScheduleByStation(query: .init(
            apikey: apikey,
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }
}
