//
//  MainViewController.swift
//  TrueTrue
//
//  Created by sigong_shin on 2017. 12. 28..
//  Copyright © 2017년 kcs. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController, UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var pageScrollView : UIScrollView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var homePage: UIViewController
        if #available(iOS 11.0, *){
            homePage =  self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
            (homePage as! HomePageViewController).mainViewController = self
        }else{
            homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomePageLowVersionViewController") as! HomePageLowVersionViewController
            (homePage as! HomePageLowVersionViewController).mainViewController = self
        }
        homePage.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        pageScrollView.addSubview(homePage.view)
        
        let gatePage =  self.storyboard?.instantiateViewController(withIdentifier: "SecondViewPageController") as! SecondViewPageController
        gatePage.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        pageScrollView.addSubview(gatePage.view)
        
        pageScrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: pageScrollView.frame.height)
    }
    
    func setWebviewDelegate(homepage: UIViewController!){
        guard homepage != nil else {
            return
        }
        
        if #available(iOS 11.0, *){
            (homepage as! HomePageViewController).webView.uiDelegate = self
            (homepage as! HomePageViewController).webView.navigationDelegate = self
        }else{
            (homepage as! HomePageLowVersionViewController)._webview.delegate = self
        }
    }
    
    
    //
    // HomePage Part
    //
    func showIndicator(){
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = CGRect(x: self.view.frame.midX - 50, y: self.view.frame.midY - 50, width: 100, height: 100)
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    func hideIndicator(){
        self.activityIndicator.removeFromSuperview()
    }
    
    func showAlertDialog(message : String, completionHandler: @escaping () -> Void){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "OK", style: .default) { action in completionHandler() }
        alert.addAction(otherAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
        //        showAlertDialog(message: error.localizedDescription) {
        //
        //        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        print("start")
        showIndicator()
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        print("end")
        hideIndicator()
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        showAlertDialog(message: message, completionHandler: completionHandler)
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel) { action in completionHandler(false) }
        let okAction = UIAlertAction(title: "OK", style: .default) { action in completionHandler(true) }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showIndicator()
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideIndicator()
    }
    
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        print("schme : \(navigationAction.request.url?.scheme)")
        if navigationAction.request.url?.scheme == "itms-appss" {
            //Todo. ex) Utils.openURLToAppStore(urlPath: navigationAction.request.url!.absoluteString)
            decisionHandler(.cancel)
        }else{
            decisionHandler(.allow)
        }
    }
}

