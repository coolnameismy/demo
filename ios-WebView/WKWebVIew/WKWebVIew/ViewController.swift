//
//  ViewController.swift
//  WKWebVIew
//
//  Created by ZTELiuyw on 15/10/19.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {

    @IBOutlet var forwardBtn: UIBarButtonItem!
    @IBOutlet var gobackBtn: UIBarButtonItem!
    @IBOutlet var webWrap: UIView!
    @IBOutlet var progress: UIProgressView!
    var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(animated: Bool) {
       
    }
    
    override func viewDidAppear(animated: Bool) {
         self.theWebView()
    }
    //初始化webVIew
    func theWebView(){
        
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: self.webWrap.frame)
        webView.navigationDelegate = self
        webView.UIDelegate = self
        self.webWrap.addSubview(webView)
        
        //加载网页
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://localhost:8000/app/views/light.html")!))
        //允许手势
        webView.allowsBackForwardNavigationGestures = true
        //监听状态
        webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if (keyPath == "loading") {
            gobackBtn.enabled = webView.canGoBack
            forwardBtn.enabled = webView.canGoForward
        }
        if (keyPath == "estimatedProgress") {
            progress.hidden = webView.estimatedProgress==1
            progress.setProgress(Float(webView.estimatedProgress), animated: true)
        }

    }
    
    
    //上一页
    @IBAction func goback(sender: AnyObject) {
        webView.goBack()
    }
    //下一页
    @IBAction func forward(sender: AnyObject) {
        webView.goForward()
    }
    //刷新
    @IBAction func refresh(sender: AnyObject) {
        let request = NSURLRequest(URL:webView.URL!)
        webView.loadRequest(request)
    }

    

}

