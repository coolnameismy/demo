//
//  SwipeUpInteractiveTransition.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/4.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class SwipeUpInteractiveTransition: UIPercentDrivenInteractiveTransition {

    var vc:UIViewController?
    
    //是否正在交互
    var isInteracting:Bool = false
    //是否判断交互完成
    var shouldComplete:Bool = false
    
    init(vc:UIViewController) {
        super.init()
        self.vc = vc
        //添加手势
        vc.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "panGestureHandler:"))

    }
    
    //处理滑动手势
    func panGestureHandler(gesture:UIPanGestureRecognizer){
        let translation = gesture.translationInView(gesture.view)
        switch(gesture.state){
        case .Began:
            //标记交互开始，dismiss model
            isInteracting = true
            vc?.dismissViewControllerAnimated(true, completion: nil)
        case .Changed:
            var fraction = Float(translation.y / 400)
            //限制fraction值在0-1之间
            fraction = fminf(fmaxf(fraction, 0.0), 1.0)
            shouldComplete = fraction > 0.5
            updateInteractiveTransition(CGFloat(fraction))
            NSLog("x:%f y:%f" , translation.x,translation.y)
            NSLog("fraction:%f" , fraction)
            NSLog("shouldComplete:%@" ,shouldComplete)
        case .Ended , .Cancelled:
             isInteracting = false
             if(!shouldComplete || gesture.state == .Cancelled){
                 cancelInteractiveTransition()
             }else{
                 finishInteractiveTransition()
             }
            
        default:break
            
        }
        
    }
    
    
    
}
