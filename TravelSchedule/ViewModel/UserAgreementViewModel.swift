import SwiftUI

@MainActor
final class UserAgreementViewModel: ObservableObject, Sendable {
    @Published var isLoading: Bool = true
    @Published var isError: Bool = false
    let urlString = Constants.urlString
    
    func setError(_ error: Bool) {
        isLoading = false
        isError = error
    }
    
    func setLoading() {
        isLoading = true
        isError = false
    }
    
    func setLoaded() {
        isLoading = false
    }
}
