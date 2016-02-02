//
//  HttpsByNSURLConnection_ViewController.m
//  network-demo
//
//  Created by ZTELiuyw on 16/2/2.
//  Copyright © 2016年 刘彦玮. All rights reserved.
//

#import "HttpsByNSURLConnection_ViewController.h"

@interface HttpsByNSURLConnection_ViewController ()

@end

@implementation HttpsByNSURLConnection_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试网络请求" message:@"嘿嘿嘿" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"loginCCT" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loginCCT];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"requestToGetNoticeListWithUserId" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestToGetNoticeListWithUserId];
    }];
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"githubUserInfo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self githubUserInfo];
    }];
    UIAlertAction *act4 = [UIAlertAction actionWithTitle:@"requestToGetNoticeListWithUserId1" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self requestToGetNoticeListWithUserId1];
    }];
    UIAlertAction *act5 = [UIAlertAction actionWithTitle:@"githubUserInfo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self githubUserInfo];
    }];
    UIAlertAction *act6 = [UIAlertAction actionWithTitle:@"githubUserInfo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self githubUserInfo];
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

#pragma mark -网络请求

- (void)loginCCT
{
    NSString *urlString = @"https://10.45.6.135:8443/ccm_web/staff/login";
    NSString *boby = @"userCode=malin&password=11111&channel=1";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[boby dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [conn start];
}
- (void)requestToGetNoticeListWithUserId
{
    
    NSString *urlString = @"https://10.45.6.135:8443/ccm_web/bulletin/qryBulletinRead";
    NSString *boby = [NSString stringWithFormat:@"userId=%@&pageIndex=%d&pageSize=%d&channel=1",@"7",1,10];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[boby dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [conn start];
}
- (void)requestToGetNoticeListWithUserId1
{
    
    NSString *urlString = @"https://10.45.6.135:8443/ccm_web/bulletin/qryBulletinRead";
    NSString *boby = [NSString stringWithFormat:@"userId=%@&pageIndex=%d&pageSize=%d&channel=1",@"7",1,10];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[boby dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //            NSString *aa = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //            NSLog(@"----%@",aa);
            NSLog(@"----%@",dict);
            if (dict) {
                int result=[[dict objectForKey:@"result"] intValue];
                NSString *resultMsg=[dict objectForKey:@"resultMsg"];
                if (result==0) {
                    //                    complete(dict);
                }else{
                    //                    complete(nil);
                    NSLog(resultMsg);
                }
                
            }
        }else{
            NSLog(@"网络繁忙，请稍后重试！");
        }
    }];
    
}
- (void)githubUserInfo
{
    //string 转 url编码
    NSString *urlString = @"https://api.github.com/users/coolnameismy";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
}

#pragma mark -网络请求委托

//请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"=================didFailWithError=================");
    NSLog(@"error:%@",error);
}

//重定向
- (nullable NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(nullable NSURLResponse *)response{
    NSLog(@"=================request redirectResponse=================");
    NSLog(@"request:%@",request);
    return request;
}

//接收响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"=================didReceiveResponse=================");
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    NSLog(@"response:%@",resp);
}

//接收响应
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"=================didReceiveData=================");
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"data:%@",dic);
}

//- (nullable NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request{
//
//}

//上传数据委托，用于显示上传进度
- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    NSLog(@"=================totalBytesWritten=================");
}

//- (nullable NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
//
//}

//完成请求
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"=================connectionDidFinishLoading=================");
}


#pragma mark -https认证
-(BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    NSLog(@"=================connectionShouldUseCredentialStorage=================");
    return true;
}
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"=================willSendRequestForAuthenticationChallenge=================");
    NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    //    //1)获取trust object
    //    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    //    SecTrustResultType result;
    //
    //    //2)SecTrustEvaluate对trust进行验证
    //    OSStatus status = SecTrustEvaluate(trust, &result);
    //    if (status == errSecSuccess &&
    //        (result == kSecTrustResultProceed ||
    //         result == kSecTrustResultUnspecified)) {
    //
    //            //3)验证成功，生成NSURLCredential凭证cred，告知challenge的sender使用这个凭证来继续连接
    //            NSURLCredential *cred = [NSURLCredential credentialForTrust:trust];
    //            [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
    //
    //        } else {
    //
    //            //5)验证失败，取消这次验证流程
    //            [challenge.sender cancelAuthenticationChallenge:challenge];
    //
    //        }
    
    // 1.从服务器返回的受保护空间中拿到证书的类型
    // 2.判断服务器返回的证书是否是服务器信任的
    
    //    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethod]){
    //        NSLog(@"是NSURLAuthenticationMethodClientCertificate:%@",challenge.protectionSpace.authenticationMethod);
    //    }
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        NSLog(@"是服务器信任的证书:%@",challenge.protectionSpace.authenticationMethod);
        //通过认证
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
    }
}

//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
//        NSLog(@"=================canAuthenticateAgainstProtectionSpace=================");
//       return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
