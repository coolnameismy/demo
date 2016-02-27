//
//  ViewController.m
//  foo
//
//  Created by ZTELiuyw on 16/2/14.
//  Copyright © 2016年 liuyanwei. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>


@interface ViewController ()

@end

@implementation ViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _liu = [LYWUser factoryA];
    
//    [self performSelector:@selector(hi)];
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@", NSStringFromClass([super class]));
    
//    [self text1];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    Class newClass =  objc_allocateClassPair([NSObject class],"TestClass",0);
//    class_addMethod(newClass, @selector(hello), (IMP)hello, "v:@");
//    objc_registerClassPair(newClass);
    
    
  }

-(void)hello{
     NSLog(@"hello");
}

//动态注册类和方法
-(void)text1{
    

    
    NSLog(@"类的名称：%s",class_getName([self class]));
    NSLog(@"父类名称：%@",class_getSuperclass([self class]));
    NSLog(@"是否是元类：%d",class_isMetaClass([NSObject class]));
    NSLog(@"实例变量大小：%zu",class_getInstanceSize([self class]));
    
    NSLog(@"%@",class_getInstanceVariable([LYWUser class], "liu"));
    Ivar string = class_getInstanceVariable([LYWUser class], "_str");
    NSLog(@"获取实例变量名称：%s",ivar_getName(string));
    
    // 获取成员变量
    unsigned int outCount = 0 ;
    Ivar *ivars = class_copyIvarList([_liu class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"成员变量: %s at index: %d", ivar_getName(ivar), i);
    }
    free(ivars);
}

//+(BOOL)resolveClassMethod:(SEL)sel{
//    NSLog(@" >> Class resolving %@", NSStringFromSelector(sel));
//    return [super resolveClassMethod:sel];
//}
//
//+(BOOL)resolveInstanceMethod:(SEL)sel{
//
//    NSLog(@"找不到方法：%@",NSStringFromSelector(sel));
////    NSLog(@" >> Class resolving %@", NSStringFromSelector(sel));
////    return YES;
//    return [super resolveInstanceMethod:sel];
//}
////
//-(id)forwardingTargetForSelector:(SEL)aSelector{
//    NSLog(@"forwardingTargetForSelector：%@",NSStringFromSelector(aSelector));
//    // 将消息转发给_helper来处理
//    if ([NSStringFromSelector(aSelector) isEqualToString:@"hi"]) {
//        return _liu;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//    
//}
//
//-(void)forwardInvocation:(NSInvocation *)anInvocation{
//    
//    
//}
//-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//    
//}


@end
