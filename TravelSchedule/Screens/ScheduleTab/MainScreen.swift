import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var navModel: NavigationModel
    @StateObject private var filterViewModel = FilterViewModel()
    
    private var placeholderFrom = "Откуда"
    private var placeholderTo = "Куда"
    private let buttonText = "Найти"
    
    var body: some View {
        NavigationStack(path: $navModel.path) {
            VStack {
                
                Spacer()
                
                ZStack {
                    HStack {
                        VStack {
                            TextField(
                                "",
                                text: $navModel.selectedDeparture,
                                prompt: Text(placeholderFrom)
                                    .foregroundColor(.ypGray)
                            )
                            .padding()
                            .lineLimit(1)
                            .frame(height: 48)
                            .onTapGesture {
                                navModel.open(.citiesDeparture)
                            }
                            
                            TextField(
                                "",
                                text: $navModel.selectedArrival,
                                prompt: Text(placeholderTo)
                                    .foregroundColor(.ypGray)
                            )
                            .padding()
                            .lineLimit(1)
                            .frame(height: 48)
                            .onTapGesture {
                                navModel.open(.citiesArrival)
                            }
                            
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ypTotalWhite)
                        )
                        .font(.system(size: 17))
                        
                        Button(action: {
                            swap(&navModel.selectedDeparture, &navModel.selectedArrival)
                        }) {
                            Image("Change")
                            
                        }
                        .padding(.leading, 10)
                    }
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ypBlue)
                )
                .padding()
                
                if !navModel.selectedDeparture.isEmpty && !navModel.selectedArrival.isEmpty {
                    Button(action: {
                        filterViewModel.resetFilters()
                        navModel.open(.scheduleResult)
                    }) {
                        Text(buttonText)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.ypTotalWhite)
                            .frame(width: 150, height: 60)
                            .background(RoundedRectangle(cornerRadius: 16).fill(.ypBlue))
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .generalViewStyle()
        }
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
                
            case . filterSchedule:
                FilterScheduleScreen()
                    .environmentObject(navModel)
                    .environmentObject(filterViewModel)
            }
        }
        .environmentObject(navModel)
        .environmentObject(filterViewModel)
        
    }
}

#Preview {
    MainScreen()
        .environmentObject(NavigationModel())
}




