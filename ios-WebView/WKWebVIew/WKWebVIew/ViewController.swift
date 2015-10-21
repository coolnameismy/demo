//
//  ViewController.swift
//  WKWebVIew
//
//  Created by ZTELiuyw on 15/10/19.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler{
 
    @IBOutlet var forwardBtn: UIBarButtonItem!
    @IBOutlet var gobackBtn: UIBarButtonItem!
    @IBOutlet var webWrap: UIView!
    @IBOutlet var progress: UIProgressView!
    
    var webView:WKWebView!
    var config:WKWebViewConfiguration!
    var alert:UIAlertView!
    

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
        
        
        config = WKWebViewConfiguration()

        //注册js方法
        config.userContentController.addScriptMessageHandler(self, name: "hello")
        
        webView = WKWebView(frame: self.webWrap.frame, configuration: config)
        webView.navigationDelegate = self
        webView.UIDelegate = self
        self.webWrap.addSubview(webView)
        
        //加载网页
//        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://localhost:8000/app/views/light.html")!))
        
        //加载本地页面
        webView.loadRequest(NSURLRequest(URL: NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("index", ofType: "html")!)))
        
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
   
//#MARK:- 交互
    
    @IBAction func callJs(sender: AnyObject) {
        //注入js AtDocumentEnd 或 AtDocumentStart
//        let scriptContent = "hello()";
//        let script = WKUserScript(source: scriptContent, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
//        config.userContentController.addUserScript(script)
        
        //调用js带参数
        webView.evaluateJavaScript("hello('liuyanwei')", completionHandler: nil)
    }
    @IBAction func callJsWith(sender: AnyObject) {

       

        //直接调用js
//        webView.evaluateJavaScript("hi()", completionHandler: nil)
        //调用js获取返回值
        webView.evaluateJavaScript("getName()") { (any,error) -> Void in
            NSLog("%@", any as! String)
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

    //被js调用的原生方法
    func hello(name:String){
       let alert = UIAlertController(title: "app", message: "hello :\(name)", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "ok", style: .Default, handler:nil))
        alert.addAction(UIAlertAction(title: "cancel", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
//#MARK:- 委托
   
    
    //alert捕获
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        completionHandler()
        
        alert = UIAlertView(title: "ios-alert", message: message, delegate: nil, cancelButtonTitle: "取消")
        alert.show()
        

    }
    
    //注册js调用ios的handle委托
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        //接受传过来的消息从而决定app调用的方法
        let dict = message.body as! Dictionary<String,String>
        let method:String = dict["method"]!
        let param1:String = dict["param1"]!
        if method=="hello"{
            hello(param1)
        }
    }
}

