import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var navModel: NavigationModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    @State private var showNoInternet = true
    
    private var placeholderFrom = "Откуда"
    private var placeholderTo = "Куда"
    private let buttonText = "Найти"
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                ZStack {
                    HStack {
                        VStack {
                            Button {
                                navModel.open(.citiesDeparture)
                            } label: {
                                HStack {
                                    if navModel.selectedDeparture.isEmpty {
                                        Text(placeholderFrom)
                                            .foregroundColor(.ypGray)
                                    } else {
                                        Text(navModel.selectedDeparture)
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
                                    if navModel.selectedArrival.isEmpty {
                                        Text(placeholderTo)
                                            .foregroundColor(.ypGray)
                                    } else {
                                        Text(navModel.selectedArrival)
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
            
            if showNoInternet {
                ErrorInternetScreen()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showNoInternet = false
                }
            }
        }
    }
}

#Preview {
    MainScreen()
        .environmentObject(NavigationModel())
}
