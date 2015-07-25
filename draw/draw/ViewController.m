//
//  ViewController.m
//  draw
//
//  Created by 刘彦玮 on 15/7/23.
//  Copyright (c) 2015年 刘彦玮. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建画图的画板
    DrawBoard *board = [[DrawBoard alloc]initWithFrame:self.view.frame];
    [self.view addSubview:board];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
