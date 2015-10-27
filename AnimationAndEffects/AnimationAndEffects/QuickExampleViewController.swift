//
//  UIViewAnimationViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/10/27.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class QuickExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayColor()
        
        //运动的UIView
        let view1 = UIView(frame: CGRect(x: 10, y: 200, width: 100, height: 100))
        view1.backgroundColor = UIColor.redColor()
        view.addSubview(view1)
        //View1点击事件
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "view1Clicked:"))
    }
    
//# MARK:- 用UIView.beginAnimations() ->  UIView.commitAnimations()实现
//    func view1Clicked(tapGesture:UITapGestureRecognizer){
//        NSLog("view1Clicked")
//        //view1动画，向左移动100
//        let theView = tapGesture.view!
//        //开始动画配置
//        UIView.beginAnimations("view1Animation", context: nil)
//        //运动时间
//        UIView.setAnimationDuration(0.2)
//        //设置运动开始和结束的委托 animationDidStart and animationDidStop
//        UIView.setAnimationDelegate(self)
//        /* 
//            缓动方式
//            EaseInOut // slow at beginning and end
//            EaseIn // slow at beginning
//            EaseOut // slow at end
//            Linear
//        */
//        UIView.setAnimationCurve(.EaseIn)
//        //位置运动
//        theView.frame = CGRect(x: theView.frame.origin.x+100, y: theView.frame.origin.y, width: theView.frame.size.width, height: theView.frame.height)
//        //颜色渐变
//        theView.backgroundColor = UIColor.greenColor()
//        //透明度渐变
//        theView.alpha = 0.5
//        //动画开始
//        UIView.commitAnimations()
//        
//    }
    
    
//# MARK:- 用UIView.animateWithDuration实现
//    func view1Clicked(tapGesture:UITapGestureRecognizer){
//        NSLog("view1Clicked")
//        //view1动画，向左移动100
//        let theView = tapGesture.view!
//         UIView.animateWithDuration(0.2, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                //位置运动
//                theView.frame = CGRect(x: theView.frame.origin.x+100, y: theView.frame.origin.y, width: theView.frame.size.width, height: theView.frame.height)
//                //颜色渐变
//                theView.backgroundColor = UIColor.greenColor()
//                //透明度渐变
//                theView.alpha = 0.5
//            }) { (isCompletion) -> Void in
//                NSLog("completion")
//        }
//    }
    
    
//# MARK:- 用UIView.animateWithDuration实现更逼真的运动效果
    func view1Clicked(tapGesture:UITapGestureRecognizer){
        NSLog("view1Clicked")
        //view1动画，向左移动100
        let theView = tapGesture.view!
        //usingSpringWithDamping 阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
         UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
             theView.frame = CGRect(x: theView.frame.origin.x+100, y: theView.frame.origin.y, width: theView.frame.size.width, height: theView.frame.height)
            }, completion: nil)
        

    }

    //# MARK:UIView AnimationDelegate
    override func animationDidStart(anim: CAAnimation) {
         NSLog("animationDidStart")
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        NSLog("animationDidStop")
    }
    
}
