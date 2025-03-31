import Foundation


struct City: Hashable, Identifiable, Sendable {
    let id = UUID()
    let title: String
    let stations: [Station]
}

let mockCyty: [City] = [
    City(
        title: "Москва",
        stations: [
            Station(title: "Киевский вокзал", code: ""),
            Station(title: "Курский вокзал", code: ""),
            Station(title: "Ярославский вокзал", code: ""),
            Station(title: "Белорусский вокзал", code: ""),
            Station(title: "Савеловский вокзал", code: ""),
            Station(title: "Ленинградский вокзал", code: "")
        ]
    ),
    City(
        title: "Санкт Петербург",
        stations: [
            Station(title: "Балтийский вокзал", code: ""),
            Station(title: "Московский вокзал", code: "")
        ]
    ),
    City(
        title: "Сочи",
        stations: [
            Station(title: "Вокзал Сочи", code: "")
        ]
    ),
    City(
        title: "Горный воздух",
        stations: [
            Station(title: "Горный Воздух", code: "")
        ]
    ),
    City(
        title: "Краснодар",
        stations: [
            Station(title: "Краснодарский вокзал", code: ""),
        ]
    ),
    City(
        title: "Казань",
        stations: [
            Station(title: "Казань-Пасс.", code: "")
        ]
    ),
]

