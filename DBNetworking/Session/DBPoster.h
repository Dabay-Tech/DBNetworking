//
//  DBPoster.h
//  DBNetworkingDemo
//
//  Created by Dabay on 2017/6/27.
//  Copyright © 2017年 Dabay. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 @brief 网络请求成功的回调
 @param responseDictionary 返回从服务器返回的数据的NSDictionary类型
 */
typedef void (^SuccessBlock)(NSDictionary * responseDictionary);

/** 
 @brief 网络请求失败的回调 
 */
typedef void (^FailedBlock)(NSError *error);


@interface DBPoster : NSObject



/**
 DBNetworking--发送POST请求--默认带有HUD提示
 
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_postURLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;




@end
