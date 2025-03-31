import SwiftUI
import Foundation

struct StationsScreen: View {
    
    private let title = "Выбор станции"
    private let error = "Нет такой станции"
    @State private var searchText = ""
    
    let city: City
    let isDeparture: Bool
    @EnvironmentObject var navModel: NavigationModel
    @EnvironmentObject var mainViewModel: MainViewModel
    
    
    var filteredStations: [Station] {
        if searchText.isEmpty {
            return city.stations
        } else {
            return city.stations.filter { station in
                station.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
            
            if filteredStations.isEmpty {
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
                    ForEach(filteredStations) { station in
                        HStack {
                            Text(station.title)
                                .font(.system(size: 17))
                            Spacer()
                            Image("Chevron")
                        }
                        .padding()
                        .onTapGesture {
                         
                            if isDeparture {
                                mainViewModel.departureStation = station
                                mainViewModel.createDepartureText()
                            } else {
                                mainViewModel.arrivalStation = station
                                mainViewModel.createArrivalText()
                            }
                            navModel.backToRoot()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 16)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle(title)
        .navigationBarStyle(dismissAction: {
            navModel.back()
        })
        .generalViewStyle()
    }
}

#Preview {
    StationsScreen(
        city: mockCyty[0],
        isDeparture: true
    )
    .environmentObject(NavigationModel())
    .environmentObject(MainViewModel())
}
