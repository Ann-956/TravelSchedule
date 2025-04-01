import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject, Sendable {
    
    private let service = CopyrightServiceNetwork()
    private let mockCopyrightText = "Приложение использует API «Яндекс.Расписания»"
    
    @Published var copyrightText: String = ""
    
    func getCopyrightText() async {
        do {
            guard let text = try await service.copyrightList() else { return }
            self.copyrightText = text
        } catch {
            self.copyrightText = mockCopyrightText
        }
    }
    
}

