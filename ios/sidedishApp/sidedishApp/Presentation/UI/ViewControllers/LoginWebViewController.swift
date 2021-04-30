//
//  LoginWebViewController.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/29.
//

import UIKit
import WebKit
import SafariServices

class LoginWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.webView.uiDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "로그인"
        requestWebView()
    }
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        configuration.applicationNameForUserAgent = "Version/8.0.2 Safari/600.2.5"
        contentController.add(self, name: "scriptHandler")
        configuration.userContentController = contentController
        
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        view = webView
    }
    
    private func requestWebView() {
        let endpoint = Endpoint.login()
        let request = URLRequest(url: endpoint.url)
        webView.load(request)
    }
}

extension LoginWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let name = message.name as? String, name == "scriptHandler" {
            let token = message.body as! String
            TokenManager.save(token)
            
            if let tabVC = self.storyboard?.instantiateViewController(withIdentifier: MainTabBarController.identifier) as? MainTabBarController {
                tabVC.modalPresentationStyle = .fullScreen
                tabVC.selectedIndex = 1
                self.present(tabVC, animated: false, completion: nil)
            }
        }
    }
}
