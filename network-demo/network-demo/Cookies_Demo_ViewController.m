//
//  Cookies_Demo_ViewController.m
//  network-demo
//
//  Created by 刘彦玮 on 16/2/12.
//  Copyright © 2016年 刘彦玮. All rights reserved.
//

#import "Cookies_Demo_ViewController.h"

@interface Cookies_Demo_ViewController ()

@end

@implementation Cookies_Demo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试网络请求" message:@"嘿嘿嘿" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"从服务端获取cookie" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cookie];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"打印客户端cookie" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clientCookie];
    }];
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"客户端设置cookie" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clientSetCookie];
    }];
    UIAlertAction *act4 = [UIAlertAction actionWithTitle:@"删除全部cookie" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deleteCookies];
    }];
    
    UIAlertAction *act00 = [UIAlertAction actionWithTitle:@"cannel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    
    [alert addAction:act1];[alert addAction:act2]; [alert addAction:act3];[alert addAction:act4];
    [alert addAction:act00];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark -同步请求

-(void)cookie{
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8001/cookie"]];
    NSURLResponse *resp; NSError *err;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    NSLog(@"====请求开始====");
    
    
    //检查错误
    if (err) {
        NSLog(@"%@",err);
        NSLog(@"==resq====%@",resp);
        return;
    }
    
    //检验状态码
    if ([resp isKindOfClass:[NSHTTPURLResponse class]]) {
        if (((NSHTTPURLResponse *)resp).statusCode != 200) {
            return;
        }
    }
    
    //解析json
    NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err ]);
    
    NSLog(@"====请求结束====");
    
    //获取cookie
    NSDictionary *headers = [((NSHTTPURLResponse *)resp) allHeaderFields];
    NSLog(@"headers:%@",headers);
    NSDictionary *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:headers forURL:[NSURL URLWithString:@"http://localhost/"]];

    for (NSHTTPCookie *cookie in cookies) {
        NSLog(@"cookie:%@",cookie);
        if ([[cookie name] isEqualToString:@"JSESSIONID"]) {
            NSLog(@"session id is %@",[cookie value]);
        }
    }
    
}

//获取本地cookie
-(void)clientCookie{
    
    //获取本地cookie
    NSHTTPCookieStorage *httpCookiesStorage =  [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSDictionary *cookies = [httpCookiesStorage cookiesForURL:[NSURL URLWithString:@"http://localhost/"]];
    for (NSHTTPCookie *cookie in cookies) {
        NSLog(@"cookie:%@",cookie);
    }
    
}

//客户端设置cookie
-(void)clientSetCookie{
    
    NSDictionary *prop1 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"a",NSHTTPCookieName,
                           @"aaa",NSHTTPCookieValue,
                           @"/",NSHTTPCookiePath,
                           [NSURL URLWithString:@"http://localhost/"],NSHTTPCookieOriginURL,
                           [NSDate dateWithTimeIntervalSinceNow:60],NSHTTPCookieExpires,
                           nil];
    NSDictionary *prop2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"b",NSHTTPCookieName,
                           @"bbb",NSHTTPCookieValue,
                           @"/",NSHTTPCookiePath,
                           [NSURL URLWithString:@"http://localhost/"],NSHTTPCookieOriginURL,
                           [NSDate dateWithTimeIntervalSinceNow:60],NSHTTPCookieExpires,
                           nil];
    
    NSHTTPCookie *cookie1 = [NSHTTPCookie cookieWithProperties:prop1];
    NSHTTPCookie *cookie2 = [NSHTTPCookie cookieWithProperties:prop2];

    //单个设置
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie1];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie2];
    
    //批量设置
//    NSArray *cookies = @[cookie1,cookie2,cookie3];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookies:cookies forURL:[NSURL URLWithString:@"http://localhost/"] mainDocumentURL:nil];
    
    //设置cookie本地缓存策略
    //NSHTTPCookieAcceptPolicyAlways:保存所有cookie，这个是默认值
    //NSHTTPCookieAcceptPolicyNever:不保存任何响应头中的cookie
    //NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain:只保存域请求匹配的cookie

    [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];

    NSLog(@"设置完成");
}


#pragma mark -客户端删除cookie
//根据url和name删除cookie
-(void)deleteCookie:(NSString *)cookieName url:(NSURL *)url{
    //根据url找到所属的cookie集合
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:url];
    for (NSHTTPCookie *cookie in cookies) {
        if([cookie.name isEqualToString:cookieName]){
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            NSLog(@"删除cookie:%@",cookieName);
        }
    }
}
//删除全部cookies
-(void)deleteCookies{
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    NSLog(@"删除完成");
}

//服务端session


@end
