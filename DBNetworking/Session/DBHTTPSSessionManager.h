//
//  DBHTTPSSessionManager.h
//  DBNetworking
//
//  Created by Dabay on 2016/5/12.
//  Copyright © 2016年 Dabay-Tech All rights reserved.


#import <Foundation/Foundation.h>
#if !TARGET_OS_WATCH
#import <SystemConfiguration/SystemConfiguration.h>
#endif
#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_WATCH || TARGET_OS_TV
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif


#import "DBNetWorkingManager.h"



//NS_ASSUME_NONNULL_BEGIN


/**
 * @brief 定义枚举类型的网络请求类型：GET OR POST
 * DB_HTTPSMETHOD_GET: 网络请求方式为GET
 * DB_HTTPSMETHOD_POST: 网络请求方式为POST
 */
typedef NS_ENUM(NSInteger,DB_HTTPSMETHOD)
{
    DB_HTTPSMETHOD_GET   = 0,
    DB_HTTPSMETHOD_POST  = 1,
};



/**
 网络请求成功的回调

 @param responseDict 返回从服务器返回的数据的NSDictionary类型
 */
typedef void (^SuccessBlock)(NSDictionary * responseDict);
/** 网络请求失败的回调 */
typedef void (^FailedBlock)(NSError *error);


@interface DBHTTPSSessionManager : AFHTTPSessionManager




#pragma mark - 网络请求方法




/**
 DBNetworking HTTPS请求 默认带有HUD

 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_postWithURLString:(NSString *)URLString Parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;



/**
 DBNetworking HTTPS请求 默认为POST请求
 
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param isWithHUD 是否带有HUD提示
 @param view HUD显示在View上
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_postRequestWithURLString:(NSString*)URLString Parameters:(NSDictionary *)parameters isWithHUD:(BOOL)isWithHUD inView:(UIView *)view succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;



/**
 DBNetworking HTTPS请求 可以选择请求方式：GET,POST

 @param URLString 网络请求的URL地址字符串
 @param method 网络请求的方式：GET/POST
 @param parameters 网络请求的参数
 @param isWithHUD 是否带有HUD提示
 @param view HUD显示在View上
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_requestWithURLString:(NSString *)URLString httpsMethod:(DB_HTTPSMETHOD)method  parameters:(NSDictionary *)parameters isWithHUD:(BOOL)isWithHUD inView:(UIView *)view  succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;






#pragma mark - 字符串与JSON的转换

/**
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)db_dictionaryWithJsonString:(NSString *)jsonString;


/**
 * @brief 把字典转换成字符串
 * @param paramDict 字典
 * @param _type 类型
 * @return 返回字符串
 */
+(NSString*)db_URLEncryOrDecryString:(NSDictionary *)paramDict IsHead:(BOOL)_type;



@end

//NS_ASSUME_NONNULL_END
