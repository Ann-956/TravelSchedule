import SwiftUI

struct TabBarView: View {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                NavigationStack {
                    ScheduleView()
                }
                .tabItem {
                    Image("Schedule")
                }
                
                NavigationStack {
                    SettingsView()
                }
                .tabItem {
                    Image("Settings")
                }
            }
            .foregroundColor(themeManager.isDarkMode ? .ypBlack : .ypWhite)
            .accentColor(themeManager.isDarkMode ? .ypWhite : .ypBlack)
            .environmentObject(themeManager)
            
            Divider()
                .background(.ypGray)
                .frame(height: 1)
                .padding(.bottom, 49)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
