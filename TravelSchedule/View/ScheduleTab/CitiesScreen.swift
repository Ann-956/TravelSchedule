import SwiftUI

struct CitiesScreen: View {
    @State private var searchText = ""
    @EnvironmentObject var navModel: NavigationModel
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var citiesViewModel: CitiesViewModel
    
    private let title = "Выбор города"
    private let error = "Город не найден"
    
    let isDeparture: Bool
    
    var filteredCities: [City] {
        if searchText.isEmpty {
            return citiesViewModel.cities
        } else {
            let filtered = citiesViewModel.cities.filter { city in
                city.title.lowercased().contains(searchText.lowercased())
            }
            return filtered
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                if citiesViewModel.isLoading {
                    ProgressView()
                } else if citiesViewModel.errorMessage != nil {
                    ErrorServerScreen()
                } else {
                    SearchBar(searchText: $searchText)
                    if filteredCities.isEmpty {
                        VStack {
                            Spacer()
                            Text(error)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.ypBlack)
                                .frame(alignment: .center)
                        }
                    }
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(filteredCities) { city in
                                HStack {
                                    Text(city.title)
                                        .font(.system(size: 17))
                                    
                                    Spacer()
                                    
                                    Image("Chevron")
                                }
                                .padding()
                                .onTapGesture {
                                    if isDeparture {
                                        navModel.open(.stationsDeparture(city: city))
                                        mainViewModel.departureCity = city
                                    } else {
                                        navModel.open(.stationsArrival(city: city))
                                        mainViewModel.arrivalCity = city
                                    }
                                }
                            }
                        }
                        .padding(.top, 16)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .refreshable {
                        await citiesViewModel.getCities()
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarStyle(dismissAction: {
                navModel.back()
            })
            .navigationTitle(title)
            .generalViewStyle()
            .onAppear {
                if citiesViewModel.cities.isEmpty {
                    Task {
                        await citiesViewModel.getCities()
                    }
                }
            }
        }
    }
}
#Preview {
    CitiesScreen(
        isDeparture: true
    )
    .environmentObject(NavigationModel())
}
