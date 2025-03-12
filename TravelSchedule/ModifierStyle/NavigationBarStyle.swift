import SwiftUI

struct NavigationBarStyle: ViewModifier {
    var dismissAction: () -> Void

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .font(.system(size: 17, weight: .bold))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismissAction) {
                        Image("Chevron")
                            .foregroundColor(.ypBlack)
                            .rotationEffect(.degrees(180))
                    }
                }
            }
    }
}

extension View {
    func navigationBarStyle(dismissAction: @escaping () -> Void) -> some View {
        self.modifier(NavigationBarStyle(dismissAction: dismissAction))
    }
}
