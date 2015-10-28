//
//  KeyFrameAnimationViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/10/28.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class KeyFrameAnimationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //运动的imageView
        let imageView = UIImageView(image: UIImage(named: "githubhead1.jpeg"))
        imageView.frame = CGRect(x: 10, y: 100, width: 60, height: 60)
        imageView.userInteractionEnabled = true
        
        view.addSubview(imageView)
        //点击事件
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageViewClicked:"))
    }
    

    func imageViewClicked(tapGesture:UITapGestureRecognizer){
        //关键帧动画
        //keyPath和basicAnimation的类型相同，@see BasicAnimationViewController.swift
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        //线段的位置移动
//        keyframeAnimation.values = [
//                                        NSValue(CGPoint: CGPoint(x: 10, y: 100)),
//                                        NSValue(CGPoint: CGPoint(x: 30, y: 100)),
//                                        NSValue(CGPoint: CGPoint(x: 30, y: 120)),
//                                        NSValue(CGPoint: CGPoint(x: 60, y: 120)),
//                                        NSValue(CGPoint: CGPoint(x: 60, y: 100)),
//                                        NSValue(CGPoint: CGPoint(x: 106, y: 210)),
//                                        NSValue(CGPoint: CGPoint(x: 106, y: 410)),
//                                        NSValue(CGPoint: CGPoint(x: 300, y: 310))
//                                   ]
        //弧线位置移动
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 50, 50)
        CGPathAddCurveToPoint(path, nil, 50, 50, 700, 300, 30, 500)
        keyframeAnimation.path = path
        keyframeAnimation.calculationMode = kCAAnimationLinear
        
        //设置其他属性
        keyframeAnimation.duration = 1.0;
//        keyframeAnimation.beginTime = CACurrentMediaTime() + 2;//设置延迟2秒执行
        
        tapGesture.view?.layer.addAnimation(keyframeAnimation, forKey: "keyframeAnimation1")
        tapGesture.view?.layer.presentationLayer()
        tapGesture.view?.layer.modelLayer()
        
    }

}
