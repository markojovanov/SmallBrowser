//
//  ViewController.swift
//  SmallBrowser
//
//  Created by Finki User on 7.7.21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var WebView: WKWebView!
    override func loadView() {
            WebView = WKWebView()
        WebView.navigationDelegate = self
        view = WebView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let url = URL(string: "https://www.hackingwithswift.com")!
        WebView.load(URLRequest(url: url))
        WebView.allowsBackForwardNavigationGestures = true
    }
    @objc func openTapped(){
        let ac=UIAlertController(title: "Open page..", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem=navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    func openPage(action: UIAlertAction){
        let url = URL(string: "https://"+action.title!)!
        WebView.load(URLRequest(url: url))
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }


}

