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
@property(nonatomic,strong) DBNetworkReachabilityManager * re_manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //配置在APPdelegate中，在APP代理代理方法didFinishLaunching中设置一次即可
    DBNetWorkingManager *manager=[DBNetWorkingManager sharedManager];
    manager.db_BaseURLString=@"";
    manager.db_certificateString=@"";
    
    
    
//    [DBNetworkReachabilityManager db_startMonitoring] ;
    
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
    

    

        
    
}





@end
