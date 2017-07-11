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
 
 @param view HUD显示在View上
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_withHUDInView:(UIView *)view URLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{


    [DBHTTPSSessionManager db_postRequestWithURLString:URLString Parameters:parameters isWithHUD:YES inView:view succeed:successBlock failure:failedBlock];

}



@end
