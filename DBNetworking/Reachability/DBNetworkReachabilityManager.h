//
//  DBNetworkReachabilityManager.h
//  DBNetworking
//
//  Created by Dabay on 2016/5/12.
//  Copyright © 2016年 Dabay-Tech All rights reserved.


#import "DBNetWorkingManager.h"

/**
 *  手机网络状态
 */
typedef enum{
    
    DBNetworkStatusUnknown           = -1,      //未知网络
    DBNetworkStatusNotReachable      = 0,       //没有网络
    DBNetworkStatusReachableViaWWAN  = 1,       //手机自带网络
    DBNetworkStatusReachableViaWiFi  = 2        //wifi
    
}DBNetworkStatus;


@interface DBNetworkReachabilityManager : AFNetworkReachabilityManager

@property (nonatomic,assign)DBNetworkStatus db_networkStatus;



/** 开始监听网络状态 */
+(void)db_startMonitoring;




@end
