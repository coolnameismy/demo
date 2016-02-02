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
  
    
}

-(void)requestBySync{
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8001"]];
    NSURLResponse *resp; NSError *err;

    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    if (err) {
        NSLog(@"%@",err);
        return;
    }
    NSLog(@"==resq====%@",resp);
    NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err ]);
    
}

-(void)createUI{


    UIProgressView *pv = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width , 10)];
    [self.view addSubview:pv];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试网络请求" message:@"嘿嘿嘿" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"requestBySync" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestBySync];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"requestToGetNoticeListWithUserId" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
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
    [alert addAction:act6];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

@end
