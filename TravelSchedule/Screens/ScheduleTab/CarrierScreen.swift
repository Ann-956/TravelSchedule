import SwiftUI

struct CarrierScreen: View {
    let carrier: Carrier
    private let navigationTitle = "Информация о перевозчике"
    private let emailText = "E-mail"
    private let phoneText = "Телефон"
    @EnvironmentObject var navModel: NavigationModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Image(carrier.logo)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 104)

                .cornerRadius(24)
                .padding(.vertical, 16)
            
            VStack(alignment: .leading) {
                Text(carrier.title)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom, 16)
                
                if let email = carrier.email {
                    VStack(alignment: .leading) {
                        Text(emailText)
                            .font(.system(size: 17))
                        Text(email)
                            .font(.system(size: 12))
                            .foregroundColor(.ypBlue)
                    }
                    .padding(.bottom, 16)
                }
                
                if let phone = carrier.phone {
                    VStack(alignment: .leading) {
                        Text(phoneText)
                            .font(.system(size: 17))
                        Text(phone)
                            .font(.system(size: 12))
                            .foregroundColor(.ypBlue)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        
        .navigationBarTitle(navigationTitle, displayMode: .inline)
        .generalViewStyle()
        .navigationBarStyle(dismissAction: {
            navModel.back()
        })
    }
}

#Preview {
    CarrierScreen(carrier: mockCarriers[0])
        .environmentObject(NavigationModel())
}
