//
//  ViewController.swift
//  HybirdsDemo
//
//  Created by 刘彦玮 on 15/10/16.
//  Copyright © 2015年 刘彦玮. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    var webView:UIWebView!
    let btns = ["ios-btn:调js的hello()","ios-btn:调js的hello(msg)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化webView
        webView = UIWebView(frame: self.view.frame)
        webView.delegate = self
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
//        webView.loadRequest(NSURLRequest(URL: NSURL.fileURLWithPath(path)))
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.bing.com")!))
    }

    func btnClick(sender:UIButton){
        let btnText = sender.titleForState(.Normal)
        if btnText == btns[0]{
            NSLog("%@",btnText!)
            //调用js无参数的方法
            webView.stringByEvaluatingJavaScriptFromString("hello()")
        }
        if sender.titleForState(.Normal) == btns[1]{
            NSLog("%@",btnText!)
            //调用js有参数的方法
            let js = String(format: "hello('%@')", "liuyanwei")
            webView.stringByEvaluatingJavaScriptFromString(js)
            
            //调用js的参数为json对象
//            let js = String(format: "hello(%@)", "{'obj':'liuyanwei'}")
//            webView.stringByEvaluatingJavaScriptFromString(js)
            
            //直接执行alert
//            webView.stringByEvaluatingJavaScriptFromString("alert('hi')")
        }
    }
    
    func hello(){
        let alert = UIAlertView(title: "ios-hello()", message:nil, delegate: nil, cancelButtonTitle: "cancel")
        alert.show()
    }
    func hello(msg:String){
        let alert = UIAlertView(title: "ios-hello()", message:msg, delegate: nil, cancelButtonTitle: "cancel")
        alert.show()
    }
    
    internal  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        //如果是加载文件
        if request.URL?.scheme == "file"{
            return true
        }
        //如果请求协议是hello 这里的hello来自js的调用，在js中设为 document.location = "hello://liuyanwei 你好";
        //scheme：hello ，msg：liuyanwei 你好
        //通过url拦截的方式，作为对ios原生方法的呼叫
        if request.URL?.scheme == "hello"{
            let method:String = request.URL?.scheme as String!
            let sel =  Selector(method+":")
            self.performSelector(sel, withObject:request.URL?.host)
            request.URL?.path
        }

        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

