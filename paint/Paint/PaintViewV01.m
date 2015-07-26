//
//  PaintView.m
//  Paint
//
//  Created by 刘彦玮 on 15/7/26.
//  Copyright (c) 2015年 刘彦玮. All rights reserved.
//

#import "PaintViewV01.h"




@implementation PaintViewV01{

    //画的线路径的集合，内部是NSMutableArray类型
    NSMutableArray *paths;
}

-(instancetype)init{
    self = [super init];
    if (self) {
       //初始化uiview的样式
        [self paintViewInit];
    }
    return  self;
}
-(instancetype)initWithFrame:(CGRect)frame{
        self = [super initWithFrame:frame];
        if (self) {
            //初始化uiview的样式
            [self paintViewInit];
        }
        return  self;
}

//初始化paintViewInit样式和数据
-(void)paintViewInit{
    //添加背景色
    self.backgroundColor = [UIColor whiteColor];
    //初始化路径集合
    paths = [[NSMutableArray alloc]init];
}

-(void)drawRect:(CGRect)rect{
    //必须调用父类drawRect方法，否则 UIGraphicsGetCurrentContext()获取不到context
    [super drawRect:rect];
    //获取ctx
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //渲染所有路径
    for (int i=0; i<paths.count; i++) {
        NSMutableArray *pathPoints = [paths objectAtIndex:i];
        CGMutablePathRef path = CGPathCreateMutable();
        for (int j=0; j<pathPoints.count; j++) {
            CGPoint point = [[pathPoints objectAtIndex:j]CGPointValue] ;
            if (j==0) {
                CGPathMoveToPoint(path, &CGAffineTransformIdentity, point.x,point.y);
            }else{
                CGPathAddLineToPoint(path, &CGAffineTransformIdentity, point.x, point.y);
            }
        }
        //路径添加到ct
        CGContextAddPath(ctx, path);
        //描边
        CGContextStrokePath(ctx);
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //创建一个路径，放到paths里面
    NSMutableArray *path = [[NSMutableArray alloc]init];
    [paths addObject:path];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //获取当前路径
    NSMutableArray *path = [paths lastObject];
    //获取当前点
    CGPoint movePoint = [[touches anyObject]locationInView:self];
    NSLog(@"touchesMoved     x:%f,y:%f",movePoint.x,movePoint.y);
    //CGPint要通过NSValue封装一次才能放入NSArray
    [path addObject:[NSValue valueWithCGPoint:movePoint]];
    //通知重新渲染界面，这个方法会重新调用UIView的drawRect:(CGRect)rect方法
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

@end
