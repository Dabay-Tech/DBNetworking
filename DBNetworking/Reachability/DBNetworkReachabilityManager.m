//
//  DBNetworkReachabilityManager.m
//  DBNetworking
//
//  Created by Dabay on 2016/5/12.
//  Copyright © 2016年 Dabay-Tech All rights reserved.


#import "DBNetWorkingManager.h"

#import "AFNetworkReachabilityManager.h"


@interface DBNetworkReachabilityManager()



@end




@implementation DBNetworkReachabilityManager





//
//#pragma makr - 开始监听程序在运行中的网络连接变化
//- (void)startMonitoring
//{
//    // 1.获得网络监控的管理者
//    DBNetworkReachabilityManager * db_NetworkReachabilityManager = [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager;
//    // 2.设置网络状态改变后的处理
//    [db_NetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        // 当网络状态改变了, 就会调用这个block
//        switch (status)
//        {
//            case AFNetworkReachabilityStatusUnknown:                // 未知网络
//                
//                [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager.db_networkStatus=DBNetworkStatusUnknown;
//                
//                break;
//                
//            case AFNetworkReachabilityStatusNotReachable:           // 没有网络(断网)
//                
//                [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager.db_networkStatus=DBNetworkStatusNotReachable;
//                
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWWAN:       // 手机自带网络
//                
//                [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager.db_networkStatus=DBNetworkStatusReachableViaWWAN;
//                
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWiFi:       // WIFI
//                
//                [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager.db_networkStatus=DBNetworkStatusReachableViaWiFi;
//                
//                break;
//        }
//    }];
//    
//    [db_NetworkReachabilityManager startMonitoring];
//}
//
//+ (DBNetworkStatus)checkNetStatus {
//    
//    [self startMonitoring];
//    
//    
//    DBNetworkReachabilityManager * db_NetworkReachabilityManager = [DBNetWorkingManager sharedManager].db_NetworkReachabilityManager;
//    
//    
//    if (db_NetworkReachabilityManager.db_networkStatus == DBNetworkStatusReachableViaWiFi) {
//        
//        return DBNetworkStatusReachableViaWiFi;
//        
//    } else if (db_NetworkReachabilityManager.db_networkStatus == DBNetworkStatusNotReachable) {
//        
//        return DBNetworkStatusNotReachable;
//        
//    } else if (db_NetworkReachabilityManager.db_networkStatus == DBNetworkStatusReachableViaWWAN) {
//        
//        return DBNetworkStatusReachableViaWWAN;
//        
//    } else {
//        
//        return DBNetworkStatusUnknown;
//        
//    }
//    
//}


#pragma mark - 监控网络状态


/** 开始监控 */
+(void)db_startMonitoring{
    
    
    NSLog(@"DBNetWorking--开始进行网络监听");
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:nil forKey:@"networkStatusMonitoringStarted"];
    
    AFNetworkReachabilityManager *reachabilityManager =[AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    
    //设置网路状态改变的
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *networkStatus = [ userDefault objectForKey:@"networkStatusMonitoringStarted"];
        NSString * tips = @"";
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:                // 未知网络
                
                tips = @"网络状态未知，请检查网络连接";
                break;
                
            case AFNetworkReachabilityStatusNotReachable:           // 没有网络(断网)
                
                tips = @"网络连接断开，请检查网络连接";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:       // 手机自带网络
                
                tips = @"2G/3G/4G网络已连接";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:       // WIFI
                
                tips = @"WiFi网络已连接";
                break;
        }
        
        if(networkStatus == nil){//第一次监听到
        
            [ userDefault setObject:@"monitoringBegin_1" forKey:@"networkStatusMonitoringStarted"];
            return ;
        }
        
        if([networkStatus isEqualToString:@"monitoringBegin_1"]){//第二次监听到
            
            [ userDefault setObject:@"monitoringBegin_2" forKey:@"networkStatusMonitoringStarted"];
            return ;
        }
        
        __block UIView * blockView = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
    
            UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
            tipsLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
            tipsLabel.text = tips;
            tipsLabel.textColor = [UIColor whiteColor];
            tipsLabel.textAlignment = NSTextAlignmentCenter;
            tipsLabel.font = [UIFont systemFontOfSize:12];

            [blockView addSubview:tipsLabel];
            [self showTipsAnimationWith:tipsLabel];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
                [self dismissTipsAnimationWith:tipsLabel];
                
                [ userDefault setObject:@"monitoringBegin" forKey:@"networkStatusMonitoringStarted"];
            });
        });
    }];
}



+(void)showTipsAnimationWith:(UIView *)view{


    CGRect viewFrame = view.frame;
    viewFrame.origin.y -= 500;
    view.frame = viewFrame;
    viewFrame.origin.y+=500;
    
    //beginAnimations表示此后的代码要"参与到"动画中
    [UIView beginAnimations:nil context:nil];
    
    //设置动画时长
    [UIView setAnimationDuration:1.0];
    
    //修改按钮的frame
    view.frame = viewFrame;
    
    //commitAnimations,将beginAnimation之后的所有动画提交并生成动画
    [UIView commitAnimations];
}

+(void)dismissTipsAnimationWith:(UIView *)view{
    
    
    CGRect viewFrame = view.frame;
    view.frame = viewFrame;
    viewFrame.origin.y -= 500;
    
    //beginAnimations表示此后的代码要"参与到"动画中
    [UIView beginAnimations:nil context:nil];
    
    //设置动画时长
    [UIView setAnimationDuration:1.0];
    
    //修改按钮的frame
    view.frame = viewFrame;
    
    //commitAnimations,将beginAnimation之后的所有动画提交并生成动画
    [UIView commitAnimations];
    
}



/** 停止网络状态的监控 */
- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    NSLog(@"DBNetworkReachabilityManager被销毁-结束网络监听");
}



@end
