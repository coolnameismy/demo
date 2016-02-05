//
//  ViewController.m
//  network-demo
//
//  Created by 刘彦玮 on 16/1/8.
//  Copyright © 2016年 刘彦玮. All rights reserved.
//

#import "ViewController.h"
#import "http_queue_async_request_ViewController.h"
#import "HttpsByNSURLConnection_ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    NSArray *btns = @[@"同步请求和异步队列请求demo",
                      @"异步请求，https认证，上传下载请进度demo"];
    int i = 0;
    
    for (NSString *item in btns) {
        i++;
        UIButton *btn =  [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setFrame:CGRectMake(10,30+i*30, self.view.frame.size.width - 20, 30)];
        [btn setTitle:item forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClicked:)]];
        btn.tag = 10000+i;
    }
    
}

-(void)btnClicked:(UITapGestureRecognizer *)sender{
    UIButton *btn = (UIButton *)sender.view;
    UIViewController *vc;
    switch (btn.tag) {
        case 10001:
        {
            vc = [[http_queue_async_request_ViewController alloc]init];
        }
            break;
        case 10002:
        {
            vc = [[HttpsByNSURLConnection_ViewController alloc]init];
        }
            break;
        default:
            break;
    }
    [vc.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end