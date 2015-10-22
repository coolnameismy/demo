//
//  ViewController.swift
//
//
//  Created by 刘彦玮 on 15/10/16.
//  Copyright © 2015年 刘彦玮. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    var webView:UIWebView!
    let btns = ["ios-btn:调js的hi()","ios-btn:调js的hello(msg)","ios-btn:调js的getName()"]
    
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
        webView.loadRequest(NSURLRequest(URL: NSURL.fileURLWithPath(path)))
        //从网址加载html
//        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.bing.com")!))
    }

    func btnClick(sender:UIButton){
        let btnText = sender.titleForState(.Normal)
        if btnText == btns[0]{
            NSLog("%@",btnText!)
            //调用js无参数的方法 hello()
            webView.stringByEvaluatingJavaScriptFromString("hi()")
        }
        if sender.titleForState(.Normal) == btns[1]{
            NSLog("%@",btnText!)
            //调用js有参数的方法hello(msg)
            let js = String(format: "hello('%@')", "liuyanwei")
            webView.stringByEvaluatingJavaScriptFromString(js)
            
            //从文件中加载一段js代码然后执行
//            do{
//                let jsString = try String(contentsOfFile: NSBundle.mainBundle().pathForResource("test", ofType: "js")!, encoding: NSUTF8StringEncoding)
//                self.webView.stringByEvaluatingJavaScriptFromString(jsString)
//            }
//            catch{}
            
            
            //调用js的参数为json对象
//            let js = String(format: "hello(%@)", "{'obj':'liuyanwei'}")
//            webView.stringByEvaluatingJavaScriptFromString(js)
            
            //直接执行alert
//            webView.stringByEvaluatingJavaScriptFromString("alert('hi')")
            
        }

        if sender.titleForState(.Normal) == btns[2]{
            //执行有返回值的js函数
            NSLog("%@", webView.stringByEvaluatingJavaScriptFromString("getName()")!)
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
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        //如果请求协议是hello 这里的hello来自js的调用，在js中设为 document.location = "hello://liuyanwei 你好";
        //scheme：hello ，msg：liuyanwei 你好
        //通过url拦截的方式，作为对ios原生方法的呼叫
        if request.URL?.scheme == "hello"{
            let method:String = request.URL?.scheme as String!
            let sel =  Selector(method+":")
            self.performSelector(sel, withObject:request.URL?.host)
            request.URL?.path
            //如果return true ，页面加载request，我们只是当做协议使用所以不能页面跳转
            return false
        }

        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

