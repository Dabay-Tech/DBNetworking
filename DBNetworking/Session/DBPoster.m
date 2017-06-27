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
+(void)db_postURLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{

    [DBHTTPSSessionManager db_postRequestWithURLString:URLString Parameters:parameters isWithHUD:YES succeed:successBlock failure:failedBlock];
}


@end
