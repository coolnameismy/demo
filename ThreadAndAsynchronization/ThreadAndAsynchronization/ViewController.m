//
//  ViewController.m
//  ThreadAndAsynchronization
//
//  Created by 刘彦玮 on 15/8/19.
//  Copyright (c) 2015年 刘彦玮. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController{
    BOOL isOver;
}


//ios多线程，同步异步的使用
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //使用performSelector的多线程和异步
    //[self performSelectorFunction];
    
    //使用NSThread的多线程
    //[self NSThreadFunction];
    
    //使用NSTimer的反面教材
    //[self NSTimerFunction];
    
    //使用GCD的多线程
//    [self GCDFunction];
    
    //NSOperation用法
    [self NSOperationFunction];
    
}

-(void)NSOperationFunction{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //设置队列最大同时进行的任务数量，1为串行队列
    [queue setMaxConcurrentOperationCount:1];
    //添加一个block任务
    [queue addOperationWithBlock:^{
       sleep(2);
        NSLog(@"block task 1");
    }];
    [queue addOperationWithBlock:^{
        sleep(2);
        NSLog(@"block task 2");
    }];
    //显示添加一个block任务
    NSBlockOperation *block1 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(2);
        NSLog(@"block task 3");
    }];
    //设置任务优先级
    //说明：优先级高的任务，调用的几率会更大,但不表示一定先调用
    [block1 setQueuePriority:NSOperationQueuePriorityHigh];
    [queue addOperation:block1];
    
    NSBlockOperation *block2 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(2);
        NSLog(@"block task 4，任务3依赖4");
    }];
    [queue addOperation:block2];
    //任务3依赖4
    [block1 addDependency:block2];
    //设置任务完成的回调
    [block2 setCompletionBlock:^{
         NSLog(@"block task 4 comlpete");
    }];

    //设置block1完成后才会继续往下走
    [block1 waitUntilFinished];
     NSLog(@"block task 3 is waitUntilFinished!");
    
    //初始化一个子任务
    NSInvocationOperation *oper1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(function1) object:nil];
    [queue addOperation:oper1];
    
    [queue waitUntilAllOperationsAreFinished];
    NSLog(@"queue comlpeted");
    
    //    取消全部操作
    //    [queue cancelAllOperations];
    //    暂停操作/恢复操作/是否暂定状态
    //    [queue setSuspended:YES];[queue setSuspended:NO];[queue isSuspended];

    
    //操作优先级
    
    
    
    //      [queue waitUntilAllOperationsAreFinished];
}

/*
 *使用GCD 的多线程
 *优点：有很多串行并线队列多线程，block实现线程方法，高级，好用，方法多。
 *缺点：在很多不需要高级控制线程的场景可以不用使用GCD
 */
-(void)GCDFunction{
    
    NSLog(@"GCDFunction start");
    
    //获取一个队列
    dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //dispatch_async：异步方式执行方法（最常用）
    //    dispatch_async(defaultQueue, ^{
    //        [self function1];
    //    });
    
    //dispatch_sync：同步方式使用场景，比较少用，一般与异步方式进行调用
    //    dispatch_async(defaultQueue, ^{
    //       NSMutableArray *array = [self GCD_sync_Function];
    //       dispatch_async(dispatch_get_main_queue(), ^{
    //           //利用获取的arry在主线程中更新UI
    //
    //       });
    //    });
    
    //dispatch_once：一次性执行，常常用户单例模式.这种单例模式更安全
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        // code to be executed once
    //        NSLog(@"dispatch_once");
    //    });
    
    //dispatch_after 延迟异步执行
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    //    dispatch_after(popTime, defaultQueue, ^{
    //        NSLog(@"dispatch_after");
    //    });
    
    
    //dispatch_group_async 组线程可以实现线程之间的串联和并联操作
    //    dispatch_group_t group = dispatch_group_create();
    //    NSDate *now = [NSDate date];
    //    //做第一件事 2秒
    //    dispatch_group_async(group, defaultQueue, ^{
    //        [NSThread sleepForTimeInterval:2];
    //         NSLog(@"work 1 done");
    //    });
    //    //做第二件事 5秒
    //    dispatch_group_async(group, defaultQueue, ^{
    //        [NSThread sleepForTimeInterval:5];
    //        NSLog(@"work 2 done");
    //    });
    //
    //    //两件事都完成后会进入方法进行通知
    //    dispatch_group_notify(group, defaultQueue, ^{
    //        NSLog(@"dispatch_group_notify");
    //        NSLog(@"%f",[[NSDate date]timeIntervalSinceDate:now]);//总共用时5秒，因为2个线程同时进行
    //    });
    
    
    //dispatch_barrier_async :作用是在并行队列中，等待前面的队列执行完成后在继续往下执行
    //    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_async(concurrentQueue, ^{
    //        [NSThread sleepForTimeInterval:2];
    //        NSLog(@"work 1 done");
    //    });
    //    dispatch_async(concurrentQueue, ^{
    //        [NSThread sleepForTimeInterval:2];
    //        NSLog(@"work 2 done");
    //    });
    //    //等待前面的线程完成后执行
    //    dispatch_barrier_async(concurrentQueue, ^{
    //         NSLog(@"dispatch_barrier_async");
    //    });
    //
    //    dispatch_async(concurrentQueue, ^{
    //        [NSThread sleepForTimeInterval:3];
    //        NSLog(@"work 3 done");
    //    });
    
    
    
    //dispatch_semaphore 信号量的使用，串行异步操作
    //    dispatch_semaphore_create　　　创建一个semaphore
    //　　 dispatch_semaphore_signal　　　发送一个信号
    //　　 dispatch_semaphore_wait　　　　等待信号
    
    
    /*应用场景1：马路有2股道，3辆车通过 ，每辆车通过需要2秒
     *条件分解:
        马路有2股道 <=>  dispatch_semaphore_create(2) //创建两个信号
        三楼车通过 <=> dispatch_async(defaultQueue, ^{ } 执行三次
        车通过需要2秒 <=>  [NSThread sleepForTimeInterval:2];//线程暂停两秒
     */
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
        dispatch_async(defaultQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [NSThread sleepForTimeInterval:2];
            NSLog(@"carA pass the road");
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_async(defaultQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [NSThread sleepForTimeInterval:2];
            NSLog(@"carB pass the road");
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_async(defaultQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [NSThread sleepForTimeInterval:2];
            NSLog(@"carC pass the road");
            dispatch_semaphore_signal(semaphore);
        });
    

    
    //应用场景2 ：原子性保护，保证同时只有一个线程进入操作
    //    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    //    for(int i=0 ;i< 10000 ;i++){
    //        dispatch_async(defaultQueue, ^{
    //            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //            NSLog(@"i:%d",i);
    //            dispatch_semaphore_signal(semaphore);
    //        });
    //    }
    
    
    NSLog(@"GCDFunction end");
}


/*
 *使用GCD 同步线程的使用
 *模拟执行一个方法10秒后再返回结果.这种业务场景还是很有用处的，在一些耗时的方法中，我们也许只需要获取固定时间内计算的结果，可以使用这种方法
 *调用这种方法的对象会产生阻塞，所以可以使用异步方式调用。
 */
-(NSMutableArray *)GCD_sync_Function{
    
    dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __block NSMutableArray *array = [[NSMutableArray alloc]init];
    dispatch_sync(defaultQueue, ^{
        
        //每秒执行一次方法，给array增加一个数,等待执行完成后继续
        dispatch_async(defaultQueue, ^{
            for (int i=0; i<20; i++) {
                //每次执行需要1秒
                [array addObject:[NSString stringWithFormat:@"%d",i]];
                [NSThread sleepForTimeInterval:1];
            }
        });
        //执行10秒
        [NSThread sleepForTimeInterval:10];
        //打印10秒后执行的结果
        NSLog(@"%@",array);
    });
    return array;
    
}

/*
 *使反面教材，他不是多线程，但可以执行异步操作。最常用的就是定时执行一个任务，重复或非重复。
 */

-(void)NSTimerFunction{
    
    NSLog(@"NSTimerFunction start");
    
    //定时执行任务，可以重复和不重复
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(function1) userInfo:nil repeats:NO];
    
    //暂时停止定时器
    //[timer setFireDate:[NSDate distantFuture]];
    //重新开启定时器
    //[timer setFireDate:[NSDate distantPast]];
    //永久通知定时器
    //[timer invalidate];
    //timer = nil;
    
    NSLog(@"NSTimerFunction end");
    
}


/*
 *使用NSThread 的多线程
 *优点：简单
 *缺点：没有串行并线队列，不能实现高级线程调度,和performSelector是一样的。
 */

-(void)NSThreadFunction{
    
    NSLog(@"NSThreadFunction start");
    
    //同步 阻塞
    //线程暂停 2秒
    //[NSThread sleepForTimeInterval:2];
    
    //异步 非阻塞
    //显示创建的方式执行
    //NSThread *myThread = [[NSThread alloc]initWithTarget:self selector:@selector(function1) object:nil];
    //[myThread start];
    
    //异步 非阻塞
    //静态方法执行线程
    //[NSThread detachNewThreadSelector:@selector(function1) toTarget:self withObject:nil];
    
    NSLog(@"NSThreadFunction end");
    
}

/*
 *使用performSelector 的多线程
 *优点：简单
 *缺点：没有串行并线队列，不能实现高级线程调度
 */

-(void)performSelectorFunction{
    
    NSLog(@"performSelectorFunction start");
    
    //同步
    //方式执行，直接执行function1
    //[self performSelector:@selector(function1)];
    
    //异步，线程阻塞
    //延迟两秒执行function1,在function1执行期间，主线程是阻塞的，表现就是界面无响应。
    //[self performSelector:@selector(function1) withObject:nil afterDelay:2];
    
    //线程阻塞 最后一个参决定是同步还是异步
    // 主线程上执行，主线程阻塞，waitUntilDone:YES：等待执行完成顺序执行，waitUntilDone:NO 先执行后面语句
    //[self performSelectorOnMainThread:@selector(function1) withObject:nil waitUntilDone:NO];
    
    //异步，非阻塞
    //子线程上执行
    [self performSelectorInBackground:@selector(function1) withObject:nil];
    
    NSLog(@"performSelectorFunction end");
    
}

//耗时2秒的方法
-(void)function1{
    [NSThread sleepForTimeInterval:2];
    NSLog(@"function1 done");
}




@end
