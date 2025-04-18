import Foundation

struct Station: Hashable, Identifiable, Sendable {
    let id = UUID()
    let title: String
    let code: String
}

