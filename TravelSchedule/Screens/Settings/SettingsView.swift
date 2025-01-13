import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Toggle(isOn: $themeManager.isDarkMode) {
                    Text("Темная тема")
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                .padding()
                
                NavigationLink(destination: PrivacyPolicyView()) {
                    HStack {
                        Text("Пользовательское соглашение")
                        Spacer()
                        Image("Chevron")
                            .foregroundColor(.ypBlack)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                VStack {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .padding()
                    Text("Версия 1.0 (beta)")
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
