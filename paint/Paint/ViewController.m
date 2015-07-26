//
//  ViewController.m
//  Paint
//
//  Created by 刘彦玮 on 15/7/26.
//  Copyright (c) 2015年 刘彦玮. All rights reserved.
//

#import "ViewController.h"
#import "PaintViewV01.h"
#import "PaintViewV02.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    PaintViewV01 *paintView = [[PaintViewV01 alloc]initWithFrame:self.view.frame];
    PaintViewV02 *paintView = [[PaintViewV02 alloc]initWithFrame:self.view.frame];
    [self.view addSubview:paintView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
