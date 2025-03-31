import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var urlString: String
    @ObservedObject var viewModel: UserAgreementViewModel

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        loadURL(webView: webView)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        loadURL(webView: uiView)
    }

    private func loadURL(webView: WKWebView) {
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }

    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(viewModel: viewModel)
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    var viewModel: UserAgreementViewModel

    init(viewModel: UserAgreementViewModel) {
        self.viewModel = viewModel
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.setLoaded()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        viewModel.setError(true)
    }
}

