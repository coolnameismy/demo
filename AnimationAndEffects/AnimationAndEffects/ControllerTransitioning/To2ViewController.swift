//
//  To2ViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/2.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class To2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.greenColor()
       
        
//        let originViw = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
//        originViw.backgroundColor = UIColor.purpleColor()
//        view.addSubview(originViw)
//        
//        let octocatView = UIImageView(image: UIImage(named: "octocat.png"))
//        octocatView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
//        originViw.addSubview(octocatView)
//        
//        let masklayer = CALayer()
//        masklayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//        masklayer.backgroundColor = UIColor.blackColor().CGColor
//        masklayer.contents = octocatView
//        view.layer.mask =  masklayer
        
        
        //2秒钟自动关闭
        let t:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC))
        dispatch_after(t, dispatch_get_main_queue()) { () -> Void in
//            navigationController?.dismissViewControllerAnimated(true, completion: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

   
}

