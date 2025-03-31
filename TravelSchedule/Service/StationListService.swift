import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

typealias StationList = Components.Schemas.StationListResponse

protocol StationListServiceProtocol  {
    func getStationList() async throws -> StationList
}

actor StationListService: StationListServiceProtocol, Sendable {
    
    private let client: Client
    private let apikey: String
    private let limit = 1024 * 1024 * 50
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationList() async throws -> StationList {
        let response = try await client.getStationList(query: .init(
            apikey: apikey
        ))
        
        let body = try response.ok.body.html
        let data = try await Data(collecting: body, upTo: limit)
        let list = try JSONDecoder().decode(StationList.self, from: data)
        return list
    }
}
