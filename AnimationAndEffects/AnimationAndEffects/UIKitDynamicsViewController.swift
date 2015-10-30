//
//  UIKitDynamicsViewController.swift
//  AnimationAndEffects
//
//  Created by ZTELiuyw on 15/10/29.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class UIKitDynamicsViewController: UIViewController {


    var box:UIImageView!
    var floor:UIImageView!
    
    //重力效果持有者
    var animator:UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //uiview背景效果
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundTile")!)
        
        //初始化一个箱子
        box = UIImageView(image: UIImage(named: "Box1"))
        box.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        view.addSubview(box)
            
        //初始化地板
        floor = UIImageView(image: UIImage(named: "floor"))
        floor.frame = CGRect(x: 0, y: view.frame.size.height-10, width: view.frame.size.width, height: 5)
        view.addSubview(floor)
        
       
        //fall()  //自由落体
        //fallDown() //自由落在地板上
        //pin() //把box钉在 x: 200, y: 200 位置
        //throwBox() //丢箱子
        //blockHole() //黑洞效果
        blockHole2()//自定义合成行为完成黑洞效果
    }
    
    //自由落体
    func fall(){
        
        /*给箱子加上重力效果*/
        //初始化动画的持有者
        let gravityAnimator =  UIDynamicAnimator(referenceView: view)
        //初始化重力行为
        let gravityBehavior = UIGravityBehavior(items: [box])
        //添加重力行为
        gravityAnimator.addBehavior(gravityBehavior)
        //需要保持变量
        self.animator = gravityAnimator
        
    }

    //自由落在地板上
    func fallDown(){
        
        //初始化动画的持有者
        let animator =  UIDynamicAnimator(referenceView: view)
        //初始化重力行为
        let gravityBehavior = UIGravityBehavior(items: [box])
        //添加重力行为
        animator.addBehavior(gravityBehavior)
        //初始化碰撞行为
        let collisionBehavior = UICollisionBehavior(items: [box])
        //指定边界为参考系的边界
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)

        //需要保持变量
        self.animator = animator
    }
    
    //把box钉在 x: 200, y: 200 位置
    func pin(){
        //初始化动画的持有者
        let animator =  UIDynamicAnimator(referenceView: view)
        //初始化重力行为
        let gravityBehavior = UIGravityBehavior(items: [box])
        //添加重力行为
        animator.addBehavior(gravityBehavior)
        //初始化连接行为
        let attachmentBehavior = UIAttachmentBehavior(item: box, attachedToAnchor: CGPoint(x: 200, y: 200))
   
        //把点画出来
        let point = UIImageView(image: UIImage(named: "AttachmentPoint_Mask"))
        point.frame = CGRect(x: 200, y: 200, width: 10, height: 10)
        view.addSubview(point)
        //设置行为
        animator.addBehavior(attachmentBehavior)
        
        //需要保持变量
        self.animator = animator

    }
    
    //丢箱子
    func throwBox(){
        
        //重新设置box的位置
        box.hidden = true
        box.frame = CGRect(x: 0, y: 400, width: 50, height: 50)
        box.hidden = false
        
        //初始化动画的持有者
        let animator =  UIDynamicAnimator(referenceView: view)
        //初始化重力行为
        let gravityBehavior = UIGravityBehavior(items: [box])
        //添加重力行为
        animator.addBehavior(gravityBehavior)
        //初始化推力行为     Continuous:持续给力 Instantaneous:瞬间给力
        let pushBehavior = UIPushBehavior(items: [box], mode: .Instantaneous)
        //推力速度
        pushBehavior.magnitude = 2
        //推力方向
        pushBehavior.angle = pointToAngle(CGPoint(x: 500, y: -300))
        //设置行为
        animator.addBehavior(pushBehavior)
        
        //设置边界
        let collisionBehavior = UICollisionBehavior(items: [box])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)
        
        //需要保持变量
        self.animator = animator
        
    }
    
    //黑洞
    func blockHole(){
        
        //把黑洞画出来
        let blackhole = UIImageView(image: UIImage(named: "blackhole"))
        blackhole.frame = CGRect(x: 300, y: 140, width: 50, height: 50)
        view.addSubview(blackhole)

        //初始化动画的持有者
        let animator =  UIDynamicAnimator(referenceView: view)
        //初始化重力行为
        let gravityBehavior = UIGravityBehavior(items: [box])
        //添加重力行为
        animator.addBehavior(gravityBehavior)
        
        //需要保持变量
        self.animator = animator
        
        //0.5秒后启动黑洞
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(500 * NSEC_PER_MSEC)), dispatch_get_main_queue()) { () -> Void in
            NSLog("black hole !!!")
            let snapBehavior = UISnapBehavior(item: self.box, snapToPoint: CGPoint(x: 300, y: 140))
            snapBehavior.damping = 50 //阻尼
            self.animator.addBehavior(snapBehavior)
            
        }
        
    }

    //作用力的合成，以黑洞为例，合成吸引力和重力
    class GravityAndSnapBehavior:UIDynamicBehavior {
        init(view:UIView) {
            var point:CGPoint!
            super.init()
            let gravityBehavior = UIGravityBehavior(items: [view])
            let snapBehavior = UISnapBehavior(item: view, snapToPoint: CGPoint(x: 300, y: 140))
            self.addChildBehavior(gravityBehavior)
            point =  CGPoint(x: 100 , y: 100)
            self.addChildBehavior(snapBehavior)
            //可以监听每一个步骤，然后自己对行为加自定义的影响和作用
            self.action = {
                NSLog("step")
//                view.layer.position = CGPoint(x: point.x++, y: point.y++)
            }
        }
    }
    //黑洞+使用自定义的合成行为
    func blockHole2(){
        //把黑洞画出来
        let blackhole = UIImageView(image: UIImage(named: "blackhole"))
        blackhole.frame = CGRect(x: 300, y: 140, width: 50, height: 50)
        view.addSubview(blackhole)
        
        //初始化动画的持有者
        let animator =  UIDynamicAnimator(referenceView: view)
        //初始化合成行为
        let gravityAndSnapBehavior = GravityAndSnapBehavior(view: box)
        //添加重力行为
        animator.addBehavior(gravityAndSnapBehavior)
        //需要保持变量
        self.animator = animator

    }
    
    //根据给定点和view中心点计算角度
    func pointToAngle(p:CGPoint)->CGFloat{
        let o: CGPoint = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
        let angle: CGFloat = atan2(p.y - o.y, p.x - o.x)
        return angle
    }
    
    //刷新动画
    @IBAction func Refersh(sender: AnyObject) {
        box.hidden = true
        viewDidLoad()
    }
    
}
