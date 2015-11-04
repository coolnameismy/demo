//
//  To1ViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/11/2.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class To1ViewController: UIViewController {

    internal var navDelegate:UINavigationControllerDelegate!
    //切换动画的触发对象
    internal var transitioningSender:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("viewDidLoad")
        view.backgroundColor = UIColor.redColor()
        navigationController?.delegate = self
        let bg = UIImageView(image: UIImage(named: "x5"))
        bg.frame = view.frame
        view.addSubview(bg)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        NSLog("viewWillAppear")
    }

    override func viewDidAppear(animated: Bool) {
        NSLog("viewDidAppear")
    }
    
}

extension To1ViewController:UINavigationControllerDelegate{
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        let transitioningAnimation = AnimatedTransitioning2(type:operation)
        transitioningAnimation.sender = transitioningSender
        return transitioningAnimation
    }
}