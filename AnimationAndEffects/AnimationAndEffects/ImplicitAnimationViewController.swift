//
//  ImplicitAnimationViewController.swift
//  AnimationAndEffects
//
//  Created by 刘彦玮 on 15/11/14.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class ImplicitAnimationViewController: UIViewController {
    
    var myLayer:CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //运动的layer
        myLayer = CALayer()
        myLayer.frame = CGRect(x: 10, y: 200, width: 100, height: 100)
        myLayer.backgroundColor = UIColor.redColor().CGColor
        view.layer.addSublayer(self.myLayer)
        
        //View1点击事件
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "view1Clicked:"))
    }

    
    //CATransaction 配置隐式动画
    func view1Clicked(tapGesture:UITapGestureRecognizer){
        
        CATransaction.begin()
        //CATranscation 属性
        //设置动画执行时间
        CATransaction.setAnimationDuration(1)
        //关闭隐式动画,这句话必须放在修改属性之前
//        CATransaction.setDisableActions(true)
        //设置动画完成后的回调
        CATransaction.setCompletionBlock { () -> Void in
            NSLog("Animation complete")
        }


        CATransaction.setAnimationDuration(1)
        self.myLayer.backgroundColor = UIColor.greenColor().CGColor
        self.myLayer.opacity = 0.5
        var moveToPoint  = CGPoint(x: myLayer.position.x + 150, y: myLayer.position.y + 50)
        if(moveToPoint.x > view.frame.size.width) { moveToPoint.x -= view.frame.size.width}
        if(moveToPoint.y > view.frame.size.height) { moveToPoint.y -= view.frame.size.height}
        self.myLayer.position = moveToPoint
        

        CATransaction.commit()
        performSelector("pause", withObject: nil, afterDelay: 0.2)
        
    }

//    隐式动画
//    func view1Clicked(tapGesture:UITapGestureRecognizer){
//        
//            self.myLayer.backgroundColor = UIColor.greenColor().CGColor
//            self.myLayer.opacity = 0.5
//            var moveToPoint  = CGPoint(x: myLayer.position.x + 50, y: myLayer.position.y + 50)
//            if(moveToPoint.x > view.frame.size.width) { moveToPoint.x -= view.frame.size.width}
//            if(moveToPoint.y > view.frame.size.height) { moveToPoint.y -= view.frame.size.height}
//            self.myLayer.position = moveToPoint
//    }
    
    
    //动画暂停
    func pause(){
        let interval =  myLayer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        myLayer.timeOffset = interval
        myLayer.speed = 0
        performSelector("resume", withObject: nil, afterDelay: 0.5)
    }
    
    
    //动画继续
    func resume(){
        let interval = CACurrentMediaTime() - myLayer.timeOffset
        myLayer.timeOffset = 0
        myLayer.beginTime = interval
        myLayer.speed = 1
    }
    
    
    
//    func frameSizeChange(rate:CGFloat)(_ frame:CGRect)->CGRect{
//        return CGRect(x: frame.origin.x + 200, y: frame.origin.y + 200, width: frame.size.width / rate, height: frame.size.height/rate)
//    }
//    
//    func frameMove(type:MoveDirection,point:CGPoint,frame:CGRect) -> CGRect{
//        switch(type){
//            case .right:
//                return CGRect(x: frame.origin.x + point.x, y:frame.origin.y + point.y , width:frame.size.width , height: frame.size.height)
//            default:break
//        }
//        return frame
//    }
//
//    
//    enum MoveDirection {
//        case up,down,left,right
//    }
}
