//
//  BezierStep.h
//  Paint
//
//  Created by ZTELiuyw on 15/7/27.
//  Copyright (c) 2015年 刘彦玮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum {
    BezierStepStatusSetStart,
    BezierStepStatusSetEnd,
    BezierStepStatusSetControl
}BezierStepStatus;

@interface BezierStep : NSObject{
    
@public
    
    //路径
    CGPoint startPoint;
    CGPoint controlPoint;
    CGPoint endPoint;
    //颜色
    CGColorRef color;
    //笔画粗细
    float strokeWidth;
    //步骤状态
    BezierStepStatus status;
}


@end
