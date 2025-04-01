import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var viewModel = SettingsViewModel()
    
    private let darkMode = "Темная тема"
    private let navigationText = "Пользовательское соглашение"
    private let versionInfo = "Версия 1.0 (beta)"
    
    var body: some View {
        VStack {
            
            Toggle(isOn: $themeManager.isDarkMode) {
                Text(darkMode)
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            .padding()
            
            NavigationLink(destination: UserAgreementScreen()) {
                HStack {
                    Text(navigationText)
                    Spacer()
                    Image("Chevron")
                        .accentColor(.ypBlack)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            VStack {
                if viewModel.copyrightText.isEmpty {
                    ProgressView()
                } else {
                    Text(viewModel.copyrightText)
                        .padding()
                }
                Text(versionInfo)
            }
            .font(.system(size: 12))
        }
        .padding(.vertical, 24)
        .foregroundColor(.ypBlack)
        .font(.system(size: 17))
        .generalViewStyle()
        .onAppear {
            Task {
                await viewModel.getCopyrightText()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
            .environmentObject(ThemeManager())
    }
}
