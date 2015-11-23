// Playground - noun: a place where people can play

import UIKit

//#import <QuartzCore/CATransform3D.h>


let bg = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
bg.backgroundColor = UIColor.whiteColor()

let sth = UIView(frame:CGRect(x: 0, y: 0, width: 300, height: 300))
sth.backgroundColor = UIColor.greenColor()
sth.center = bg.center
bg.addSubview(sth)


//仿射 位移
let myAffine1 = CGAffineTransformMakeTranslation(300, 300)
sth.transform = myAffine1
bg

//仿射 位移
let myAffine2 = CGAffineTransformMakeTranslation(100, 100)
sth.transform = CGAffineTransformConcat(myAffine1, myAffine2)
bg



//仿射 基础矩阵
//[
//    a  b  0
//    c  d  0
//    tx ty 1
//]


//仿射 位移 translation
//[
//    1  0  0
//    0  1  0
//    tx ty 1
//]

let translationAffine = CGAffineTransformMake(1,0,0,1,300,300)
sth.transform = translationAffine
bg


//仿射 斜切 shear
//[
//    1, shx, 0
//   shy, 1, 0
//    0 , 0, 1
//]

let shearAffine = CGAffineTransformMake(1,0.5,0.5,1,0,0)
let shearAffine1 = CGAffineTransformMake
sth.transform = shearAffine
bg




//仿射 放大缩小 scale
//[
//    sx  0  0
//    0  sy  0
//    0   0  1
//]

//let scaleAffine1 = CGAffineTransformMakeScale(2, 2)
let scaleAffine = CGAffineTransformMake(2,0,0,2,0,0)
sth.transform = scaleAffine
bg


//仿射 旋转（Rotation）
let rotation1 =  CGAffineTransformMakeRotation(CGFloat( M_PI_4 ))
let rotation = CGAffineTransformMake(CGFloat( cos(M_PI_4) ), CGFloat( sin(M_PI_4) ), -CGFloat( sin(M_PI_4) ), CGFloat( cos(M_PI_4) ), 0, 0)

sth.transform = rotation
bg



