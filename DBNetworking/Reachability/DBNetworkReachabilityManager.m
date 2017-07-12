//
//  DBNetworkReachabilityManager.m
//  DBNetworking
//
//  Created by Dabay on 2016/5/12.
//  Copyright © 2016年 Dabay-Tech All rights reserved.


#import "DBNetWorkingManager.h"

#import "AFNetworkReachabilityManager.h"





@implementation DBNetworkReachabilityManager


//
//#pragma makr - 开始监听程序在运行中的网络连接变化
//- (void)startMonitoring
//{
//    // 1.获得网络监控的管理者
//    DBNetworkReachabilityManager * db_NetworkReachabilityManager = [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager;
//    // 2.设置网络状态改变后的处理
//    [db_NetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        // 当网络状态改变了, 就会调用这个block
//        switch (status)
//        {
//            case AFNetworkReachabilityStatusUnknown:                // 未知网络
//                
//                [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager.db_networkStatus=DBNetworkStatusUnknown;
//                
//                break;
//                
//            case AFNetworkReachabilityStatusNotReachable:           // 没有网络(断网)
//                
//                [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager.db_networkStatus=DBNetworkStatusNotReachable;
//                
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWWAN:       // 手机自带网络
//                
//                [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager.db_networkStatus=DBNetworkStatusReachableViaWWAN;
//                
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWiFi:       // WIFI
//                
//                [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager.db_networkStatus=DBNetworkStatusReachableViaWiFi;
//                
//                break;
//        }
//    }];
//    
//    [db_NetworkReachabilityManager startMonitoring];
//}
//
//+ (DBNetworkStatus)checkNetStatus {
//    
//    [self startMonitoring];
//    
//    
//    DBNetworkReachabilityManager * db_NetworkReachabilityManager = [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager;
//    
//    
//    if (db_NetworkReachabilityManager.db_networkStatus == DBNetworkStatusReachableViaWiFi) {
//        
//        return DBNetworkStatusReachableViaWiFi;
//        
//    } else if (db_NetworkReachabilityManager.db_networkStatus == DBNetworkStatusNotReachable) {
//        
//        return DBNetworkStatusNotReachable;
//        
//    } else if (db_NetworkReachabilityManager.db_networkStatus == DBNetworkStatusReachableViaWWAN) {
//        
//        return DBNetworkStatusReachableViaWWAN;
//        
//    } else {
//        
//        return DBNetworkStatusUnknown;
//        
//    }
//    
//}


#pragma mark - 监控网络状态


/** 开始监控 */
-(void)db_startMonitoring{
    
    NSLog(@"");

    AFNetworkReachabilityManager *reachabilityManager =[AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    
    
    //设置网路状态改变的
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"WANGLUOZHAUNGTAI GAIBIAN");
        
        
        
        
        
        
        
        
    }];
    


}





/** 停止网络状态的监控 */
- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


@end
