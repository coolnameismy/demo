//
//  ControllerTransitioningViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/2.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit


class ControllerTransitioningViewController: UIViewController{
    
    //切换动画的触发对象
    internal var transitioningSender:UIView!
    
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
        navigationController?.delegate = nil
        toVC.transitioningDelegate = self
        navigationController?.presentViewController(toVC, animated: true, completion: nil)
    }
    
}

//推出视图切换效果
extension ControllerTransitioningViewController:UINavigationControllerDelegate{
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        let transitioningAnimation = AnimatedTransitioning2(type:operation)
        transitioningAnimation.sender = transitioningSender
        return transitioningAnimation
    }
//    
//    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
//        
//        UIViewControllerContextTransitioning
//        let transitioning = UIViewControllerInteractiveTransitioning()
//    }
    
}


//模态视图切换效果
extension ControllerTransitioningViewController:UIViewControllerTransitioningDelegate{
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return AnimatedTransitioning1()
    }
}





