//
//  LYWUser.m
//  foo
//
//  Created by ZTELiuyw on 16/2/14.
//  Copyright © 2016年 liuyanwei. All rights reserved.
//

#import "LYWUser.h"

@implementation LYWUser


+(instancetype)factoryA{
   return [[[self class]alloc]init];
//    return [[LYWUser alloc]init];

}
+(id)factoryB{
   return [[LYWUser alloc]init];
}


-(void)hi{
    NSLog(@"========hi=========");
    NSLog(@"%@, %p", self, _cmd);
}
@end
