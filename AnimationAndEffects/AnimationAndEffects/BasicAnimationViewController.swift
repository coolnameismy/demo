//
//  BasicAnimationViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/10/27.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class BasicAnimationViewController: UIViewController {

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
    
        //# MARK:-
        func view1Clicked(tapGesture:UITapGestureRecognizer){
            
            NSLog("view1Clicked")
            //view1动画，向左移动100
            let theView = tapGesture.view!
            /* 
                可选的KeyPath
                transform.scale = 比例轉換
                transform.scale.x = 闊的比例轉換
                transform.scale.y = 高的比例轉換
                transform.rotation.z = 平面圖的旋轉
                opacity = 透明度
                margin
                zPosition
                backgroundColor 背景颜色
                cornerRadius 圆角
                borderWidth
                bounds
                contents
                contentsRect
                cornerRadius
                frame
                hidden
                mask
                masksToBounds
                opacity
                position
                shadowColor
                shadowOffset
                shadowOpacity
                shadowRadius
            */
            let baseAnimation = CABasicAnimation(keyPath: "position")
            //baseAnimation.fromValue 初始位置，如果不设就是当前位置
//            let point = CGPoint(x: theView.layer.position.x+100, y: theView.layer.position.y)
//            baseA baseAnimation.toValue = NSValue(CGPoint:point)nimation.toValue = NSValue(CGPoint:point)//绝对位置
             baseAnimation.byValue = NSValue(CGPoint:CGPoint(x: 100, y: 0))//相对位置
            //动画其他属性
            baseAnimation.duration = 0.2
            baseAnimation.repeatCount = 1
            baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)//加速运动
            //这两个属性若不设置，动画执行后回复位
            baseAnimation.removedOnCompletion = false
            baseAnimation.fillMode = kCAFillModeForwards
            
            //可以在动画中缓存一些
            //baseAnimation.setValue(NSValue(CGPoint: point), forKey: "startPoint")
            //开始动画
            //key可以作为找回动画使用
            theView.layer.addAnimation(baseAnimation, forKey: "theViewMoveRight100")
            
        }
    
    
    //移动
    
    //旋转
    
    //缩放
    
    //http://blog.csdn.net/iosevanhuang/article/details/14488239 http://www.cocoachina.com/ios/20141022/10005.html


  
}
