import SwiftUI

struct GeneralViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.ypBlack)
            .background(.ypWhite)
    }
}

extension View {
    func generalViewStyle() -> some View {
        self.modifier(GeneralViewStyle())
    }
}
