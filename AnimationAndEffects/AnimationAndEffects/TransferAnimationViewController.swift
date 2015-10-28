//
//  TransferAnimationViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/10/28.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class TransferAnimationViewController: UIViewController {

    var images:Array<UIImage>!
    var bg:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景图片
        bg = UIImageView(image: UIImage(named: "x1.png"))
        bg.frame = view.frame
        view.addSubview(bg)
        
        //左右滑动事件
        let rigthSwipe = UISwipeGestureRecognizer(target:self, action:"rightSwipe:")
        rigthSwipe.direction = .Right
        let leftSwipe = UISwipeGestureRecognizer(target:self, action:"leftSwipe:")
        leftSwipe.direction = .Left
        view.addGestureRecognizer(rigthSwipe)
        view.addGestureRecognizer(leftSwipe)

    }
    
    
    func rightSwipe(gesture:UISwipeGestureRecognizer){
        bg.image = fetchImage()
        bg.layer.addAnimation(swipeTransition(kCATransitionFromRight), forKey: "rightSwipe")
        
    }
    
    func leftSwipe(gesture:UISwipeGestureRecognizer){
        bg.image = fetchImage()
        bg.layer.addAnimation(swipeTransition(kCATransitionFromLeft), forKey: "leftSwipe")
    }
    
    func fetchImage()->UIImage{
        if images == nil{
            images = [];
            for index in 0...5 {
                let image = UIImage(named: "x" + String(index))
                images.append(image!)
            }
        }
        return images[Int(arc4random()%5)]
    }
    func swipeTransition(subtype:String)->CATransition{
        let transfer = CATransition()
        /*
            kCATransitionFade：淡入淡出，默认效果
            kCATransitionMoveIn：新视图移动到就是图上方
            kCATransitionPush:新视图推开旧视图
            kCATransitionReveal：移走旧视图然后显示新视图
            
            //苹果未公开的私有转场效果
            cube:立方体
            suckEffect:吸走的效果
            oglFlip:前后翻转效果
            rippleEffect:波纹效果
            pageCurl:翻页起来
            pageUnCurl:翻页下来
            cameraIrisHollowOpen:镜头开
            cameraIrisHollowClose:镜头关
        */
        let types = [kCATransitionFade,kCATransitionMoveIn,kCATransitionPush,kCATransitionReveal,"cube","suckEffect","oglFlip","rippleEffect","pageCurl","pageUnCurl","cameraIrisHollowOpen","cameraIrisHollowClose"]
        let type = types[Int(arc4random()%11)]
        transfer.type = type
        NSLog("%@", type)
        transfer.subtype = subtype
        transfer.duration = 1
        return transfer
    }
    
    
}
