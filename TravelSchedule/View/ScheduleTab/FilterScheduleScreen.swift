import SwiftUI

struct FilterScheduleScreen: View {
    @EnvironmentObject var navModel: NavigationModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    private let textTitleTime = "Время отправления"
    private let textTransfers = "Показывать варианты с пересадками"
    private let textButton = "Применить"
    
    private let timeOptions = [
        "Утро 06:00 - 12:00",
        "День 12:00 - 18:00",
        "Вечер 18:00 - 00:00",
        "Ночь 00:00 - 06:00"
    ]
    private let pointOptions = ["Да", "Нет"]
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                Text(textTitleTime)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
                
                ForEach(timeOptions, id: \.self) { timeOption in
                    HStack {
                        Button(action: {
                            toggleTimeSelection(timeOption)
                        }) {
                            HStack {
                                Text(timeOption)
                                    .foregroundColor(.ypBlack)
                                    .font(.system(size: 17))
                                
                                Spacer()
                                
                                Image(filterViewModel.selectedTimes.contains(timeOption) ?
                                      (themeManager.isDarkMode ? "ExcludeTabWhite" : "ExcludeTab") :
                                      (themeManager.isDarkMode ? "ExcludeWhite" : "Exclude"))
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .padding(.bottom, 16)
            
            VStack(alignment: .leading) {
                Text(textTransfers)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                ForEach(pointOptions, id: \.self) { option in
                    HStack {
                        Button(action: {
                            toggleTransferSelection(option)
                        }) {
                            HStack {
                                Text(option)
                                    .foregroundColor(.ypBlack)
                                    .font(.system(size: 17))
                                
                                Spacer()
                                
                                Image(filterViewModel.showTransfers == (option == "Да") ?
                                      (themeManager.isDarkMode ? "CircleTabWhite" : "СircleTab") :
                                      (themeManager.isDarkMode ? "СircleWhite" : "Сircle"))
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            
            Spacer()
            
            Button(action: {
                filterViewModel.applyFilters()
                navModel.back()
            }) {
                Text(textButton)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.ypTotalWhite)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.ypBlue))
            }
        }
        .padding()
        .generalViewStyle()
        .navigationBarStyle(dismissAction: {
            navModel.back()
        })
    }
    
    private func toggleTimeSelection(_ timeOption: String) {
        if filterViewModel.selectedTimes.contains(timeOption) {
            filterViewModel.selectedTimes.remove(timeOption)
        } else {
            filterViewModel.selectedTimes.insert(timeOption)
        }
    }
    
    private func toggleTransferSelection(_ option: String) {
        if (option == "Да" && filterViewModel.showTransfers == true) ||
            (option == "Нет" && filterViewModel.showTransfers == false) {
            filterViewModel.showTransfers = nil
        } else {
            filterViewModel.showTransfers = (option == "Да")
        }
    }
}

#Preview {
    FilterScheduleScreen()
        .environmentObject(NavigationModel())
        .environmentObject(FilterViewModel())
        .environmentObject(ThemeManager())
}
