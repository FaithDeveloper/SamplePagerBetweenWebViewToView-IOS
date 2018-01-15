//
//  HomePageLowVersionViewController.swift
//  TrueTrue
//
//  Created by kcs on 2017. 12. 28..
//  Copyright © 2017년 sigongmedia. All rights reserved.
//

import UIKit

class HomePageLowVersionViewController : UIViewController{
    
    var mainViewController : MainViewController!
    
    //    @IBOutlet weak var _webview: UIWebView!
    public var _webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        _webview = UIWebView(frame: self.view.frame)
        
        _webview = UIWebView(frame: self.view.frame)
        _webview.mediaPlaybackRequiresUserAction = false
        //        _webview.frame = self.view.frame
        let address = "http://faith-developer.tistory.com/"
        let url = URL(string: address)
        let request = URLRequest(url: url!)
        _webview.loadRequest(request)
        
        self.view.addSubview(_webview)
        
        
        mainViewController.setWebviewDelegate(homepage: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
