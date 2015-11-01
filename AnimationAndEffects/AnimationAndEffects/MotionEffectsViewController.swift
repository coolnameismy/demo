//
//  MotionEffectsViewController.swift
//  AnimationAndEffects
//
//  Created by 刘彦玮 on 15/10/31.
//  Copyright © 2015年 liuyanwei. All rights reserved.
//

import UIKit

class MotionEffectsViewController: UIViewController {

    
    var bg:UIImageView!
    var text:UIImageView!
    var octocat:UIImageView!
    var octocatShadow:UIImageView!
    var ship:UIImageView!
    var shipShadow:UIImageView!
    var yurt1:UIImageView!
    var yurt2:UIImageView!
    
    var vheight:CGFloat!
    var vwidth:CGFloat!

    var myMotionEffect:MyMotionEffect!
    var myView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vheight = view.frame.size.height
        vwidth = view.frame.size.width

        //布置舞台
        scenery()
        //motion effects
        motionEffects()
        
    }
    
    //布置舞台
    func scenery(){
        //bg
        bg = UIImageView(image: UIImage(named:"bg.jpeg"))
        sceneryElement(CGRect(x: -100, y: -100, width: vwidth+200, height: vheight+200), imageView: bg)
        
        //yurt
        yurt1 = UIImageView(image: UIImage(named: "yurt1"))
        yurt2 = UIImageView(image: UIImage(named: "yurt2"))
        sceneryElement(CGRect(x: vwidth-250, y: vheight/2-100, width: 200, height: 75), imageView: yurt1)
        sceneryElement(CGRect(x: vwidth-140, y: vheight/2-150, width: 120, height: 50), imageView: yurt2)

        //ship
        ship = UIImageView(image: UIImage(named:"ship"))
        sceneryElement(CGRect(x: vwidth/3, y: vheight/2, width: vwidth/3*2, height: vwidth/3), imageView: ship)
        
        //text
        text = UIImageView(image: UIImage(named:"text"))
        sceneryElement(CGRect(x: 20, y: vheight/3*2, width: vwidth/3, height: vwidth/3), imageView: text)
        
        //octocat
        octocat = UIImageView(image: UIImage(named:"octocat"))
        sceneryElement(CGRect(x: vwidth/2-vwidth/6+40  , y: vheight/3*2, width: vwidth/3, height: vwidth/3*1.2), imageView: octocat)
        
        myView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        myView.backgroundColor = UIColor.redColor()
        view.addSubview(myView)
    }
    
    //motionEffects 效果
    func motionEffects(){
        addInterpolatingMotionEffect(100, target: bg)
        addInterpolatingMotionEffect(120, target: yurt2)
        addInterpolatingMotionEffect(160, target: yurt1)
        addInterpolatingMotionEffect(480, target: ship)
//        addInterpolatingMotionEffect(20, target: octocat)
        addInterpolatingMotionEffect(50, target: text)
        
        myMotionEffect = MyMotionEffect()
        myView.addMotionEffect(myMotionEffect)
    }
    
    
    //初始化场景元素
    func sceneryElement(frame:CGRect, imageView:UIImageView){
        imageView.frame = frame
        view.addSubview(imageView)
    }
    
    //添加Interpolation motion effect
    func addInterpolatingMotionEffect(scope:Int,target:UIImageView){
        let x_interpolation = UIInterpolatingMotionEffect(keyPath: "center.x", type:.TiltAlongHorizontalAxis)
        x_interpolation.minimumRelativeValue = -scope;
        x_interpolation.maximumRelativeValue = scope;
        let y_interpolation = UIInterpolatingMotionEffect(keyPath: "center.y", type:.TiltAlongVerticalAxis)
        y_interpolation.minimumRelativeValue = -scope/2;
        y_interpolation.maximumRelativeValue = scope/2;
        
        let effectGroup =  UIMotionEffectGroup()
        effectGroup.motionEffects = [x_interpolation,y_interpolation]
        
        target.addMotionEffect(effectGroup)
        
//myView.center

    }

    

}

public class MyMotionEffect:UIMotionEffect {
    override public func keyPathsAndRelativeValuesForViewerOffset(viewerOffset: UIOffset) -> [String : AnyObject]? {
        NSLog("x:%f,y:%f", viewerOffset.horizontal,viewerOffset.vertical)
//        return ["center":NSValue(CGPoint: CGPoint(x: 20, y: 20))]

        return ["center.y":fabs(viewerOffset.horizontal*1000)]
//       return ["hidden":false] //target.hidden = true
    }
}
