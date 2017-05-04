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
    });
    return setSharedInstance;
}

#pragma mark -DBNetworkingManager类的单例对象的初始化









@end
