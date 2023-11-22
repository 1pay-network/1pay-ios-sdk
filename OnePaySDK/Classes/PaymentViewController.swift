import Foundation
import UIKit
import WebKit

public class PaymentViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    
    var amount: Float!
    var token: String!
    var note: String!
    var callback: ((PaymentResponse) -> Void)? = nil
    
    private var paymentWebView = WKWebView()
    
    public override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        paymentWebView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentWebView)
        
        let closeButton = UIButton(type: .close)
        
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            paymentWebView.topAnchor.constraint(equalTo: view.topAnchor),
            paymentWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            paymentWebView.leftAnchor.constraint(equalTo: view.leftAnchor),
            paymentWebView.rightAnchor.constraint(equalTo: view.rightAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
        ])
        
    
        modalPresentationStyle = .pageSheet
    }
    
    private func buildPaymentURL() -> String {
        return "https://1pay.network/app" +
        "?recipient=\(OnePay.RECIPIENT)" +
        "&token=\(OnePay.TOKENS)" +
        "&network=\(OnePay.NETWORKS)" +
        "&paymentAmount=\(amount!)" +
        "&paymentToken=\(token!)" +
        "&paymentNote=\(note.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
    }
    
    public override func viewDidLoad() {
        overrideUserInterfaceStyle = .dark
        paymentWebView.uiDelegate = self
        paymentWebView.navigationDelegate = self
        
        let contentController = self.paymentWebView.configuration.userContentController
        contentController.add(self, name: "paymentResultHandler")
        
        let urlString = buildPaymentURL()
        guard let url = URL(string: urlString) else { return }
        paymentWebView.load(URLRequest(url: url))
        injectScript(contentController)
    }
    
    @objc func closeButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func injectScript(_ contentController: WKUserContentController) {
        let js = """
        if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.paymentResultHandler){
            handler = window.webkit.messageHandlers.paymentResultHandler
            onsuccess=onepaySuccess;onepaySuccess=function(response){onsuccess(response);handler.postMessage(response)};
            onfailed=onepayFailed;onepayFailed=function(response){onfailed(response);handler.postMessage(response)};
        }
        """
        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script)
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String : AnyObject] else {
            return
        }
        let response = PaymentResponse.fromDict(dict)
        if let _callback = callback {
            _callback(response)
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, let scheme = url.scheme {
            if !scheme.starts(with: "http") {
                if UIApplication.shared.canOpenURL(url){
                    // use the available apps in user's phone
                    UIApplication.shared.open(url)
                }
            }
        }
        decisionHandler(.allow)
    }
    
    // Handle link open new tab (<a> tag with target="_blank")
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let url = navigationAction.request.url, navigationAction.targetFrame == nil {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        return nil
    }
    
    deinit {
        paymentWebView.configuration.userContentController.removeScriptMessageHandler(forName: "paymentResultHandler")
    }
}
