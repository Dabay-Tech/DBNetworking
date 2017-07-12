//
//  ViewController.m
//  DBNetworkingDemo
//
//  Created by Dabay on 2016/5/4.
//  Copyright © 2016年 Dabay. All rights reserved.
//

#import "ViewController.h"

#import "DBNetworking.h"
#import <DBProgressHUD.h>
#import "DBPoster.h"
#import "DBNetworkReachabilityManager.h"

@interface ViewController ()

@property(nonatomic,strong) DBProgressHUD *hud;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    //配置在APPdelegate中，在APP代理代理方法didFinishLaunching中设置一次即可
    DBNetWorkingManager *manager=[DBNetWorkingManager sharedManager];
    manager.db_BaseURLString=@"https://122.226.66.214:7780/ywcitzencard";
    manager.db_certificateString=@"";

    
//    [DBHTTPSSessionManager db_postRequestWithURLString:@"index/banner.json?" Parameters:nil isWithHUD:YES succeed:^(NSDictionary * _Nonnull responseDict) {
//        
//        
//        NSLog(@"viewdidload--请求成功");
//    } failure:^(NSError * _Nonnull error) {
//        
//        NSLog(@"viewdidload--请求失败");
//    }];

    
    

//    [DBHTTPSSessionManager db_postRequestWithURLString:@"index/banner.json?" Parameters:nil isWithHUD:YES succeed:^(NSDictionary * _Nonnull responseDict) {
//        
//        
//    } failure:^(NSError * _Nonnull error) {
//        
//        
//    }];
    
    
    
//    [DBPoster db_URLString:@"index/banner.json?" parameters:nil succeed:^(NSDictionary *responseDict) {
//        NSLog(@"请求成功");
//        NSLog(@"responseDict--%@",responseDict);
//    } failure:^(NSError *error) {
//        NSLog(@"请求失败");
//    }];
    
    
//    [DBPoster db_withoutHUDWithURLString:@"index/banner.json?" parameters:nil succeed:^(NSDictionary *responseDict) {
//        
//        
//    } failure:^(NSError *error) {
//        
//        
//    }];
    
    
//    [DBPoster db_withHUDInView:self.view URLString:@"index/banner.json?" parameters:nil succeed:^(NSDictionary *responseDict) {
//        
//        NSLog(@"请求成功");
//    } failure:^(NSError *error) {
//        
//        NSLog(@"请求失败");
//    }];
    
    AFNetworkReachabilityManager *reachabilityManager =[AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    
    
    //设置网路状态改变的
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
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
        
        __block UIView * blockView = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
            
            UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
            tipsLabel.backgroundColor = [UIColor redColor];
            tipsLabel.text = tips;
            tipsLabel.textColor = [UIColor whiteColor];
            tipsLabel.textAlignment = NSTextAlignmentCenter;
            tipsLabel.font = [UIFont systemFontOfSize:12];
            
            
            [blockView addSubview:tipsLabel];
            
            
//            // 快速显示一个提示信息
//            DBProgressHUD *hud = [DBProgressHUD showHUDAddedTo:blockView animated:YES];
//            hud.detailsLabel.text= tips;
//            //HUD的背景颜色
//            hud.bezelView.color= [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.645362367021276];
////            hud.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
//            // YES代表需要蒙版效果
//            hud.detailsLabel.font = [UIFont systemFontOfSize:16]; //Johnkui - added
//            
//            
//            [hud hideAnimated:YES afterDelay:3.0];
        });
        
        
        
        
        
        
        
        
    }];

    
    
    
    
    
    
    
    
    //请求参数
//    NSDictionary *param=[[NSDictionary alloc]init];
//    
//    
//    [DBHTTPSSessionManager db_postRequestWithURLString:@"" Parameterss:param succeed:^(NSDictionary * _Nonnull responseDict) {
//        
//        
//    } failure:^(NSError * _Nonnull error) {
//        
//        
//    }];
    
    
}


/**
 隐藏状态栏
 
 @return 返回状态栏是否隐藏
 */
-(BOOL)prefersStatusBarHidden

{
    
    return YES;// 返回YES表示隐藏，返回NO表示显示
}



@end
