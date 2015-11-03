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

        if(type == .Push){
            PushTransition(transitionContext)
        }else if(type == .Pop){
            PopTransition(transitionContext)
        }
        
        
        NSLog("animateTransition")
    }
    
    func animationEnded(transitionCompleted: Bool){
        NSLog("animation ended")
    }
    
    func PopTransition(transitionContext: UIViewControllerContextTransitioning){
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        let view = toVC.view!
        
        containerView!.addSubview(toVC.view)
        containerView!.addSubview(fromVC.view)
        
        //遮罩层
        let mask = CAShapeLayer()
        fromVC.view.layer.mask = mask
        
        //画出小圆
        let s_center = CGPoint(x: 50, y: 50)
        let s_radius:CGFloat =  sqrt(800)
        let s_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: s_center.x, y: s_center.y, width: 1, height: 1), -s_radius, -s_radius))
        //        mask.path = s_maskPath.CGPath
        
        //画出大圆
        let l_center = CGPoint(x: 50, y: 50)
        let l_radius = sqrt( pow(view.bounds.width - l_center.x, 2) + pow(view.bounds.height - l_center.y, 2) ) + 150
        let l_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: l_center.x, y: l_center.y, width: 1, height: 1), -l_radius, -l_radius))
        
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.duration = transitionDuration(transitionContext)
        
        baseAnimation.fromValue = l_maskPath.CGPath
        baseAnimation.toValue = s_maskPath.CGPath
        
        baseAnimation.delegate = self
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        mask.addAnimation(baseAnimation, forKey: "path")

    }
    
    func PushTransition(transitionContext: UIViewControllerContextTransitioning){
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        let containerView = transitionContext.containerView()
        let view = toVC.view!
        let sender = (fromVC as! ControllerTransitioningViewController).transitioningSender
        
//        containerView!.addSubview(fromVC.view)
        containerView!.addSubview(toVC.view)

        //画出小圆
        let s_center = CGPoint(x: 50, y: 50)
        let s_radius:CGFloat =  sqrt(800)
        let s_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: s_center.x, y: s_center.y, width: 1, height: 1), -s_radius, -s_radius))
        // mask.path = s_maskPath.CGPath
        
        //画出大圆
        let l_center = CGPoint(x: 50, y: 50)
        let l_radius = sqrt( pow(view.bounds.width - l_center.x, 2) + pow(view.bounds.height - l_center.y, 2) ) + 150
        let l_maskPath = UIBezierPath(ovalInRect:CGRectInset(CGRect(x: l_center.x, y: l_center.y, width: 1, height: 1), -l_radius, -l_radius))
        
        //遮罩层
        let mask = CAShapeLayer()
        mask.path = l_maskPath.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
        view.layer.mask = mask

        
        ////错误用法，animationWithDuration不能通过操作layer产生动画
        //UIView.animateWithDuration(5) { () -> Void in
        //     mask.path = b_maskPath.CGPath
        //}
        
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.duration = transitionDuration(transitionContext)

        baseAnimation.fromValue = s_maskPath.CGPath
        baseAnimation.toValue = l_maskPath.CGPath

        baseAnimation.delegate = self
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        mask.addAnimation(baseAnimation, forKey: "path")
        

    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        self.transitionContext.completeTransition(!self.transitionContext.transitionWasCancelled())
        self.transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
        self.transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil

    }
}
