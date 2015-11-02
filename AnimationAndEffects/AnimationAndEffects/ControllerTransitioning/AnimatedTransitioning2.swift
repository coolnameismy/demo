//
//  AnimatedTransitioning2.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/2.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class AnimatedTransitioning2: NSObject, UIViewControllerAnimatedTransitioning {

    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 2.0
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        //拿到前后的两个controller
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
        let containerView = transitionContext.containerView()
        let bounds = UIScreen.mainScreen().bounds
        toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
        containerView!.addSubview(toViewController.view)
        
        let masklayer = CALayer()
        masklayer.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        toVC?.view.layer.mask =  masklayer
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
            fromViewController.view.alpha = 0.5
            toViewController.view.frame = finalFrameForVC
            
            
            masklayer.frame = (toVC?.view.frame)!
            masklayer.backgroundColor = UIColor.blackColor().CGColor
//            masklayer.contents = toVC?.view
//            originViw.layer.mask =  masklayer
            
            }, completion: {
                finished in
                transitionContext.completeTransition(true)
                fromViewController.view.alpha = 1.0
                
        })
        NSLog("animateTransition")
    }
    
    func animationEnded(transitionCompleted: Bool){
        NSLog("animation ended")
    }
}
