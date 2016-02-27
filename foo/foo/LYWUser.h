//
//  LYWUser.h
//  foo
//
//  Created by ZTELiuyw on 16/2/14.
//  Copyright © 2016年 liuyanwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYWUser : NSObject

+(instancetype)factoryA;
+(id)factoryB;


//标准
@property (weak) NSString *str;
@property (weak) NSString *str1;
@property (weak) NSArray *arry;

@property (nonatomic, weak) NSString *str_weak;
@property (strong) NSMutableString *mutStr_strong;
@property (copy) NSString *str_copy;
@property (strong) NSMutableArray *mutArry_strong;
@property (weak) NSArray *arry_weak;
@property (copy) NSArray *arry_copy;

//有问题的属性
@property (strong) NSString *str_strong;
@property (strong) NSArray *arry_strong;
@property (copy) NSMutableString *mutStr_copy;
@property (copy) NSMutableArray *mutArry_copy;

 

@end
