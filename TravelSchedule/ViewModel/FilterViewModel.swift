import SwiftUI

@MainActor
final class FilterViewModel: ObservableObject, Sendable {
    @Published var filteredSchedules: [Schedule] = []
    private var allSchedules: [Schedule] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    @Published var selectedTimes: Set<String> = []
    @Published var showTransfers: Bool? = nil
    
    init() {
        resetFilters()
    }
    
    func loadSchedules(departure: String, arrival: String) async {
        isLoading = true
        isError = false

        let service = FlightsBetweenStationsServiceNetwork()
        
        do {
            let scheduleSearch = try await service.searchInfo(from: departure, to: arrival)
            let sortedSchedule = scheduleSearch.sorted { $0.date < $1.date }
            
            self.allSchedules = sortedSchedule
            self.filteredSchedules = sortedSchedule
            isLoading = false
        } catch {
            self.allSchedules = []
            self.filteredSchedules = []
            isLoading = false
            isError = true
        }
    }

    
    var isFilterApplied: Bool {
        !selectedTimes.isEmpty || showTransfers != nil
    }
    
    
    func applyFilters() {
        if selectedTimes.isEmpty && showTransfers == nil {
            filteredSchedules = allSchedules
            return
        }
        
        filteredSchedules = allSchedules.filter { schedule in
            let isTimeValid = selectedTimes.isEmpty || selectedTimes.contains { timeRange in
                switch timeRange {
                case "Утро 06:00 - 12:00":
                    return isInTimeRange(schedule.departureTime, start: "06:00", end: "12:00")
                case "День 12:00 - 18:00":
                    return isInTimeRange(schedule.departureTime, start: "12:00", end: "18:00")
                case "Вечер 18:00 - 00:00":
                    return isInTimeRange(schedule.departureTime, start: "18:00", end: "00:00")
                case "Ночь 00:00 - 06:00":
                    return isInTimeRange(schedule.departureTime, start: "00:00", end: "06:00")
                default:
                    return false
                }
            }
            
            let isTransferValid = showTransfers == nil || (showTransfers! ? schedule.transferPoint != nil : schedule.transferPoint == nil)
            
            return isTimeValid && isTransferValid
        }
        objectWillChange.send()
    }
    
    
    private func isInTimeRange(_ time: String, start: String, end: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let timeDate = dateFormatter.date(from: time),
              let startDate = dateFormatter.date(from: start),
              let endDate = dateFormatter.date(from: end) else { return false }
        
        if endDate < startDate {
            return timeDate >= startDate || timeDate <= endDate
        } else {
            return timeDate >= startDate && timeDate <= endDate
        }
    }
    
    
    func resetFilters() {
        selectedTimes = []
        showTransfers = nil
        filteredSchedules = allSchedules
    }
}
