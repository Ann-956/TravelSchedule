import SwiftUI

struct ErrorServerScreen: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("ErrorServer")
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
                
            Text("Ошибка сервера")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.ypBlack)
                .padding(.top, 16)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .generalViewStyle()
        .ignoresSafeArea()
        
    }
}

#Preview {
    ErrorServerScreen()
}
