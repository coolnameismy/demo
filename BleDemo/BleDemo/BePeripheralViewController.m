//
//  BePeripheralViewController.m
//  BleDemo
//
//  Created by ZTELiuyw on 15/9/7.
//  Copyright (c) 2015年 liuyanwei. All rights reserved.
//

#import "BePeripheralViewController.h"



static NSString *const ServiceUUID1 =  @"FFF0";
static NSString *const notiyCharacteristicUUID =  @"FFF1";
static NSString *const readwriteCharacteristicUUID =  @"FFF2";
static NSString *const ServiceUUID2 =  @"FFE0";
static NSString *const readCharacteristicUUID =  @"FFE1";
static NSString * const LocalNameKey =  @"myPeripheral";

@implementation BePeripheralViewController{
    //    BabyBluetooth *baby;
    CBPeripheralManager *peripheralManager;
    //定时器
    NSTimer *timer;
    //添加成功的service数量
    int serviceNum;

   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    [peripheralManager stopAdvertising];
}





//配置bluetooch的
-(void)setUp{
    //初始值
    int characteristicInitValue = 1;
    NSData *initData = [NSData dataWithBytes:&characteristicInitValue length:1];
    
    CBUUID *CBUUIDCharacteristicUserDescriptionStringUUID = [CBUUID UUIDWithString:CBUUIDCharacteristicUserDescriptionString];
    CBUUID *CBUUIDCharacteristicFormatStringUUID = [CBUUID UUIDWithString:CBUUIDCharacteristicFormatString];
    
    //通知的Characteristic
    CBMutableCharacteristic *notiyCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:notiyCharacteristicUUID] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    //读写的characteristics
    CBMutableCharacteristic *readwriteCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readwriteCharacteristicUUID] properties:CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable];
    CBMutableDescriptor *readwriteCharacteristicDescription1 = [[CBMutableDescriptor alloc]initWithType: CBUUIDCharacteristicUserDescriptionStringUUID value:@"name"];
    //description
    [readwriteCharacteristic setDescriptors:@[readwriteCharacteristicDescription1]];
    
    //service1
    CBMutableService *service1 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID1] primary:YES];
    
    //service2
    CBMutableService *service2 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID2] primary:YES];
    
    //通知的Characteristic
    CBMutableCharacteristic *readCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readCharacteristicUUID] properties:CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable];
    
    
    [service1 setCharacteristics:@[notiyCharacteristic,readwriteCharacteristic]];
    [service2 setCharacteristics:@[readCharacteristic]];
    //添加后就会调用代理的- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
    [peripheralManager addService:service1];
    [peripheralManager addService:service2];
}


//发送数据，发送当前时间的秒数
-(BOOL)sendData:(NSTimer *)t {
    
    CBMutableCharacteristic *characteristic = t.userInfo;
    NSDateFormatter *dft = [[NSDateFormatter alloc]init];
    [dft setDateFormat:@"ss"];
    NSLog(@"%@",[dft stringFromDate:[NSDate date]]);
    return  [peripheralManager updateValue:[[dft stringFromDate:[NSDate date]] dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:(CBMutableCharacteristic *)characteristic onSubscribedCentrals:nil];
    
}


#pragma  mark -- CBPeripheralManagerDelegate

//peripheral状态改变
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    switch (peripheral.state) {
            //在这里判断蓝牙设别的状态  当开启了则可调用  setUp方法(自定义)
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"powered on");
            [self setUp];
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"powered off");
            break;
            
        default:
            break;
    }
}

//perihpheral添加了service
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    if (error == nil) {
        serviceNum++;
    }
    if (serviceNum==2) {
        //添加服务后可以在此向外界发出通告 调用完这个方法后会调用代理的
        //(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
        [peripheralManager startAdvertising:@{
                                              CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:ServiceUUID1],[CBUUID UUIDWithString:ServiceUUID2]],
                                              CBAdvertisementDataLocalNameKey : LocalNameKey
                                              }
         ];
        
    }
    
}

//peripheral开始发送advertising
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    NSLog(@"in peripheralManagerDidStartAdvertisiong");
}

//定于characteristics
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    NSLog(@"订阅了 %@的数据",characteristic.UUID);
    //每秒执行一次给主设备发送一个当前时间的秒数
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendData:) userInfo:characteristic  repeats:YES];
    
}

//取消订阅characteristics
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic{
    NSLog(@"取消订阅 %@的数据",characteristic.UUID);
    [timer setFireDate:[NSDate distantPast]];
}

//读取characteristics请求
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    NSLog(@"didReceiveReadRequest");
    
    NSData *data = request.characteristic.value;
    [request setValue:data];
    // 对请求作出成功响应
    [peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
}



- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    NSLog(@"didReceiveWriteRequests");
    CBATTRequest *request = requests[0];
    
    if (request.characteristic.properties & CBCharacteristicPropertyWrite) {
        CBCharacteristic *c =request.characteristic;
        c.value = request.value;
//        request.characteristic.value = request.value
        [peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    }else{
        [peripheralManager respondToRequest:request withResult:CBATTErrorWriteNotPermitted];
    }
    
    
}


- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral{
    NSLog(@"peripheralManagerIsReadyToUpdateSubscribers");
    
}


@end