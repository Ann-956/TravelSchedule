import SwiftUI

struct TabBarView: View {
    @StateObject private var themeManager = ThemeManager()
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                
                ScheduleView()
                    .tabItem {
                        Image("Schedule")
                            .renderingMode(.template)
                    }
                    .tag(0)
                
                SettingsView()
                    .tabItem {
                        Image("Settings")
                            .renderingMode(.template)
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
                    .frame(height: 1)
                    .padding(.bottom, 49)
            }
        }
        .background(.ypWhite)
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
