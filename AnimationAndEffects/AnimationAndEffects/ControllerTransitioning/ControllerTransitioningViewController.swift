//
//  ControllerTransitioningViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/2.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit


class ControllerTransitioningViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originViw = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        originViw.backgroundColor = UIColor.purpleColor()
        view.addSubview(originViw)
        
        let octocatView = UIImageView(image: UIImage(named: "octocat.png"))
        octocatView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        originViw.addSubview(octocatView)
    
        let masklayer = CALayer()
        masklayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        masklayer.backgroundColor = UIColor.blackColor().CGColor
        masklayer.contents = octocatView
        originViw.layer.mask =  masklayer

    }
    
    //推出视图切换效果
    @IBAction func Transitioning1(sender: AnyObject) {
        let toVC = To1ViewController()
        navigationController?.delegate = self
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

extension ControllerTransitioningViewController:UIViewControllerTransitioningDelegate{
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return AnimatedTransitioning1()
    }
}

extension ControllerTransitioningViewController:UINavigationControllerDelegate{
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return AnimatedTransitioning2()
    }
}



