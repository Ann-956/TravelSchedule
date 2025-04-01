import SwiftUI

struct UserAgreementScreen: View {
    private let navigationTitle = "Пользовательское соглашение"
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel:  UserAgreementViewModel
    
    var body: some View {
        VStack {
            if viewModel.isError {
                ErrorServerScreen()
            } else {
                ZStack {
                    WebView(urlString: viewModel.urlString, viewModel: viewModel)
                        .onAppear {
                            viewModel.setLoading()
                        }
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            }
        }
        .navigationTitle(navigationTitle)
        .navigationBarStyle(dismissAction: {
            dismiss()
        })
        .generalViewStyle()
        .ignoresSafeArea(.container, edges: .bottom)
    }
}


struct UserAgreementScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserAgreementScreen()
    }
}
