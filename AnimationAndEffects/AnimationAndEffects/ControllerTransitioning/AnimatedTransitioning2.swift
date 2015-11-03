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
    
    func old(transitionContext: UIViewControllerContextTransitioning){
        //拿到前后的两个controller
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
        let containerView = transitionContext.containerView()
        let bounds = UIScreen.mainScreen().bounds
        //        toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
        
        containerView!.addSubview(toViewController.view)
        transitionContext.completeTransition(true)
        
        
        //        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
        ////            fromViewController.view.alpha = 0.5
        ////            toViewController.view.frame = finalFrameForVC
        //            }, completion: {
        //                finished in
        ////                transitionContext.completeTransition(true)
        ////                fromViewController.view.alpha = 1.0
        ////                toViewController.view.frame = finalFrameForVC
        //        })

    }
    
    func new(transitionContext: UIViewControllerContextTransitioning){
        
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        let containerView = transitionContext.containerView()
        let view = toVC.view!
        
        containerView!.addSubview(toVC.view)
    
        
        //遮罩层
        let mask = CAShapeLayer()
        view.layer.mask = mask
        
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
        
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.duration = 0.5
        baseAnimation.fromValue = s_maskPath.CGPath
        baseAnimation.toValue = l_maskPath.CGPath
        baseAnimation.delegate = self
        mask.addAnimation(baseAnimation, forKey: "path")

 

    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext.completeTransition(true)
        
        self.transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
        self.transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil

    }
}
