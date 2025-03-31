import Foundation
import OpenAPIURLSession


actor CopyrightServiceNetwork: Sendable {
    
    func copyrightList() async throws -> String? {
        guard (try? Servers.Server1.url()) != nil else { return "" }
        
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = CopyrightService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        let copyright = try await service.getCopyrightYandex()
        return copyright.copyright?.text
    }
}

