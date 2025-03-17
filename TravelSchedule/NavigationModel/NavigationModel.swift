import SwiftUI

enum ScheduleScreens: Hashable {
    case citiesDeparture
    case stationsDeparture(city: City)
    
    case citiesArrival
    case stationsArrival(city: City)
    
    case scheduleResult
    case carrier(carrier: Carrier)
    case filterSchedule
    
}

final class NavigationModel: ObservableObject {
    @Published var path: [ScheduleScreens] = []
    
    @Published var selectedDeparture: String = ""
    @Published var selectedArrival: String = ""
    
    func open(_ screen: ScheduleScreens) {
        path.append(screen)
    }
    
    func back() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func backToRoot() {
        path.removeAll()
    }
}
