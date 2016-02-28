//
//  ViewController.m
//  foo
//
//  Created by ZTELiuyw on 16/2/14.
//  Copyright © 2016年 liuyanwei. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "extobjc.h"

//
//
//#define ext_weakify_(INDEX, CONTEXT, VAR) \
//CONTEXT __typeof__(VAR) metamacro_concat(VAR, _weak_) = (VAR);
//
//
//
//#define weakify(...) \
//ext_keywordify \
//metamacro_foreach_cxt(ext_weakify_,, __weak, __VA_ARGS__)
//
//#if defined(DEBUG) && !defined(NDEBUG)
//#define ext_keywordify autoremetamacro_argcountleasepool {}
//#else
//#define ext_keywordify try {} @catch (...) {}
//#endif
//
//#define metamacro_foreach_cxt(MACRO, SEP, CONTEXT, ...) \
//metamacro_concat(metamacro_foreach_cxt, metamacro_argcount(__VA_ARGS__))(MACRO, SEP, CONTEXT, __VA_ARGS__)
//
//#define metamacro_argcount(...) \
//metamacro_at(20, __VA_ARGS__, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
//
///**
// * Returns A and B concatenated after full macro expansion.
// */
//#define metamacro_concat(A, B) \
//metamacro_concat_(A, B)
//
//
//#define ext_strongify_(INDEX, VAR) \
//__strong __typeof__(VAR) VAR = metamacro_concat(VAR, _weak_);

  

@interface ViewController ()

typedef void(^LYWCompletionBlock)(NSString *name);



@property (nonatomic,copy) LYWCompletionBlock completionBlock;
@property (nonatomic,copy) dispatch_block_t completionBlock1;


@property (nonatomic, copy) NSString *aaa;


@end

@implementation ViewController


-(instancetype)init{
    self = [super init];
    if (self) {
          }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    _liu = [LYWUser factoryA];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    Class newClass =  objc_allocateClassPair([NSObject class],"TestClass",0);
//    class_addMethod(newClass, @selector(hello), (IMP)hello, "v:@");
//    objc_registerClassPair(newClass);

  [self blockTest];
}

- (void)blockTest{
    
//    self.completionBlock1 = ^(){
//        NSLog(@"complete");NSLog(@"%@", self);
//    };
    
//    __weak __typeof(self) weakSelf = self;
//    
//    dispatch_block_t completionBlock2 = ^(){
//        [weakSelf hello];
//    };

//
//    self.completionBlock1 = ^(){
//        NSLog(@"complete");
//    };
//    
////    [UIView animateWithDuration:1 animations:^{
////        self.view.backgroundColor = [UIColor redColor];
////    } completion:completionBlock];
//    ViewController1 *myController = [[ViewController1 alloc] init];
//    [self presentViewController:myController
//                       animated:YES
//                     completion:completionBlock2];
    


    
//    [self sayHelloTo:@"liuyanwei" completion:^(NSString *name) {
//        NSLog(@"goodbey %@",name);
//    }];
    
    
//    self.completionBlock = ^(NSString *name){
//         NSLog(@"goodbey %@",name);
//         NSLog(@"%@", self);
//    };
    
//    __weak __typeof(self) weakSelf = self;
//    self.completionBlock = ^(NSString *name){
//        NSLog(@"goodbey %@",name);
//        NSLog(@"%@", weakSelf);
//    };
//    
//    [self sayHelloTo:@"liuyanwei" completion:self.completionBlock];
    
    __weak __typeof(self) weakSelf = self;
    self.completionBlock = ^(NSString *name){
        NSLog(@"goodbey %@",name);
        [weakSelf helloWithSelf:weakSelf];
        [weakSelf helloWithSelf:weakSelf];
    };

    [self sayHelloTo:@"liuyanwei" completion:self.completionBlock];
}

- (void)hello{
     NSLog(@"hello");
}
- (void)helloWithSelf:(ViewController *)s {

    __strong __typeof(s) strongSelf = s;
    
    if (strongSelf) {
        NSLog(@"hello,s:%@",strongSelf);
    }
    strongSelf = nil;

}

- (void)sayHelloTo:(NSString *)name completion:(void(^)(NSString *name))completion{
    NSLog(@"hello %@",name);
    completion(name);
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
