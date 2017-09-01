//
//  DBHTTPSSessionManager.m
//  DBNetworking
//
//  Created by Dabay on 2016/5/12.
//  Copyright © 2016年 Dabay-Tech All rights reserved.

#import "DBHTTPSSessionManager.h"

#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"

#import <Availability.h>
#import <TargetConditionals.h>
#import <Security/Security.h>

#import <DBProgressHUD/DBProgressHUD.h>//大白-HUD
#import "MJExtension.h"
#import "AESCipher.h"

#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#elif TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#endif


@implementation DBHTTPSSessionManager


/** 创建并初始化DBHTTPSessionManager类型的HTTPS请求对象 */
+(instancetype)db_httpsSessionManager{

    //1.创建DBHTTPSessionManager类型的对象
    NSString *baseURLString=[DBNetWorkingManager sharedManager].db_BaseURLString;
    NSURL *baseURL=[NSURL URLWithString:baseURLString];
    DBHTTPSSessionManager *db_HttpsSessionManager=[[DBHTTPSSessionManager alloc]initWithBaseURL:baseURL];
    
    //2.设置db_HttpsSessionManager的安全策略
    [self setupSecurityPolicyForDBHttpsSessionManager:db_HttpsSessionManager];
    
    //3.设置db_HttpsSessionManager的请求和返回
    [self setupRequestAndResponseSerializerForDBHttpsSessionManager:db_HttpsSessionManager];
    return db_HttpsSessionManager;
}



/** 设置db_HttpsSessionManager的安全策略 */
+(void)setupSecurityPolicyForDBHttpsSessionManager:(DBHTTPSSessionManager *)db_HttpsSessionManager{
    
    NSString * certificateString=[DBNetWorkingManager sharedManager].db_certificateString;
    
    //设置安全策略
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificateString ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    //db_HttpsSessionManager.securityPolicy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];//AFSSLPinningModeCertificate
    db_HttpsSessionManager.securityPolicy=[AFSecurityPolicy defaultPolicy];
    db_HttpsSessionManager.securityPolicy.allowInvalidCertificates=YES;//设置允许使用证书
    db_HttpsSessionManager.securityPolicy.validatesDomainName=NO;//是否需要验证域名
    
    //如果没有证书
    if(!cerData){
        //NSLog(@"DBNetWorking--HTTPS证书创建失败--没有找到相应的证书文件");
        return;
    }
    
    db_HttpsSessionManager.securityPolicy.pinnedCertificates=[NSSet setWithObject:cerData];
}

/** 设置db_HttpsSessionManager请求和返回的Serializer */
+(void)setupRequestAndResponseSerializerForDBHttpsSessionManager:(DBHTTPSSessionManager *)db_HttpsSessionManager{
    
    //初始化网络请求的设置
    db_HttpsSessionManager.requestSerializer.timeoutInterval = 30.0;//默认设置请求的超时时间为30s
    db_HttpsSessionManager.responseSerializer.stringEncoding=NSUTF8StringEncoding;
    
    //初始化网络请求返回的设置
    db_HttpsSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    db_HttpsSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpeg", nil];
}


#pragma mark - 网络请求方法


/**
 DBNetworking HTTPS请求 默认带有HUD
 
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_postWithURLString:(NSString *)URLString Parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{

    [self db_postRequestWithURLString:URLString Parameters:parameters isWithHUD:YES inView:nil succeed:successBlock failure:failedBlock];
}



/**
 DBNetworking HTTPS请求 默认为POST请求

 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param isWithHUD 是否带有HUD提示
 @param view HUD显示在View上
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_postRequestWithURLString:(NSString*)URLString Parameters:(NSDictionary *)parameters isWithHUD:(BOOL)isWithHUD inView:(UIView *)view succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{

    [self db_requestWithURLString:URLString httpsMethod:DB_HTTPSMETHOD_POST parameters:parameters isWithHUD:isWithHUD inView:view succeed:successBlock failure:failedBlock];
}


/**
 DBNetworking HTTPS请求 可以选择请求方式：GET,POST
 
 @param URLString 网络请求的URL地址字符串
 @param method 网络请求的方式：GET/POST
 @param parameters 网络请求的参数-参数进行整体加密
 @param isWithHUD 是否带有HUD提示
 @param view HUD显示在View上
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_requestWithURLString:(NSString *)URLString httpsMethod:(DB_HTTPSMETHOD)method  parameters:(NSDictionary *)parameters isWithHUD:(BOOL)isWithHUD inView:(UIView *)view  succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock{
    


    if(isWithHUD){
        [DBProgressHUD db_showLoading:@"   加载中..." toView:view];
    }
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //1.创建HTTPS的session管理者
        DBHTTPSSessionManager *manager=[DBHTTPSSessionManager db_httpsSessionManager];
        //2.证书的名称
        NSString * certificateString=[DBNetWorkingManager sharedManager].db_certificateString;
        //3.如果URLString里面是有效的URL地址
        if (URLString != nil){
            typeof (manager) weakManager = manager ;
            [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing *_credential) {
                
                //3.1获取服务器的 trust object
                SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
                
                //3.2导入自签名证书
                NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificateString ofType:@"cer"];
                NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
                
                if (!cerData) {
                    //NSLog(@"DBNetWorking--处理时证书文件未获取到，.cer文件为空");
                    return 0;
                }
                
                weakManager.securityPolicy.pinnedCertificates = [NSSet setWithArray:@[cerData]];
                SecCertificateRef caRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)cerData);
                NSCAssert(caRef != nil, @"caRef is nil");
                
                NSArray *caArray = @[(__bridge id)(caRef)];
                NSCAssert(caArray != nil, @"caArray is nil");
                
                //3.3将读取到的证书设置为serverTrust的根证书
                OSStatus status = SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)caArray);
                SecTrustSetAnchorCertificatesOnly(serverTrust, NO);
                NSCAssert(errSecSuccess == status, @"SectrustSetAnchorCertificates failed");
                NSLog(@"DBNetWorking--status=%d",(int)status);
                
                //3.4选择质询认证的处理方式
                NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                __autoreleasing NSURLCredential *credential = nil;
                
                //3.5NSURLAuthenTicationMethodServerTrust质询认证方式
                if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
                    //基于客户端的安全策略来决定是否信任该服务器，不信任则不响应质询
                    if ([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                        
                        //创建质询证书
                        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                        if (credential) {//确认质询方式
                            disposition = NSURLSessionAuthChallengeUseCredential;
                        } else {
                            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                        }
                    } else {//取消挑战
                        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                    }
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
                return disposition;
            }];
        }else{
            NSLog(@"DBNetWorking--URLString为nil，被DBNetWorking拦截，网络请求未发送");
            return;
        }
        
        if (method == DB_HTTPSMETHOD_GET){//发送GET请求
            
            [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //无论是成功还是失败-都结束加载中的提示
                [DBProgressHUD db_hideHUD];
                
                
                if (successBlock){
                    NSString *responseStr =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    successBlock([DBHTTPSSessionManager db_dictionaryWithJsonString:responseStr]);
                }else{
                    NSLog(@"DBNetWorking--发送GET请求时失败，链接异常或网络不存在");
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //无论是成功还是失败-都结束加载中的提示
                [DBProgressHUD db_hideHUD];

                
                failedBlock(error);
                NSLog(@"DBNetWorking--请求-GET-请求失败-error=%@",error);
                //[DBProgressHUD db_showError:@"服务暂不可用，请稍后重试"];
            }];
        }else if (method == DB_HTTPSMETHOD_POST){//发送POST请求
            
            //0.将参数进行整体加密
        
            //1.将参数字典转化为字符串
            NSString * paramsString = parameters.mj_JSONString;
            
            //2.将字符串用AES进行加密
            NSString *encryptString = aesEncryptString(paramsString, [DBNetWorkingManager sharedManager].db_aesEncryptKey);
            
            //3.重新创建字典,将加密后的内容作为字典中的内容加入字典中
            NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
            paramDict[@"param"] = encryptString;
            
            NSLog(@"加密后的参数：%@",paramDict);
            
            
            
            [manager POST:URLString parameters:paramDict.mj_JSONString progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //无论是成功还是失败-都结束加载中的提示
                [DBProgressHUD db_hideHUD];
                
                if (successBlock){
                    
                    NSString *responseStr =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSDictionary * reponseDict = [DBHTTPSSessionManager db_dictionaryWithJsonString:responseStr];
                    
                    NSLog(@"DBNetWorking--reponseDict=%@",reponseDict);
                    
                    //0.解密前的字符串
                    NSString * stringBeforeEncry = reponseDict[@"dataBack"];
                    NSLog(@"DBNetWorking--解密前的字符串=%@",stringBeforeEncry);
                    //1.解密后的字符串
                    NSString * stringAfterDecry = aesDecryptString(stringBeforeEncry, [DBNetWorkingManager sharedManager].db_aesEncryptKey);
                    NSLog(@"DBNetWorking--解密后的字符串=%@",stringAfterDecry);
                    
                    //2.解密后的字符串转换为字典
                    NSDictionary * resultDictionary = [DBHTTPSSessionManager db_dictionaryWithJsonString:stringAfterDecry];
                    NSLog(@"DBNetWorking--解密后的字符串转换为字典=%@",resultDictionary);
                    
                    //1.网络请求成功后错误信息的处理,是否做拦截处理
                    if([self db_processingErrorInfoWithDictionary:reponseDict]){
                        
                        //1.1拦截处理，不做成功的回调
                        //successBlock(nil);
                    
                    }else{
                    
                        //1.2不做任何拦截，直接在业务处理得地方进行处理
                        successBlock(resultDictionary);
                    }
                }else{
                    NSLog(@"DBNetWorking--发送POST请求时失败，链接异常或网络不存在");
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //无论是成功还是失败-都结束加载中的提示
                [DBProgressHUD db_hideHUD];
                
                failedBlock(error);
                NSLog(@"DBNetWorking--请求-POST-请求失败-error=%@",error);
                //[DBProgressHUD db_showError:@"服务暂不可用，请稍后重试"];
            }];
        }

    });
    
}

#pragma mark - 网络请求错误的处理

/**
 处理网络请求成功的的错误请求信息处理

 @param errorInfo 请求成功返回的信息
 @return 是否进行拦截
 */
+(BOOL)db_processingErrorInfoWithDictionary:(NSDictionary *)errorInfo{

    
    NSString * resultCode = errorInfo[@"resultCode"];
    if([resultCode integerValue] == 4002){

        
        //DBNetWorking--发送通知--token失效--进行拦截
        NSLog(@"DBNetWorking--检查到token失效--发送token失效通知...");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"token_invalid" object:nil userInfo:errorInfo];
        return YES;
    
    }else if ([resultCode integerValue] == 4003){
    
        //DBNetWorking--发送通知--token超时--进行拦截
        NSLog(@"DBNetWorking--检查到token超时--发送token超时通知...");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"token_overtime" object:nil userInfo:errorInfo];
        return YES;
    
    }else{
    
        //DBNetWorking--其他类型的异常不做拦截--不进行拦截
        return NO;
    }
}






#pragma mark - 字符串与JSON的转换

/**
 把格式化的JSON格式的字符串转换成字典
 
 @param jsonString JSON格式的字符串
 @return 返回字典
 */
+(NSDictionary *)db_dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        NSLog(@"DBNetWorking--JSON解析失败：%@",error);
        return nil;
    }
    return dic;
}


/**
 把字典转换成字符串
 
 @param paramDict 字典
 @param _type 类型
 @return 返回字典对应的字符串
 */
+(NSString*)db_URLEncryOrDecryString:(NSDictionary *)paramDict IsHead:(BOOL)_type
{
    
    NSArray *keyAry =  [paramDict allKeys];
    NSString *encryString = @"";
    for (NSString *key in keyAry)
    {
        NSString *keyValue = [paramDict valueForKey:key];
        encryString = [encryString stringByAppendingFormat:@"&"];
        encryString = [encryString stringByAppendingFormat:@"%@",key];
        encryString = [encryString stringByAppendingFormat:@"="];
        encryString = [encryString stringByAppendingFormat:@"%@",keyValue];
    }
    return encryString;
}




@end
