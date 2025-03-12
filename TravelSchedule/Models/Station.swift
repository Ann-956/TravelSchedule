import Foundation

struct Station: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let code: String
}

