import SwiftUI
import WebKit

struct UserAgreementScreen: View {
    private let navigationTitle = "Пользовательское соглашение"
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            WebView(urlString: Constants.urlString)
        }
        .navigationTitle(navigationTitle)
        .navigationBarStyle(dismissAction: {
            dismiss()
        })
        .background(.ypWhite)
        .ignoresSafeArea(.container, edges: .bottom)

    }
}

struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        loadURL(webView: webView)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        loadURL(webView: uiView)
    }
    
    private func loadURL(webView: WKWebView) {
        if let url = URL(string: urlString), webView.url != url {
            webView.load(URLRequest(url: url))
        }
    }
}

#Preview {
    UserAgreementScreen()
}
