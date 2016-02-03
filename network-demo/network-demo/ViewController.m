//
//  ViewController.m
//  network-demo
//
//  Created by 刘彦玮 on 16/1/8.
//  Copyright © 2016年 刘彦玮. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}

#pragma mark -同步请求
-(void)requestBySync{
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8001"]];
    NSURLResponse *resp; NSError *err;

    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    NSLog(@"====请求开始====");
    
    
    //检查错误
    if (err) {
        NSLog(@"%@",err);
        NSLog(@"==resq====%@",resp);
        return;
    }
    
    //检验状态码
    if ([resp isKindOfClass:[NSHTTPURLResponse class]]) {
        if (((NSHTTPURLResponse *)resp).statusCode != 200) {
            return;
        }
    }
   
    //解析json
    NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err ]);
    
    NSLog(@"====请求结束====");
}

#pragma mark -异步队列请求
-(void)requestByAsyncQueue{

    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8001"]];
    NSURLResponse *resp;
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //发送异步请求
    [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        //检查错误
        if (connectionError) {
            NSLog(@"%@",connectionError);
            NSLog(@"==resq====%@",resp);
            return;
        }
        
        //检验状态码
        if ([resp isKindOfClass:[NSHTTPURLResponse class]]) {
            if (((NSHTTPURLResponse *)resp).statusCode != 200) {
                return;
            }
        }
        //解析json
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil ]);
        
        NSLog(@"====请求结束====");
    }];
    
    NSLog(@"====请求开始1====");
  
    
    //发送异步请求
    [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        //检查错误
        if (connectionError) {
            NSLog(@"%@",connectionError);
            NSLog(@"==resq====%@",resp);
            return;
        }
        
        //检验状态码
        if ([resp isKindOfClass:[NSHTTPURLResponse class]]) {
            if (((NSHTTPURLResponse *)resp).statusCode != 200) {
                return;
            }
        }
        //解析json
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil ]);
        
        NSLog(@"====请求结束2====");
    }];
    NSLog(@"====请求开始2====");

}

-(void)createUI{

    //做一个不同运动的动画去观察主线程的阻塞情况
//    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [box setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:box];
//    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
//    ani.byValue =  [NSValue valueWithCGPoint:CGPointMake( self.view.frame.size.width,0 )];
//    ani.duration = 1;
//    ani.repeatCount = 100000;
//    //这两个属性若不设置，动画执行后回复位
//    ani.removedOnCompletion = NO;
//    ani.fillMode = kCAFillModeForwards;
//    //开始动画
//    [box.layer addAnimation:ani forKey:@""];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

-(void)tick{
    NSLog(@"%@",[NSDate date]);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试网络请求" message:@"嘿嘿嘿" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"requestBySync" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestBySync];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"requestByAsyncQueue" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestByAsyncQueue];
    }];
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"githubUserInfo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction *act4 = [UIAlertAction actionWithTitle:@"requestToGetNoticeListWithUserId1" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction *act5 = [UIAlertAction actionWithTitle:@"githubUserInfo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction *act6 = [UIAlertAction actionWithTitle:@"githubUserInfo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction *act00 = [UIAlertAction actionWithTitle:@"cannel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    [alert addAction:act1];
    [alert addAction:act2];
    [alert addAction:act3];
    [alert addAction:act4];
    [alert addAction:act5];
    [alert addAction:act00];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

@end
