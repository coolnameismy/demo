//
//  PresentedAnimation.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/2.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

public class PresentedAnimation: NSObject,UIViewControllerAnimatedTransitioning {

    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        //转场过渡动画的执行时间
        return 0.6
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    //在进行切换的时候将调用该方法，我们对于切换时的UIView的设置和动画都在这个方法中完成。
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        //拿到前后的两个controller
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        //拿到Presenting的最终Frame
        let finalFrameForVC = transitionContext.finalFrameForViewController(toVC)
        //拿到转换的容器view
        let containerView = transitionContext.containerView()
        let bounds = UIScreen.mainScreen().bounds
        toVC.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
        containerView!.addSubview(toVC.view)
        
        //自下而上弹出toVC的动画
        UIView.animateWithDuration(transitionDuration(transitionContext),
                                    delay: 0.0,
                                    usingSpringWithDamping: 0.7,
                                    initialSpringVelocity: 0.0,
                                    options: .CurveLinear,
                                    animations: {
                                    fromVC.view.alpha = 0.5
                                    toVC.view.frame = finalFrameForVC
                                    }, completion: {
                                        finished in
                                        transitionContext.completeTransition(true)
                                        fromVC.view.alpha = 1.0
                                    })
         NSLog("animateTransition")

    }
    
    //执行完成后的回调
    public func animationEnded(transitionCompleted: Bool){
            NSLog("animation ended")
    }
}
