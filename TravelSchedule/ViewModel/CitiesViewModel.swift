import SwiftUI

@MainActor
final class CitiesViewModel: ObservableObject, Sendable {
    
    @Published var cities: [City] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isDataLoaded: Bool = false
  
    private let service = StationsListServiceNetwork()
    
    func getCities() async {
        isLoading = true
        isDataLoaded = false
        errorMessage = nil
        
        do {
            let cities = try await service.stationsList()
            let sorted = cities.filter { !$0.stations.isEmpty }
            let sortedCity = sorted.sorted { $0.title < $1.title }
            self.cities = sortedCity
            self.isDataLoaded = true
        } catch {
            self.errorMessage = "ошибка сервера"
            self.cities = []
        }
        isLoading = false
    }
}
