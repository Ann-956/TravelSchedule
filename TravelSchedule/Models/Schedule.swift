import Foundation

struct Schedule: Hashable, Identifiable {
    let id = UUID()
    let date: String
    let departureTime: String
    let arrivalTime: String
    let durationTime: String
    let transferPoint: String?
    let carrier: Carrier
}

let mockSchedule: [Schedule] = [
    Schedule(
        date: "14 января",
        departureTime: "22:30",
        arrivalTime: "08:15",
        durationTime: "20 часов",
        transferPoint: "Костроме",
        carrier: mockCarriers[0]
    ),
    Schedule(
        date: "15 января",
        departureTime: "01:15",
        arrivalTime: "09:00",
        durationTime: "9 часов",
        transferPoint: nil,
        carrier: mockCarriers[1]
    ),
    Schedule(
        date: "16 января",
        departureTime: "12:30",
        arrivalTime: "21:00",
        durationTime: "9 часов",
        transferPoint: nil,
        carrier: mockCarriers[2]
    ),
    Schedule(
        date: "17 января",
        departureTime: "22:30",
        arrivalTime: "08:15",
        durationTime: "20 часов",
        transferPoint: "Костроме",
        carrier: mockCarriers[3]
    ),
    Schedule(
        date: "17 января",
        departureTime: "23:00",
        arrivalTime: "09:00",
        durationTime: "20 часов",
        transferPoint: nil,
        carrier: mockCarriers[4]
    ),
]
