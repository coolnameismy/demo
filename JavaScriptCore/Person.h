//
//  Person.h
//  test
//
//  Created by xuanyan.lyw on 16/4/1.
//  Copyright © 2016年 xuanyan.lyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol JSPersonProtocol <JSExport>

@property (nonatomic, copy)NSString *name;
- (NSString *)whatYouName;

@end


@interface Person : NSObject<JSPersonProtocol>

@property (nonatomic, copy)NSString *name;
- (NSString *)whatYouName;

@end


