import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var navModel: NavigationModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    
    private var placeholderFrom = "Откуда"
    private var placeholderTo = "Куда"
    private let buttonText = "Найти"
    
    var body: some View {
        ZStack {
            VStack {
                StoriesCollectionView()
                    .padding(.bottom, 20)
                
                ZStack {
                    HStack {
                        VStack {
                            Button {
                                navModel.open(.citiesDeparture)
                            } label: {
                                HStack {
                                    if mainViewModel.selectedDeparture.isEmpty {
                                        Text(placeholderFrom)
                                            .foregroundColor(.ypGray)
                                    } else {
                                        Text(mainViewModel.selectedDeparture)
                                            .foregroundColor(.ypTotalBlack)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .lineLimit(1)
                                .frame(height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.ypTotalWhite)
                                )
                            }
                            
                            Button {
                                navModel.open(.citiesArrival)
                            } label: {
                                HStack {
                                    if mainViewModel.selectedArrival.isEmpty {
                                        Text(placeholderTo)
                                            .foregroundColor(.ypGray)
                                    } else {
                                        Text(mainViewModel.selectedArrival)
                                            .foregroundColor(.ypTotalBlack)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .lineLimit(1)
                                .frame(height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.ypTotalWhite)
                                )
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.ypTotalWhite)
                        )
                        .font(.system(size: 17))
                        
                        Button(action: {
                            mainViewModel.swapStations()
                        }) {
                            Image("Change")
                        }
                        .padding(.leading, 10)
                    }
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.ypBlue)
                )
                .padding(.horizontal, 16)
                
            
                if !mainViewModel.selectedDeparture.isEmpty && !mainViewModel.selectedArrival.isEmpty {
                    Button(action: {
                        filterViewModel.resetFilters()
                        navModel.open(.scheduleResult)
                    }) {
                        Text(buttonText)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.ypTotalWhite)
                            .frame(width: 150, height: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.ypBlue)
                            )
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                Spacer()
            }
            .generalViewStyle()
        }
    }
}

#Preview {
    MainScreen()
        .environmentObject(NavigationModel())
}
