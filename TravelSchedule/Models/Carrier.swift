import Foundation

struct Carrier: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let logoSvg: String
    let logo: String
    let email: String?
    let phone: String?
}

let mockCarriers: [Carrier] = [
    Carrier(
        title: "РЖД",
        logoSvg: "Rzhd",
        logo: "RzhdFull",
        email: "i.lozgkina@yandex.ru",
        phone: "+7 (904) 329-27-71"
    ),
    Carrier(
        title: "ФГК",
        logoSvg: "FGK",
        logo: "FGK",
        email: "i.lozgkina@yandex.ru",
        phone: "+7 (904) 329-27-71"
    ),
    Carrier(
        title: "Урал логистика",
        logoSvg: "Ural",
        logo: "Ural",
        email: "i.lozgkina@yandex.ru",
        phone: "+7 (904) 329-27-71"
    ),
    Carrier(
        title: "ФГК",
        logoSvg: "FGK",
        logo: "FGK",
        email: "i.lozgkina@yandex.ru",
        phone: "+7 (904) 329-27-71"
    ),
    Carrier(
        title: "Урал логистика",
        logoSvg: "Ural",
        logo: "Ural",
        email: "i.lozgkina@yandex.ru",
        phone: "+7 (904) 329-27-71"
    )
]
