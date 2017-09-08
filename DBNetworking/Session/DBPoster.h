//
//  DBPoster.h
//  DBNetworkingDemo
//
//  Created by Dabay on 2017/6/27.
//  Copyright © 2017年 Dabay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 @brief 网络请求成功的回调
 @param responseDict 返回从服务器返回的数据的NSDictionary类型
 */
typedef void (^SuccessBlock)(NSDictionary * responseDict);

/** 
 @brief 网络请求失败的回调 
 */
typedef void (^FailedBlock)(NSError *error);


@interface DBPoster : NSObject



/**
 DBNetworking--发送POST请求--带有默认的HUD提示
 
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_URLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;



/**
 DBNetworking--发送POST请求--没有默认的HUD提示

 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_withoutHUDWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;




/**
 DBNetworking--发送POST请求--指定HUD显示在View上
 默认对参数整体进行AES加密

 @param view HUD显示在View上
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_withHUDInView:(UIView *)view URLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;



/**
 DBNetworking--发送POST请求--指定HUD显示在View上
 没有对参数进行加密的POST请求
 
 @param view HUD显示在View上
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_noAESWithHUDInView:(UIView *)view URLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;


/**
 DBNetworking--发送POST请求--默认带有HUD提示
 没有对参数进行加密的POST请求
 
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_noAESWithoutHUDWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;



@end
