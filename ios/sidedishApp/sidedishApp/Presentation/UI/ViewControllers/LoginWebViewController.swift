//
//  LoginWebViewController.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/29.
//

import UIKit
import WebKit
import SafariServices

class LoginWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestWebView()
    }
    
    fileprivate func requestWebView() {
        let endpoint = Endpoint.login()
        let request = URLRequest(url: endpoint.url)
        webView.load(request)
    }
}
