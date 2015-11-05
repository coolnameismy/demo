//
//  ControllerTransitioningViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/2.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit


class ControllerTransitioningDemoViewController: UIViewController{
    
    //切换动画的触发对象
    internal var transitioningSender:UIView!
    //dismiss的交互效果
    var interactiveTransition:SwipeUpInteractiveTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bg = UIImageView(image: UIImage(named: "x1"))
        bg.frame = view.frame
        view.addSubview(bg)
    }
    
    //推出视图切换效果
    @IBAction func Transitioning1(sender: AnyObject) {
        let toVC = To1ViewController()
        navigationController?.delegate = self
        transitioningSender = sender as! UIView
        navigationController?.pushViewController(toVC, animated: true)
    }
    
    //模态视图切换效果
    @IBAction func Transitioning2(sender: AnyObject) {
        let toVC = To2ViewController()
        interactiveTransition = SwipeUpInteractiveTransition(vc:toVC)
//        toVC.transitioningDelegate = self
//        toVC.modalTransitionStyle = .CrossDissolve
//        toVC.modalPresentationStyle = .FormSheet
        navigationController?.presentViewController(toVC, animated: true, completion: nil)
    }
    
}

//推出视图切换效果
extension ControllerTransitioningDemoViewController:UINavigationControllerDelegate{
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        let transitioningAnimation = ExpandAnimation(type:operation)
        transitioningAnimation.sender = transitioningSender
        return transitioningAnimation

    }
    
    
}


//模态视图切换效果
extension ControllerTransitioningDemoViewController:UIViewControllerTransitioningDelegate{
    
    //返回Presented使用的UIViewControllerAnimatedTransitioning类
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return PresentedAnimation()
    }

    //返回dismiss使用的UIViewControllerAnimatedTransitioning类
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
    //返回dismiss交互时的使用的UIViewControllerInteractiveTransitioning类
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.isInteracting ? interactiveTransition : nil
    }
    
    
}





