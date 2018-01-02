//
//  TrueHomePageView.swift
//  TrueTrue
//
//  Created by sigong_shin on 2017. 12. 28..
//  Copyright © 2017년 sigongmedia. All rights reserved.
//

import UIKit
import WebKit

class HomePageViewController : UIViewController{
    
    public var webView: WKWebView!
    var mainViewController : MainViewController!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
               
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width:self.view.frame.width, height: self.view.frame.height), configuration: webConfiguration)
        mainViewController.setWebviewDelegate(homepage: self)
        
        self.view.addSubview(webView)
        
        let address = "http://faith-developer.tistory.com/"
        let url = URL(string: address)
        let request = URLRequest(url: url!)
        
        webView.load(request)
    }
    
    func setUpPlayerAndEventDelegation(webView: WKWebView){
        
        let controller = WKUserContentController()
        webView.configuration.userContentController = controller
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
