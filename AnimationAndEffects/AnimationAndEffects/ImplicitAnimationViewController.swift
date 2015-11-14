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
        
        
        //运动的UIView
        
        myLayer = CALayer()
        myLayer.frame = CGRect(x: 10, y: 200, width: 100, height: 100)
        myLayer.backgroundColor = UIColor.redColor().CGColor
        view.layer.addSublayer(self.myLayer)
        
        
        //View1点击事件
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "view1Clicked:"))
    }

    
    
    func view1Clicked(tapGesture:UITapGestureRecognizer){
        let halfOfFrame = frameSizeChange(2.0)
//        view.backgroundColor = UIColor.redColor()
//        view.layer.frame = halfOfFrame(view.frame)
        
//        let btn = view.viewWithTag(10001) as! UIButton
        
//        
//        self.myLayer = CALayer()
//        self.myLayer.frame = btn.frame
//        self.myLayer.backgroundColor = UIColor.yellowColor().CGColor
//        view.layer.addSublayer(self.myLayer)
        
        
            self.myLayer.backgroundColor = UIColor.greenColor().CGColor
            self.myLayer.opacity = 0.5
            var moveToPoint  = CGPoint(x: myLayer.position.x + 50, y: myLayer.position.y + 50)
            if(moveToPoint.x > view.frame.size.width) { moveToPoint.x -= view.frame.size.width}
            if(moveToPoint.y > view.frame.size.height) { moveToPoint.y -= view.frame.size.height}
            self.myLayer.position = moveToPoint
    }
    
    
    func frameSizeChange(rate:CGFloat)(_ frame:CGRect)->CGRect{
        return CGRect(x: frame.origin.x + 200, y: frame.origin.y + 200, width: frame.size.width / rate, height: frame.size.height/rate)
    }
    
    func frameMove(type:MoveDirection,point:CGPoint,frame:CGRect) -> CGRect{
        switch(type){
            case .right:
                return CGRect(x: frame.origin.x + point.x, y:frame.origin.y + point.y , width:frame.size.width , height: frame.size.height)
            default:break
        }
        return frame
    }

    
    enum MoveDirection {
        case up,down,left,right
    }
}
