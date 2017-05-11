//
//  DBNetWorkingManager.h
//  DBNetworking
//
//  Created by Dabay on 2016/5/12.
//  Copyright © 2016年 Dabay-Tech All rights reserved.


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "DBNetworking.h"
#import "DBNetworkReachabilityManager.h"




NS_ASSUME_NONNULL_BEGIN


///---------------------------------------------------
/// @name Some Preferences Infomation
///---------------------------------------------------






///----------------------------------------------------
/// @name Method declarations of DBNetWorkingManager
///----------------------------------------------------

/** DBNetWorkingManager是继承自DBHTTPSessionManager的子类，是在DBHTTPSessionManager基础上进行的封装。 */
@interface DBNetWorkingManager : NSObject

#pragma mark - DBNetworkingManager的属性

/** 证书名的字符串 */
@property (nonatomic, strong, nullable) NSString * db_certificateString;
/** 整个项目的网络请求的URL的基地址 */
@property (nonatomic, strong, nullable) NSString * db_BaseURLString;
/** 网络是否可用的管理者 */
@property (nonatomic, strong, nullable) AFNetworkReachabilityManager * db_NetworkReachabilityManager;






#pragma mark - 获取DBNetworking的单例对象
/**
 * @brief DBNetworkingManager的类方法，创建并获取DBNetworkingManager的单例对象
 * @return 返回类型为DBNetWorkingManager的单例对象
 */
+ (instancetype)sharedManager;




@end


NS_ASSUME_NONNULL_END
