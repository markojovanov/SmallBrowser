import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["google.com","youtube.com","hackingwithswift.com","apple.com"]
    var websiteToLoad: String?
    override func loadView() {
            webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(canGoBack))
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(canGoForward))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh,back,spacer,progressButton,spacer,forward]
        navigationController?.isToolbarHidden = false
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        let url = URL(string: "https://" + websiteToLoad!)!
        webView.load(URLRequest(url: url))
    }
    @objc func openTapped(){
        let ac=UIAlertController(title: "Open page..", message: nil, preferredStyle: .actionSheet)
        for website in websites{
        ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "outlook.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem=navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    func openPage(action: UIAlertAction){
        let url = URL(string: "https://"+action.title!)!
        webView.load(URLRequest(url: url))
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in websites{
                   if host.contains(websiteToLoad!) {
                       decisionHandler(.allow)
                       return
                   }
                   else if host.contains(website) {
                        decisionHandler(.allow)
                        return
                   }
                }
           }
        decisionHandler(.cancel)
        if url?.host == nil { return }
        let ac = UIAlertController(title: "This site is blocked", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Back", style: .default))
        present(ac, animated: true)
        }
        @objc func canGoBack(sender: UIBarButtonItem){
        if(webView.canGoBack)
        {
            webView.goBack()
        }
        else{
            navigationController?.popViewController(animated: true)
        }
        }
        @objc func canGoForward(sender: UIBarButtonItem){
        if(webView.canGoForward)
        {
            webView.goForward()
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
}

