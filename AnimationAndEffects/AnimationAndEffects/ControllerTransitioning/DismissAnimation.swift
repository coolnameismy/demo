//
//  DismissAnimation.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/5.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class DismissAnimation:NSObject,UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.6
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!

        let screenBounds = UIScreen.mainScreen().bounds
        let initFrame = transitionContext.initialFrameForViewController(fromVC)
        let finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height)

        let containerView = transitionContext.containerView()!
        containerView.addSubview(toVC.view)
        containerView.sendSubviewToBack(toVC.view)

        let duration: NSTimeInterval = self.transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: {
            fromVC.view.frame = finalFrame
            }, completion: {
                (finished: Bool) in transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })

     }
}
