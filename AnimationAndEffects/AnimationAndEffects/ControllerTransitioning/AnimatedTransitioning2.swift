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
    
        
//        view.alpha = 0

//        let maskView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        maskView.backgroundColor = UIColor.greenColor()
//        view.addSubview(maskView)
//
//        let octocatView = UIImageView(image: UIImage(named: "octocat.png"))
//        octocatView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        maskView.addSubview(octocatView)

//        let masklayer = CALayer()
//        masklayer.frame = CGRect(x: 0 , y: 0, width: 0, height: 0)
//        masklayer.backgroundColor = UIColor.whiteColor().CGColor
//        masklayer.contents = octocatView
//        maskView.layer.mask =  masklayer
        
        
        let masklayer = CAShapeLayer()
        let bezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 50, height: 50))
        let endBezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 500, height: 500))
        masklayer.path = bezierPath.CGPath
        toVC.view.layer.mask = masklayer;
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        
        maskLayerAnimation.fromValue =  bezierPath.CGPath
        maskLayerAnimation.toValue = endBezierPath.CGPath
        maskLayerAnimation.duration = transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        masklayer.addAnimation(maskLayerAnimation, forKey: "path")

        

        
//        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
////                masklayer.frame = CGRect(x: 0 , y: 100, width: 200, height: 200)
//                  view.alpha = 1
//            
//            }, completion: {
//                finished in
////                view.bounds = UIScreen.mainScreen().bounds
////                view.backgroundColor = UIColor.whiteColor()
//                transitionContext.completeTransition(true)
//        })

    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext.completeTransition(true)
        
        self.transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
        self.transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil

    }
}
