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
        
        //自定义的MotionEffect效果
        //addMyMotionEffect()
        
    }
    
    //布置舞台
    func scenery(){
        //bg 背景
        bg = UIImageView(image: UIImage(named:"bg.jpeg"))
        sceneryElement(CGRect(x: -100, y: -100, width: vwidth+200, height: vheight+200), imageView: bg)
        
        //yurt 蒙古包
        yurt1 = UIImageView(image: UIImage(named: "yurt1"))
        yurt2 = UIImageView(image: UIImage(named: "yurt2"))
        sceneryElement(CGRect(x: vwidth-250, y: vheight/2-100, width: 200, height: 75), imageView: yurt1)
        sceneryElement(CGRect(x: vwidth-140, y: vheight/2-150, width: 120, height: 50), imageView: yurt2)

        //ship 飞船
        ship = UIImageView(image: UIImage(named:"ship"))
        sceneryElement(CGRect(x: vwidth/3, y: vheight/2, width: vwidth/3*2, height: vwidth/3), imageView: ship)
        
        //text 文字
        text = UIImageView(image: UIImage(named:"text"))
        sceneryElement(CGRect(x: 20, y: vheight/3*2, width: vwidth/3, height: vwidth/3), imageView: text)
        
        //octocat 章鱼猫
        octocat = UIImageView(image: UIImage(named:"octocat"))
        sceneryElement(CGRect(x: vwidth/2-vwidth/6+40  , y: vheight/3*2, width: vwidth/3, height: vwidth/3*1.2), imageView: octocat)
        
    }
    
    //motionEffects 效果
    //bg 背景 //yurt 蒙古包 //ship 飞船 //text 文字 //octocat 章鱼猫
    func motionEffects(){
        addInterpolatingMotionEffect(100, target: bg)
        addInterpolatingMotionEffect(120, target: yurt2)
        addInterpolatingMotionEffect(160, target: yurt1)
        addInterpolatingMotionEffect(480, target: ship)
        addInterpolatingMotionEffect(20, target: octocat)
        addInterpolatingMotionEffect(50, target: text)
        
    }

   
    
    
    //初始化场景元素
    func sceneryElement(frame:CGRect, imageView:UIImageView){
        imageView.frame = frame
        view.addSubview(imageView)
    }
    
    //添加Interpolation motion effect的工具方法
    func addInterpolatingMotionEffect(scope:Int,target:UIImageView){

        //初始化一个 水平方向的 UIInterpolatingMotionEffect
        let x_interpolation = UIInterpolatingMotionEffect(keyPath: "center.x", type:.TiltAlongHorizontalAxis)
        //最大最小值设置
        x_interpolation.minimumRelativeValue = -scope;
        x_interpolation.maximumRelativeValue = scope;
        
        //初始化一个 垂直方向的 UIInterpolatingMotionEffect
        let y_interpolation = UIInterpolatingMotionEffect(keyPath: "center.y", type:.TiltAlongVerticalAxis)
        //最大最小值设置
        y_interpolation.minimumRelativeValue = -scope/2;
        y_interpolation.maximumRelativeValue = scope/2;
        
        //建立一个MotionEffectGroup,并把水平和垂直两种效果
        let effectGroup =  UIMotionEffectGroup()
        effectGroup.motionEffects = [x_interpolation,y_interpolation]
        
        //将MotionEffe绑定到UI元素上
        target.addMotionEffect(effectGroup)
        
        
    }

    //自定义的MotionEffect效果
    func addMyMotionEffect(){
        myView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        myView.backgroundColor = UIColor.redColor()
        view.addSubview(myView)
        
        myMotionEffect = MyMotionEffect()
        myView.addMotionEffect(myMotionEffect)
    }

}

//自定义的MotionEffect类
public class MyMotionEffect:UIMotionEffect {
    override public func keyPathsAndRelativeValuesForViewerOffset(viewerOffset: UIOffset) -> [String : AnyObject]? {
        //打印设备水平角度
        NSLog("x:%f,y:%f", viewerOffset.horizontal,viewerOffset.vertical)
        //返回对象是一个字典类型，key是修改UIView的键路径，value是修改的值
        return ["center.y":fabs(viewerOffset.horizontal*1000)]

    }
}
