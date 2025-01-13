import SwiftUI
import WebKit

struct UserAgreementView: View {
    @Binding var urlString: String
    private let navigationTitle = "Пользовательское соглашение"
    
    var body: some View {
        VStack {
            WebView(urlString: urlString)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            uiView.load(URLRequest(url: url))
        }
    }
}

struct UserAgreementView_Previews: PreviewProvider {
    @State static private var urlString = "https://yandex.ru/legal/practicum_offer"
    
    static var previews: some View {
        NavigationStack {
            UserAgreementView(urlString: $urlString)
        }
    }
}
