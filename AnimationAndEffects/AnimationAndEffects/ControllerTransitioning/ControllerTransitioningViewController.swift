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
    public var transitioningSender:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
//        let octocatView = UIImageView(image: UIImage(named: "octocat.png"))
//        octocatView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
//        view.addSubview(octocatView)
//    
//        let masklayer = CALayer()
//        masklayer.frame = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
//        masklayer.backgroundColor = UIColor.whiteColor().CGColor
//        masklayer.contents = octocatView
//        view.layer.mask =  masklayer
//        //2秒钟自动关闭
//        let t:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC))
//        dispatch_after(t, dispatch_get_main_queue()) { () -> Void in
//            UIView.animateWithDuration(1, animations: { () -> Void in
//                masklayer.frame = self.view.frame
//            })
//        }
    }
    
    //推出视图切换效果
    @IBAction func Transitioning1(sender: AnyObject) {
        let toVC = To1ViewController()
        navigationController?.delegate = self
        transitioningSender = sender as UIView
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
        
        return AnimatedTransitioning2(type:operation)
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





