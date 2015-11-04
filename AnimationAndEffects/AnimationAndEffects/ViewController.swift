//
//  ViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/10/27.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorate()
       
    }
    
    func decorate(){
        
        //画出小圆
        let s_center = CGPoint(x: 50, y: 50)
        let s_radius:CGFloat =  sqrt(800)
        let s_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: s_center.x, y: s_center.y, width: 1, height: 1), -s_radius, -s_radius))
//        mask.path = s_maskPath.CGPath
        
        //画出大圆
        let l_center = CGPoint(x: 50, y: 50)
        let l_radius = sqrt( pow(view.bounds.width - l_center.x, 2) + pow(view.bounds.height - l_center.y, 2) )
        let l_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: l_center.x, y: l_center.y, width: 1, height: 1), -l_radius, -l_radius))
      
////错误用法，animationWithDuration不能通过操作layer产生动画
//UIView.animateWithDuration(5) { () -> Void in
//     mask.path = b_maskPath.CGPath
//}
        //遮罩层
        let mask = CAShapeLayer()
        mask.path = l_maskPath.CGPath
        view.layer.mask = mask
        
        
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.duration = 0.5
        baseAnimation.fromValue = s_maskPath.CGPath
        baseAnimation.toValue = l_maskPath.CGPath
        baseAnimation.delegate = self
        mask.addAnimation(baseAnimation, forKey: "path")
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        view.layer.mask = nil
    }
   
}

 