import SwiftUI

struct TabBarView: View {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var navModel = NavigationModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack() {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    
                    MainScreen()
                        .tabItem {
                            Image("Schedule")
                        }
                        .tag(0)
                    
                    SettingsScreen()
                    
                        .tabItem {
                            Image("Settings")
                        }
                        .tag(1)
                }
                .accentColor(.ypBlack)
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
                .edgesIgnoringSafeArea(.bottom)
                
                if !themeManager.isDarkMode {
                    Divider()
                        .background(.ypGray)
                        .padding(.bottom, 54)
                }
            }
            .environmentObject(navModel)
        }
    }
}

#Preview {
    TabBarView()
}
