//
//  Download_and_upload_ViewController.m
//  network-demo
//
//  Created by 刘彦玮 on 16/2/11.
//  Copyright © 2016年 刘彦玮. All rights reserved.
//

#import "Download_and_upload_ViewController.h"

@interface Download_and_upload_ViewController ()

@end

@implementation Download_and_upload_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试网络请求" message:@"嘿嘿嘿" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"download" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self download];
    }];
    
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"upload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self upload];
    }];
    
    UIAlertAction *act00 = [UIAlertAction actionWithTitle:@"cannel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    [alert addAction:act1];
    [alert addAction:act2];
    [alert addAction:act00];
    
    
    //    [alert addAction:act4];
    //    [alert addAction:act5];
    //    [alert addAction:act6];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

#pragma mark -网络请求

//http下载文件流
- (void)download{
    //string 转 url编码
    NSString *urlString = @"http://localhost:8001/download";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
}

//http上传文件流
- (void)upload{
    
    #define Encode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

    NSURL *dataurl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_0222" ofType:@"jpg"]];
    NSData *data = [NSData dataWithContentsOfURL:dataurl];

    //string 转 url编码
    NSString *urlString = @"http://localhost:8001/upload";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    
    /** 设置请求头 */
    NSMutableData *body = [NSMutableData data];
    
    //文件参数
    // 参数开始的标志
    [body appendData:Encode(@"--YY\r\n")];
    // name : 指定参数名(必须跟服务器端保持一致)
    // filename : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"file", @"1.jpg"];
    [body appendData:Encode(disposition)];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", @"multipart/form-data"];
    [body appendData:Encode(type)];
    [body appendData:Encode(@"\r\n")];
 
    //添加图片数据
    [body appendData:data];
    [body appendData:Encode(@"\r\n")];
    //结束符
    [body appendData:Encode(@"--YY--\r\n")];
    //把body添加到request中
    [request setHTTPBody:body];
    
    /** 设置请求头 */
    // 请求体的长度
    [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
    // 声明这个POST请求是个文件上传
    [request setValue:@"multipart/form-data; boundary=YY" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];

    
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
    //    UIImage *img = [UIImage imageWithData:data];
    //    UIImageView *imageView = [[UIImageView alloc]initWithImage:img];
    //    [imageView setFrame:CGRectMake(30, 30, 200, 200)];
    //    [self.view addSubview:imageView];
    
    NSLog(@"data.length:%lu",(unsigned long)data.length);
    if (data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"data:%@",dic);
    }
}

//- (nullable NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request{
//
//}

//上传数据委托，用于显示上传进度
- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    NSLog(@"=================totalBytesWritten=================");
    NSLog(@"didSendBodyData:%ld,totalBytesWritten:%ld,totalBytesExpectedToWrite:%ld",(long)bytesWritten,(long)totalBytesWritten,(long)totalBytesExpectedToWrite);
    NSLog(@"上传进度%ld%%",(long)(totalBytesWritten*100 / totalBytesExpectedToWrite));
}

//- (nullable NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
//
//}

//完成请求
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"=================connectionDidFinishLoading=================");
}

 @end
