import SwiftUI

struct ScheduleRow: View {
    let schedule: Schedule

    var body: some View {
        VStack {
            HStack(alignment: schedule.transferPoint != nil ? .top : .center) {
                Image(schedule.carrier.logoSvg)
                    .resizable()
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.trailing, 8)

                VStack(alignment: .leading, spacing: 2) {
                    Text(schedule.carrier.title)
                        .font(.system(size: 17))

                    if let transfer = schedule.transferPoint {
                        Text("С пересадкой в \(transfer)")
                            .font(.system(size: 12))
                            .foregroundColor(.ypRed)
                    }
                }

                Spacer()

                Text(schedule.date)
                    .font(.system(size: 12))
                    
            }
            .padding(.bottom)
            .foregroundColor(.ypTotalBlack)

            HStack {
                Text(schedule.departureTime)
                    .font(.system(size: 17))
                    
                Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.ypGray)
                Text(schedule.durationTime)
                    .font(.system(size: 12))
                Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.ypGray)
                Text(schedule.arrivalTime)
                    .font(.system(size: 17))
            }
            .foregroundStyle(.ypTotalBlack)
        }
        .padding()
        .background(.ypLightGray)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    ScheduleRow(schedule: mockSchedule[0])
        .padding()
}
