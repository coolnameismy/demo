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
            
//            move(theView)
            groupAnimation(theView)
        }
    
    
    //移动
    func move(theView:UIView){
        /*
        可选的KeyPath
        transform.scale = 比例轉換
        transform.scale.x
        transform.scale.y
        transform.rotation = 旋轉
        transform.rotation.x
        transform.rotation.y
        transform.rotation.z
        transform.translation
        transform.translation.x
        transform.translation.y
        transform.translation.z
        
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
        let endPoint = CGPoint(x: theView.layer.position.x+100, y: theView.layer.position.y)
        baseAnimation.toValue = NSValue(CGPoint:endPoint)//绝对位置
        //baseAnimation.byValue = NSValue(CGPoint:CGPoint(x: 100, y: 0))//相对位置
        //动画其他属性
        baseAnimation.duration = 0.2
        baseAnimation.repeatCount = 1
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)//加速运动
        //baseAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 0, 0.9, 0.7)//自定义加速的曲线参数
        
        //这两个属性若不设置，动画执行后回复位
        baseAnimation.removedOnCompletion = false
        baseAnimation.fillMode = kCAFillModeForwards

        baseAnimation.delegate = self
        //可以在动画中缓存一些
        baseAnimation.setValue(NSValue(CGPoint: endPoint), forKey: "endPoint")
        baseAnimation.setValue(theView, forKey: "sender")
    
        //开始动画
        theView.layer.addAnimation(baseAnimation, forKey: "theViewMoveRight100")
    }
    
    //组合动画
    func groupAnimation(theView:UIView){
        
        //向右平移100
        let mAnimation = CABasicAnimation(keyPath: "position")
        //baseAnimation.fromValue 初始位置，如果不设就是当前位置
        let endPoint = CGPoint(x: theView.layer.position.x+100, y: theView.layer.position.y)
        mAnimation.toValue = NSValue(CGPoint:endPoint)//绝对位置

        //baseAnimation.byValue = NSValue(CGPoint:CGPoint(x: 100, y: 0))//相对位置

        //x轴旋转动画
        let xAnimation = CABasicAnimation(keyPath: "transform.rotation.x")
        (xAnimation as CABasicAnimation).byValue =  NSNumber(double:M_PI*500)
        xAnimation.duration = 1.5

        //y轴旋转动画
        let yAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        (yAnimation as CABasicAnimation).byValue =  NSNumber(double:M_PI*200)
        
        //缩放动画
        let sAnimation = CABasicAnimation(keyPath: "transform.scale")
        // 动画选项设定
        sAnimation.autoreverses = true // 动画结束时执行逆动画
        // 缩放倍数
        sAnimation.fromValue = NSNumber(double:0.1) // 开始时的倍率
        sAnimation.toValue = NSNumber(double:1.5) // 结束时的倍率
        
        //动画组
        let groupAnimation = CAAnimationGroup()

        // 动画选项设定，动画组统一设置或者单独设置
        groupAnimation.duration = 3.0;
        groupAnimation.repeatCount = 1;
        groupAnimation.animations = [xAnimation,yAnimation,sAnimation,mAnimation]
        //这两个属性若不设置，动画执行后回复位
        groupAnimation.removedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)//加速运动
        groupAnimation.delegate = self
        //可以在动画中缓存一些
        groupAnimation.setValue(NSValue(CGPoint: endPoint), forKey: "endPoint")
        groupAnimation.setValue(theView, forKey: "sender")
        //执行动画
        theView.layer.addAnimation(groupAnimation, forKey: "theViewMoveRotation90")
    }
    
    
    override func animationDidStop(anim:CAAnimation, finished flag: Bool) {
        let endPoint = anim.valueForKey("endPoint")?.CGPointValue
        let theView = anim.valueForKey("sender") as! UIView
//        theView.center = endPoint!
        theView.layer.position = endPoint!
        
//        let infoView = UIView(frame: theView.layer.frame)
//        infoView.backgroundColor = UIColor.greenColor()
//        view.addSubview(infoView)
    }
    


  
}
