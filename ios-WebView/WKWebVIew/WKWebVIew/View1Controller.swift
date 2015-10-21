//
//  View1Controller.swift
//  WKWebVIew
//
//  Created by ZTELiuyw on 15/10/21.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit
import WebKit


class View1Controller: UIViewController ,WKScriptMessageHandler{

    var webView:WKWebView!
    let btns = ["ios-btn:调js的hello()","ios-btn:调js的hello(msg)"]

    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        
    }
    
   override func viewDidLoad() {
        super.viewDidLoad()
            
            //初始化webView
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        webView.backgroundColor = UIColor.grayColor()
        
        //本地添加2个按钮
        for item in btns.enumerate(){
            let btn =  UIButton(type: .Custom)
            btn.frame = CGRect(x: 30 , y: 500+(50*item.index), width: 300, height: 40)
            btn.backgroundColor = UIColor.blackColor()
            btn.setTitle(item.element, forState: .Normal)
            btn.titleLabel?.textColor = UIColor.redColor()
            self.view.addSubview(btn)
            btn.addTarget(self, action: "btnClick:", forControlEvents: .TouchUpInside)
        }
        
        //从本地加载html
        let path:String! = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        //注入js文件
        //        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
        //        NSString *jsString = [[NSString alloc] initWithContentsOfFile:filePath];
        //        [webView stringByEvaluatingJavaScriptFromString:jsString];
        
        webView.loadRequest(NSURLRequest(URL: NSURL.fileURLWithPath(path)))

    
    }
        
        
    
   

}
