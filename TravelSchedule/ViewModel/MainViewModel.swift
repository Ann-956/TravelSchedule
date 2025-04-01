import SwiftUI

@MainActor
final class MainViewModel: ObservableObject, Sendable {
    
    @Published var departureCity: City?
    @Published var arrivalCity: City?
    @Published var departureStation: Station?
    @Published var arrivalStation: Station?
    
    @Published var selectedDeparture: String = ""
    @Published var selectedArrival: String = ""
  
    func createDepartureText() {
        if let departureCity = departureCity,
           let departureStation = departureStation {
            self.selectedDeparture = departureCity.title + " (\(departureStation.title))"
        }
    }
    
    func createArrivalText() {
        if let arrivalCity = arrivalCity,
           let arrivalStation = arrivalStation {
            self.selectedArrival = arrivalCity.title + " (\(arrivalStation.title))"
        }
    }

    func swapStations() {
        swap(&departureCity, &arrivalCity)
        swap(&departureStation, &arrivalStation)
        swap(&selectedDeparture, &selectedArrival)
    }
    
    func getStationCodes() -> (from: String, to: String)? {
        guard let fromCode = departureStation?.code,
              let toCode = arrivalStation?.code else { return nil }
        return (fromCode, toCode)
    }
}
