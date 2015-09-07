//
//  PaintView.m
//  Paint
//
//  Created by 刘彦玮 on 15/7/26.
//  Copyright (c) 2015年 刘彦玮. All rights reserved.
//

#import "PaintViewV03.h"


typedef enum {
    PaintViewModeStroke,
    PaintViewModeBezier
} PaintViewMode;

//屏幕的宽高，做自适应用的
#define width  [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

@implementation PaintViewV03{

    //画的线路径的集合，内部是NSMutableArray类型
    NSMutableArray *paintSteps;
    //当前选中的颜色
    UIColor *currColor;
    //当前笔触粗细选择器
    UISlider *slider;
    //当前绘图模式
    PaintViewMode paintViewMode;
    
    //画的线路径的集合，内部是NSMutableArray类型
    NSMutableArray *bezierSteps;
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
    paintSteps = [[NSMutableArray alloc]init];
    bezierSteps = [[NSMutableArray alloc]init];
    //创建色板
    [self createColorBord];
    
    //创建笔触粗细选择器
    [self createStrokeWidthSlider];
    
    //增加控制面板
    [self createControlBoard];
    
}

//创建色板
-(void)createColorBord{
    //默认当前笔触颜色是黑色
    currColor = [UIColor blackColor];
    //色板的view
    UIView *colorBoardView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width, 20)];
    [self addSubview:colorBoardView];
    //色板样式
    colorBoardView.layer.borderWidth = 1;
    colorBoardView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //创建每个色块
    NSArray *colors = [NSArray arrayWithObjects:
                       [UIColor blackColor],[UIColor redColor],[UIColor blueColor],
                       [UIColor greenColor],[UIColor yellowColor],[UIColor brownColor],
                       [UIColor orangeColor],[UIColor whiteColor],[UIColor orangeColor],
                       [UIColor purpleColor],[UIColor cyanColor],[UIColor lightGrayColor], nil];
    for (int i =0; i<colors.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((width/colors.count)*i, 0, width/colors.count, 20)];
        [colorBoardView addSubview:btn];
        [btn setBackgroundColor:colors[i]];
        [btn addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


//增加控制面板
-(void)createControlBoard{
    paintViewMode = PaintViewModeStroke;
    
    UIView *controlBoard = [[UIView alloc]initWithFrame:CGRectMake(0, 60, 60, height-50)];
    [self addSubview:controlBoard];
    NSMutableArray *boards = [[NSMutableArray alloc]init];
    
    //bezier曲线面板
    UIButton *berzierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [berzierBtn setBackgroundImage:[UIImage imageNamed:@"bezierBoard" ] forState:UIControlStateNormal];
    [berzierBtn addTarget:self action:@selector(berzierBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [boards addObject:berzierBtn];
    
    
    //添加面板包含的每一个按钮
    int vercital = 20;
    int horizontal = 10;
    int btnWH = 60;
    for (int i = 0 ; i< boards.count ; i++) {
        UIButton *btn = boards[i];
        btn.frame = CGRectMake(horizontal,(i+1)* vercital ,btnWH, btnWH);
        [controlBoard addSubview:btn];
    }
    
    
}

//切换颜色
-(void)changeColor:(id)target{
    UIButton *btn = (UIButton *)target;
    currColor = [btn backgroundColor];
}

//创建笔触粗细选择器
-(void)createStrokeWidthSlider{
    slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 50, width, 20)];
    slider.maximumValue = 20;
    slider.minimumValue = 1;
    [self addSubview:slider];
}






-(void)drawRect:(CGRect)rect{
    //必须调用父类drawRect方法，否则 UIGraphicsGetCurrentContext()获取不到context
    [super drawRect:rect];
    //获取ctx
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //渲染所有路径
    for (int i=0; i<paintSteps.count; i++) {
        PaintStep *step = paintSteps[i];
        NSMutableArray *pathPoints = step->pathPoints;
        CGMutablePathRef path = CGPathCreateMutable();
        for (int j=0; j<pathPoints.count; j++) {
            CGPoint point = [[pathPoints objectAtIndex:j]CGPointValue] ;
            if (j==0) {
                CGPathMoveToPoint(path, &CGAffineTransformIdentity, point.x,point.y);
            }else{
                CGPathAddLineToPoint(path, &CGAffineTransformIdentity, point.x, point.y);
            }
        }
        //设置path 样式
        CGContextSetStrokeColorWithColor(ctx, step->color);
        CGContextSetLineWidth(ctx, step->strokeWidth);
        //路径添加到ct
        CGContextAddPath(ctx, path);
        //描边
        CGContextStrokePath(ctx);
    }
    
    //渲染bezier路径
    for (int i=0; i<bezierSteps.count; i++) {
        BezierStep *step = bezierSteps[i];
        //设置path 样式
        CGContextSetStrokeColorWithColor(ctx, step->color);
        CGContextSetLineWidth(ctx, step->strokeWidth);
        //路径参考线
        CGContextMoveToPoint(ctx, step->startPoint.x, step->startPoint.y);
        CGContextAddQuadCurveToPoint(ctx, step->controlPoint.x, step->controlPoint.y, step->endPoint.x, step->endPoint.y);
        //描边
        CGContextStrokePath(ctx);
            
        switch (step->status) {
            case BezierStepStatusSetControl:
                //画出起点到控制线的距离
            {
                //设置path 样式
                CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.233 green:0.480 blue:0.858 alpha:1.000].CGColor);
                //虚线线条样式
                CGFloat lengths[] = {10,10};
                CGContextSetLineDash(ctx, 1, lengths, 2);
                CGContextMoveToPoint(ctx, step->startPoint.x, step->startPoint.y);
                CGContextAddLineToPoint(ctx, step->controlPoint.x, step->controlPoint.y);
                CGContextAddLineToPoint(ctx, step->endPoint.x, step->endPoint.y);
                CGContextStrokePath(ctx);
            }
                break;
                
            default:
                break;
        }
        
        
            }
}




#pragma mark -手指移动

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
    switch (paintViewMode) {

        //笔画模式
        case PaintViewModeStroke:
            [self strokeModeTouchesBegan:touches withEvent:event];
            break;
        //曲线模式
        case PaintViewModeBezier:
            [self bezierModeTouchesBegan:touches withEvent:event];
            break;
        default:
            break;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    switch (paintViewMode) {
            
            //笔画模式
        case PaintViewModeStroke:
            [self strokeModeTouchesMoved:touches withEvent:event];
            break;
            //曲线模式
        case PaintViewModeBezier:
            [self bezierModeTouchesMoved:touches withEvent:event];
            break;
        default:
            break;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    switch (paintViewMode) {
            
            
            //笔画模式
        case PaintViewModeStroke:
            [self strokeModeTouchesEnded:touches withEvent:event];
            break;
            //曲线模式
        case PaintViewModeBezier:
            [self bezierModeTouchesEnded:touches withEvent:event];
            break;
        default:
            break;
    }

}

-(void)strokeModeTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
    PaintStep *paintStep = [[PaintStep alloc]init];
    paintStep->color = currColor.CGColor;
    paintStep->pathPoints =  [[NSMutableArray alloc]init];
    paintStep->strokeWidth = slider.value;
    [paintSteps addObject:paintStep];
}

-(void)strokeModeTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //获取当前路径
    PaintStep *step = [paintSteps lastObject];
    NSMutableArray *pathPoints = step->pathPoints;
    //获取当前点
    CGPoint movePoint = [[touches anyObject]locationInView:self];
    NSLog(@"touchesMoved     x:%f,y:%f",movePoint.x,movePoint.y);
    //CGPint要通过NSValue封装一次才能放入NSArray
    [pathPoints addObject:[NSValue valueWithCGPoint:movePoint]];
    //通知重新渲染界面，这个方法会重新调用UIView的drawRect:(CGRect)rect方法
    [self setNeedsDisplay];
}

-(void)strokeModeTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
   
}



-(void)bezierModeTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //创建贝塞尔 步骤
    BezierStep *step = [bezierSteps lastObject];
    CGPoint point =[[touches anyObject]locationInView:self];
    
    if (step) {
        switch (step->status) {
            
            case BezierStepStatusSetStart:
            {
                step->endPoint = point;
                step->status = BezierStepStatusSetControl;
            }   
                break;
            case BezierStepStatusSetEnd:
            {
                step =  [[BezierStep alloc]init];
                step->color = currColor.CGColor;
                step->strokeWidth = slider.value;
                [bezierSteps addObject:step];
            }
                break;
                
            default:
                break;
        }
        
    }else{
        step =  [[BezierStep alloc]init];
        step->color = currColor.CGColor;
        step->strokeWidth = slider.value;
        [bezierSteps addObject:step];
    }
    
    
}

-(void)bezierModeTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    BezierStep *step = [bezierSteps lastObject];
    CGPoint point =[[touches anyObject]locationInView:self];
    switch (step->status) {
    
        case BezierStepStatusSetControl:
        {
            step->controlPoint = point;
        }
            
            break;
        default:
            break;
    }
    
     [self setNeedsDisplay];

}

-(void)bezierModeTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    BezierStep *step = [bezierSteps lastObject];
    CGPoint point =[[touches anyObject]locationInView:self];
    switch (step->status) {
        case BezierStepStatusSetStart:
        {
            step->startPoint = point;
//            step->status = BezierStepStatusSetControl;
        }
             break;
        case BezierStepStatusSetControl:
        {
            step->controlPoint = point;
            step->status = BezierStepStatusSetEnd;
        }
            break;

        default:
            break;
    }
    

    
}

#pragma mark -控制面板按钮点击
//贝塞尔按钮的点击事件
-(void)berzierBtnClick:(id)sender{
    UIButton *btn = sender;
    if(paintViewMode == PaintViewModeStroke){
        paintViewMode = PaintViewModeBezier;
        [btn setBackgroundImage:[UIImage imageNamed:@"bezierBoard_l"] forState:UIControlStateNormal];
    }else{
        paintViewMode = PaintViewModeStroke;
        [btn setBackgroundImage:[UIImage imageNamed:@"bezierBoard"] forState:UIControlStateNormal];
    }
    
}

@end
