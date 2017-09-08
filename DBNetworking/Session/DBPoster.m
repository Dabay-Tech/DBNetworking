//
//  DBPoster.m
//  DBNetworkingDemo
//
//  Created by Dabay on 2017/6/27.
//  Copyright © 2017年 Dabay. All rights reserved.
//

#import "DBPoster.h"
#import "DBHTTPSSessionManager.h"


@implementation DBPoster


/**
 DBNetworking--发送POST请求--默认带有HUD提示
 
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_URLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{

    
    [DBHTTPSSessionManager db_postRequestWithURLString:URLString Parameters:parameters isWithHUD:YES inView:nil succeed:successBlock failure:failedBlock];
}




/**
 DBNetworking--发送POST请求--不带HUD提示
 
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_withoutHUDWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{

    [DBHTTPSSessionManager db_postRequestWithURLString:URLString Parameters:parameters isWithHUD:NO inView:nil succeed:successBlock failure:failedBlock];
}



/**
 DBNetworking--发送POST请求--指定HUD显示在View上
 默认对参数整体进行AES加密
 
 @param view HUD显示在View上
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_withHUDInView:(UIView *)view URLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{


    [DBHTTPSSessionManager db_postRequestWithURLString:URLString Parameters:parameters isWithHUD:YES inView:view succeed:successBlock failure:failedBlock];
}


/**
 DBNetworking--发送POST请求--指定HUD显示在View上
 没有对参数进行加密的POST请求

 @param view HUD显示在View上
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_noAESWithHUDInView:(UIView *)view URLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{

    //[DBHTTPSSessionManager db_postRequestWithURLString:URLString Parameters:parameters isWithHUD:YES inView:view succeed:successBlock failure:failedBlock];
    [DBHTTPSSessionManager db_aesRequest:NO WithURLString:URLString httpsMethod:DB_HTTPSMETHOD_POST parameters:parameters isWithHUD:YES inView:view succeed:successBlock failure:failedBlock];
}


/**
 DBNetworking--发送POST请求--默认带有HUD提示
 没有对参数进行加密的POST请求

 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_noAESWithoutHUDWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{

    [DBHTTPSSessionManager db_aesRequest:NO WithURLString:URLString httpsMethod:DB_HTTPSMETHOD_POST parameters:parameters isWithHUD:NO inView:nil succeed:successBlock failure:failedBlock];
}


@end
