import Foundation
import OpenAPIURLSession


actor CopyrightServiceNetwork: Sendable {
    
    func copyrightList() async throws -> String? {
        guard let serverURL = try? Servers.Server1.url() else {
            return ""
        }
        
        let client = Client(
            serverURL: serverURL,
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

