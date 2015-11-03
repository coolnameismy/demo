//
//  AnimatedTransitioning2.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/2.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class AnimatedTransitioning2: NSObject, UIViewControllerAnimatedTransitioning {

    var transitionContext:UIViewControllerContextTransitioning!
    var type:UINavigationControllerOperation!
    
    convenience init(type:UINavigationControllerOperation) {
        self.init()
        self.type = type
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.5
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        self.transitionContext = transitionContext
        //        old(transitionContext)
        new(transitionContext)
        
        NSLog("animateTransition")
    }
    
    func animationEnded(transitionCompleted: Bool){
        NSLog("animation ended")
    }
    
    
    func new(transitionContext: UIViewControllerContextTransitioning){
        
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        let containerView = transitionContext.containerView()
        let view = toVC.view!
        
        containerView!.addSubview(toVC.view)
        if(type == .Pop){
//            containerView?.sendSubviewToBack(toVC.view)
//            containerView!.addSubview(fromVC.view)
        }
        
        //遮罩层
        let mask = CAShapeLayer()
        if(type == .Push){
            view.layer.mask = mask
        }else if(type == .Pop){
            fromVC.view.layer.mask = mask
        }
        view.layer.mask = mask
        
        //画出小圆
        let s_center = CGPoint(x: 50, y: 50)
        let s_radius:CGFloat =  sqrt(800)
        let s_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: s_center.x, y: s_center.y, width: 1, height: 1), -s_radius, -s_radius))
        //        mask.path = s_maskPath.CGPath
        
        //画出大圆
        let l_center = CGPoint(x: 50, y: 50)
        let l_radius = sqrt( pow(view.bounds.width - l_center.x, 2) + pow(view.bounds.height - l_center.y, 2) ) + 150
        let l_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: l_center.x, y: l_center.y, width: 1, height: 1), -l_radius, -l_radius))
        
        ////错误用法，animationWithDuration不能通过操作layer产生动画
        //UIView.animateWithDuration(5) { () -> Void in
        //     mask.path = b_maskPath.CGPath
        //}
        
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.duration = transitionDuration(transitionContext)
        if(type == .Push){
            baseAnimation.fromValue = s_maskPath.CGPath
            baseAnimation.toValue = l_maskPath.CGPath
        }else if(type == .Pop){
            baseAnimation.fromValue = l_maskPath.CGPath
            baseAnimation.toValue = s_maskPath.CGPath
            
        }
        
        baseAnimation.delegate = self
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        mask.addAnimation(baseAnimation, forKey: "path")
        
        
 

    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {

        self.transitionContext.completeTransition(!self.transitionContext.transitionWasCancelled())
        self.transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
        self.transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
        
       
        let t:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(500 * NSEC_PER_MSEC))
        dispatch_after(t, dispatch_get_main_queue()) { () -> Void in
           
           
        }
       

    }
}
