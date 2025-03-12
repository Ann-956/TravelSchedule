import SwiftUI

struct ScheduleScreen: View {
    
    @EnvironmentObject var navModel: NavigationModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    
    private let textButton = "Уточнить время"
    private let errorText = "Вариантов нет"
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(navModel.selectedDeparture) → \(navModel.selectedArrival)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    LazyVStack(spacing: 8) {
                        
                        if filterViewModel.filteredSchedules.isEmpty {
                            Spacer()
                            Text(errorText)
                                .font(.system(size: 24, weight: .bold))
                        } else {
                            
                            ForEach(filterViewModel.filteredSchedules) { schedule in
                                Button(action: {
                                    navModel.open(.carrier(carrier: schedule.carrier))
                                }) {
                                    ScheduleRow(schedule: schedule)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 68)
                }
                .scrollIndicators(.hidden)
            }
            
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
                .padding(.bottom, 0)
            }
        }
        .padding()
        .generalViewStyle()
        .navigationBarStyle(dismissAction: {
            navModel.back()
        })
        .onAppear {
            filterViewModel.applyFilters()
        }
    }
}


#Preview {
    ScheduleScreen()
        .environmentObject(NavigationModel())
        .environmentObject(FilterViewModel())
}
