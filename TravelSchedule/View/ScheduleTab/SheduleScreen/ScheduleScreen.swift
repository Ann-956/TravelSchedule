import SwiftUI

struct ScheduleScreen: View {
    
    @EnvironmentObject var navModel: NavigationModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    
    private let textButton = "Уточнить время"
    private let errorText = "Вариантов нет"
    
    var body: some View {
        ZStack {
            if filterViewModel.isLoading {
                ProgressView()
            } else if filterViewModel.isError {
                ErrorServerScreen()
            } else {
                VStack {
                    Text("\(mainViewModel.selectedDeparture) → \(mainViewModel.selectedArrival)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.ypBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if filterViewModel.filteredSchedules.isEmpty {
                        VStack {
                            Spacer()
                            Text(errorText)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.ypBlack)
                                .frame(alignment: .center)
                        }
                        
                    }
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(filterViewModel.filteredSchedules) { schedule in
                                Button(action: {
                                    navModel.open(.carrier(carrier: schedule.carrier))
                                }) {
                                    ScheduleRow(schedule: schedule)
                                }
                            }
                        }
                        .padding(.bottom, 68)
                    }
                    .scrollIndicators(.hidden)
                    
                }
                .clipShape(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 0, bottomLeading: 24, bottomTrailing: 24, topTrailing: 0), style: .continuous))
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        navModel.open(.filterSchedule)
                    }) {
                        HStack {
                            Text(textButton)
                                .foregroundColor(.ypTotalWhite)
                                .font(.system(size: 17, weight: .bold))
                            
                            if filterViewModel.isFilterApplied {
                                Circle()
                                    .fill(.ypRed)
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(.ypBlue)
                        .cornerRadius(16)
                    }
                    .padding(.bottom, 3)
                }
            }
        }
        .padding()
        .generalViewStyle()
        .navigationBarStyle(dismissAction: {
            navModel.back()
        })
        
        .onAppear {
            Task {
                if let stationCodes = mainViewModel.getStationCodes() {
                    await filterViewModel.loadSchedules(
                        departure: stationCodes.from,
                        arrival: stationCodes.to
                    )
                } else {
                    filterViewModel.isError = true
                }
            }
            
        }
    }
}


#Preview {
    ScheduleScreen()
        .environmentObject(NavigationModel())
        .environmentObject(FilterViewModel())
}
