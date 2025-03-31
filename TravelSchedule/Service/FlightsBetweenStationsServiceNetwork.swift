import Foundation
import OpenAPIURLSession

struct DateFormatterHelper {
    static let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
}

actor FlightsBetweenStationsServiceNetwork: Sendable {
    
    func searchInfo(from: String, to: String) async throws -> [Schedule] {
        guard let serverURL = try? Servers.Server1.url() else {
            return []
        }
        
        let client = Client(
            serverURL: serverURL,
            transport: URLSessionTransport()
        )
        
        let service = FlightsBetweenStationsService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        let search = try await service.getFlightsBetweenStations(
            from: from,
            to: to
        )
        
        let schedule = search.segments?.compactMap { segment -> Schedule? in
            let date = segment.start_date
            let departure = segment.departure
            let arrival = segment.arrival
            let hasTransfers = segment.has_transfers ?? false
            let stops = segment.stops
            let transfersTitle: String? = {
                if hasTransfers, let stops = stops, !stops.isEmpty {
                    return "С пересадкой в \(stops)"
                } else {
                    return nil
                }
            }()
            let duration = segment.duration
            guard let carrier = segment.thread?.carrier else { return nil }
            
            return Schedule(
                date: formatDate(date),
                departureTime: timeToHour(from: departure),
                arrivalTime: timeToHour(from: arrival),
                durationTime: durationToTime(from: duration.map { Int($0) }),
                transferPoint: transfersTitle,
                carrier: Carrier(
                    title: carrier.title ?? "",
                    logoSvg: carrier.logo_svg ?? "",
                    logo: carrier.logo ?? "",
                    email: carrier.email ?? "",
                    phone: carrier.phone ?? ""
                )
            )
        }
        return schedule ?? []
    }
    
    
    private func timeToHour(from: String?) -> String {
        guard let from else { return "" }
        let time = String(from.dropLast(3))
        return time
    }
    
    private func durationToTime(from duration_seconds: Int?) -> String {
        guard let duration = duration_seconds else { return "" }
        let durationDouble = Double(duration)
        guard
            let time = DateFormatterHelper.componentsFormatter.string(from: durationDouble)
        else { return "" }
        return time
    }
    
    private func formatDate(_ input: String?) -> String {
        guard let input = input else { return "" }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "ru_RU")
        
        guard let date = inputFormatter.date(from: input) else { return "" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        
        return outputFormatter.string(from: date)
    }
    
}
