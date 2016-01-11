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
    // Do any additional setup after loading the view, typically from a nib.
    
    //string 转 url编码
    NSString *urlString = @"http://wwW.xxx.com?query= this is question";
    NSLog(@"%@",urlString);

//    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"%@",url.query);

    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSLog(@"%@",url.query);
    
    
    
//    NSLog(@"%@",[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
//          
//    NSLog(@"%@",[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
//    NSLog(@"---------%@--------",urlString);
//    NSString *urlEncodeString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet uppercaseLetterCharacterSet]];
//   NSLog(@"%@",urlEncodeString);
//    urlEncodeString = [urlEncodeString stringByRemovingPercentEncoding];
////        [urlEncodeString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//   NSLog(@"%@",urlEncodeString);
//

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
