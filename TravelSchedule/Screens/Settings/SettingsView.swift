import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var userAgreementURL = "https://yandex.ru/legal/practicum_offer"
    
    private let darkMode = "Темная тема"
    private let navigationText = "Пользовательское соглашение"
    private let apiDescription = "Приложение использует API «Яндекс.Расписания»"
    private let versionInfo = "Версия 1.0 (beta)"
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Toggle(isOn: $themeManager.isDarkMode) {
                    Text(darkMode)
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                .padding()
                
                NavigationLink(destination: UserAgreementView(urlString: $userAgreementURL)) {
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
                    Text(apiDescription)
                        .padding()
                    Text(versionInfo)
                }
                .font(.system(size: 12))
            }
            .padding(.vertical, 24)
            .foregroundColor(.ypBlack)
            .font(.system(size: 17))
            .background(.ypWhite)
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ThemeManager())
    }
}
