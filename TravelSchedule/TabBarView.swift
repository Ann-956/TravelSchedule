import SwiftUI

struct TabBarView: View {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var navModel = NavigationModel()
    @StateObject private var filterViewModel = FilterViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack(path: $navModel.path) {
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
            .environmentObject(filterViewModel)
            .navigationDestination(for: ScheduleScreens.self) { screen in
                switch screen {
                case .citiesDeparture:
                    CitiesScreen(isDeparture: true)
                        .environmentObject(navModel)
                case .stationsDeparture(let city):
                    StationsScreen(city: city, isDeparture: true)
                        .environmentObject(navModel)
                case .citiesArrival:
                    CitiesScreen(isDeparture: false)
                        .environmentObject(navModel)
                case .stationsArrival(let city):
                    StationsScreen(city: city, isDeparture: false)
                        .environmentObject(navModel)
                case .scheduleResult:
                    ScheduleScreen()
                        .environmentObject(navModel)
                        .environmentObject(filterViewModel)
                case .carrier(let carrier):
                    CarrierScreen(carrier: carrier)
                        .environmentObject(navModel)
                case .filterSchedule:
                    FilterScheduleScreen()
                        .environmentObject(navModel)
                        .environmentObject(filterViewModel)
                        .environmentObject(themeManager)
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
