import SwiftUI
import Foundation

struct StationsScreen: View {
    
    private let title = "Выбор станции"
    private let error = "Нет такой станции"
    @State private var searchText = ""
    
    let city: City
    let isDeparture: Bool
    @EnvironmentObject var navModel: NavigationModel
    
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
                            let result = city.title + " (" + station.title + ")"
                            if isDeparture {
                                navModel.selectedDeparture = result
                            } else {
                                navModel.selectedArrival = result
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
}
