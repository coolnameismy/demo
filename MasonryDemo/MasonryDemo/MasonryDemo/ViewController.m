//
//  ViewController.m
//  MasonryDemo
//
//  Created by 刘彦玮 on 15/9/19.
//  Copyright (c) 2015年 刘彦玮. All rights reserved.
//

#import "ViewController.h"
#import "Masonry/Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //高级布局练习 ios自带计算器布局
    [self exp4];
}

//高级布局练习 ios自带计算器布局
-(void)exp4{
    
    
    //申明区域，displayView是显示区域，keyboardView是键盘区域
    UIView *displayView = [UIView new];
    [displayView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:displayView];
    
    UIView *keyboardView = [UIView new];
    [self.view addSubview:keyboardView];
    
    //先按1：3分割 displView（显示结果区域）和 keyboardView（键盘区域）
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(keyboardView).multipliedBy(0.3f);
    }];
    
    [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(displayView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.and.right.equalTo(self.view);
        
    }];
    
    //设置显示位置的数字为0
    UILabel *displayNum = [[UILabel alloc]init];
    [displayView addSubview:displayNum];
    displayNum.text = @"0";
    displayNum.font = [UIFont fontWithName:@"HeiTi SC" size:70];
    displayNum.textColor = [UIColor whiteColor];
    displayNum.textAlignment = NSTextAlignmentRight;
    [displayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(displayView).with.offset(-10);
        make.bottom.equalTo(displayView).with.offset(-10);
    }];
    
    
    //定义键盘键名称，？号代表合并的单元格
    NSArray *keys = @[@"AC",@"+/-",@"%",@"÷"
                      ,@"7",@"8",@"9",@"x"
                      ,@"4",@"5",@"6",@"-"
                      ,@"1",@"2",@"3",@"+"
                      ,@"0",@"?",@".",@"="];
    
    
    int indexOfKeys = 0;
    for (NSString *key in keys){
        //循环所有键
        indexOfKeys++;
        int rowNum = indexOfKeys %4 ==0? indexOfKeys/4:indexOfKeys/4 +1;
        int colNum = indexOfKeys %4 ==0? 4 :indexOfKeys %4;
        NSLog(@"index is:%d and row:%d,col:%d",indexOfKeys,rowNum,colNum);
        
        //键样式
        UIButton *keyView = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardView addSubview:keyView];
        [keyView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyView setTitle:key forState:UIControlStateNormal];
        [keyView.layer setBorderWidth:1];
        [keyView.layer setBorderColor:[[UIColor blackColor]CGColor]];
        [keyView.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30]];
        
        //键约束
        [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //处理 0 合并单元格
            if([key isEqualToString:@"0"] || [key isEqualToString:@"?"] ){
                
                if([key isEqualToString:@"0"]){
                    [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                        make.width.equalTo(keyboardView.mas_width).multipliedBy(.5);
                        make.left.equalTo(keyboardView.mas_left);
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }];
                }if([key isEqualToString:@"?"]){
                    [keyView removeFromSuperview];
                }
                
            }
            //正常的单元格
            else{
                make.width.equalTo(keyboardView.mas_width).with.multipliedBy(.25f);
                make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                
                //按照行和列添加约束，这里添加行约束
                switch (rowNum) {
                    case 1:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.1f);
                        keyView.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
                        
                    }
                        break;
                    case 2:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.3f);
                    }
                        break;
                    case 3:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.5f);
                    }
                        break;
                    case 4:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.7f);
                    }
                        break;
                    case 5:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }
                        break;
                    default:
                        break;
                }
                //按照行和列添加约束，这里添加列约束
                switch (colNum) {
                    case 1:
                    {
                        make.left.equalTo(keyboardView.mas_left);
                        
                    }
                        break;
                    case 2:
                    {
                        make.right.equalTo(keyboardView.mas_centerX);
                        
                    }
                        break;
                    case 3:
                    {
                        make.left.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 4:
                    {
                        make.right.equalTo(keyboardView.mas_right);
                        [keyView setBackgroundColor:[UIColor colorWithRed:243 green:127 blue:38 alpha:1]];
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
    }
    
}

@end
