import SwiftUI

struct TabBarView: View {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var navModel = NavigationModel()
    @StateObject private var filterViewModel = FilterViewModel()
    @StateObject private var mainViewModel = MainViewModel()  // Добавляем MainViewModel
    @StateObject private var citiesViewModel = CitiesViewModel() // Добавляем CitiesViewModel
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
                        .environmentObject(mainViewModel)  // Передаем mainViewModel

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
            .environmentObject(mainViewModel) // Передаем mainViewModel
            .environmentObject(citiesViewModel) // Передаем citiesViewModel
            .navigationDestination(for: ScheduleScreens.self) { screen in
                switch screen {
                case .citiesDeparture:
                    CitiesScreen(isDeparture: true)
                        .environmentObject(navModel)
                        .environmentObject(mainViewModel) // Передаем mainViewModel
                        .environmentObject(citiesViewModel) // Передаем citiesViewModel
                case .stationsDeparture(let city):
                    StationsScreen(city: city, isDeparture: true)
                        .environmentObject(navModel)
                        .environmentObject(mainViewModel) // Передаем mainViewModel
                        .environmentObject(citiesViewModel) // Передаем citiesViewModel
                case .citiesArrival:
                    CitiesScreen(isDeparture: false)
                        .environmentObject(navModel)
                        .environmentObject(mainViewModel) // Передаем mainViewModel
                        .environmentObject(citiesViewModel) // Передаем citiesViewModel
                case .stationsArrival(let city):
                    StationsScreen(city: city, isDeparture: false)
                        .environmentObject(navModel)
                        .environmentObject(mainViewModel) // Передаем mainViewModel
                        .environmentObject(citiesViewModel) // Передаем citiesViewModel
                case .scheduleResult:
                    ScheduleScreen()
                        .environmentObject(navModel)
                        .environmentObject(filterViewModel)
                        .environmentObject(mainViewModel) // Передаем mainViewModel
                case .carrier(let carrier):
                    CarrierScreen(carrier: carrier)
                        .environmentObject(navModel)
                        .environmentObject(mainViewModel) // Передаем mainViewModel
                case .filterSchedule:
                    FilterScheduleScreen()
                        .environmentObject(navModel)
                        .environmentObject(filterViewModel)
                        .environmentObject(mainViewModel) // Передаем mainViewModel
                        .environmentObject(themeManager)
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
