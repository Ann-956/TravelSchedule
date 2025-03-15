import SwiftUI

struct CitiesScreen: View {
    let cities = mockCyty
    private let title = "Выбор города"
    private let error = "Город не найден"
    @State private var searchText = ""
    @State private var showNoServer = true
    @EnvironmentObject var navModel: NavigationModel
    
    let isDeparture: Bool
    
    var filteredCities: [City] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { city in
                city.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
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
                                } else {
                                    navModel.open(.stationsArrival(city: city))
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 16)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarStyle(dismissAction: {
                navModel.back()
            })
            .navigationTitle(title)
            .generalViewStyle()
            
            
            if showNoServer {
                ErrorServerScreen()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showNoServer = false
                }
            }
        }
    }
}
#Preview {
    CitiesScreen(isDeparture: true)
        .environmentObject(NavigationModel())
}
