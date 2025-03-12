import SwiftUI

struct ErrorInternetScreen: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("ErrorInternet")
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
                
            Text("Нет интернета")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.ypBlack)
                .padding(.top, 16)
            
            Spacer()
        }
        .padding()
        .generalViewStyle()
        
    }
}

#Preview {
    ErrorInternetScreen()
}
