//
//  DBNetWorkingManager.m
//  DBNetworking
//
//  Created by Dabay on 2016/5/12.
//  Copyright © 2016年 Dabay-Tech All rights reserved.


#import "DBNetWorkingManager.h"



@implementation DBNetWorkingManager




#pragma mark - 获取DBNetworking的单例对象

/** DBNetworking总的管理者 */
+ (DBNetWorkingManager *)sharedManager {
    
    static dispatch_once_t  onceToken;
    static DBNetWorkingManager * setSharedInstance;
    dispatch_once(&onceToken, ^{//线程锁
        setSharedInstance = [[DBNetWorkingManager alloc] init];
        setSharedInstance.db_NetworkReachabilityManager=[AFNetworkReachabilityManager sharedManager];
        [setSharedInstance setup];
    });
    return setSharedInstance;
}

#pragma mark -DBNetworkingManager类的单例对象的初始化



/**
 DBNetworkingManager类的单例对象的初始化
 */
-(void)setup{

    
    [self.db_NetworkReachabilityManager startMonitoring];
    //Version1.0.8开始使用类方法开启网络状态的监控
    [DBNetworkReachabilityManager db_startMonitoring];

}



-(void)dealloc{

    [self.db_NetworkReachabilityManager stopMonitoring];
    self.db_BaseURLString=nil;
    self.db_certificateString=nil;
    self.db_NetworkReachabilityManager=nil;
    NSLog(@"DBNetworking--DBNetWorkingManager--单例被销毁");
}





@end
