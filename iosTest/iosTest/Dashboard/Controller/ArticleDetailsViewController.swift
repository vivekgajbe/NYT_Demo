//
//  ArticleDetailsViewController.swift
//  iosTest
//
//  Created by Vivek Gajbe on 3/17/20.
//  Copyright © 2020 Intelegain. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailsViewController: BaseViewController
{
    var webView: WKWebView!
    var strUrl : String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        navigationItem.title = ""
        webView.navigationDelegate = self
        
       if let url = URL(string: strUrl)
       {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        // Do any additional setup after loading the view.
    }

}
extension ArticleDetailsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
        self.showSpinner(onView: self.view)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.removeSpinner()
        print("Finished loading")
    }
    
    private func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
        self.removeSpinner()
    }
}
