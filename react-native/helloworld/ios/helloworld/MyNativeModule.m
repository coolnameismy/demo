//
//  MyNativeModule.m
//  helloworld
//
//  Created by ZTELiuyw on 16/1/21.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "MyNativeModule.h"


@implementation MyNativeModule

/**
 * Place this macro in your class implementation to automatically register
 * your module with the bridge when it loads. The optional js_name argument
 * will be used as the JS module name. If omitted, the JS module name will
 * match the Objective-C class name.
 */
#define RCT_EXPORT_MODULE(js_name) \
RCT_EXTERN void RCTRegisterModule(Class); \
+ (NSString *)moduleName { return @#js_name; } \
+ (void)load { RCTRegisterModule(self); }


RCT_EXPORT_MODULE()

-(NSDictionary *)Helloa{
  NSLog(@"Helloa");
  return @{@"name":@"liuyanwei"};

}

//
RCT_EXPORT_METHOD(Hello2:(RCTResponseSenderBlock)callback){
   callback(@[[NSNull null],[self Helloa]]);
}

//导出常量
-(NSDictionary<NSString *,id> *)constantsToExport{
   return @{@"a":@"aa",@"b":@"bb"};
}
@end
