//
//  BLEBridge.h
//  test
//
//  Created by xuanyan.lyw on 16/4/1.
//  Copyright © 2016年 xuanyan.lyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "Person.h"


@interface JSBridge : NSObject

@property (nonatomic,strong) JSContext *jsContext;


- (void)bridgeForJs;
- (void)regiestJSFunctionInContext:(JSContext *) jsContext;

@end


