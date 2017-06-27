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
    manager.db_certificateString=@"*.dabay.cn";

    
//    [DBHTTPSSessionManager db_postRequestWithURLString:@"index/banner.json?" Parameters:nil isWithHUD:YES succeed:^(NSDictionary * _Nonnull responseDictionary) {
//        
//        
//        NSLog(@"viewdidload--请求成功");
//    } failure:^(NSError * _Nonnull error) {
//        
//        NSLog(@"viewdidload--请求失败");
//    }];

    
    

//    [DBHTTPSSessionManager db_postRequestWithURLString:@"index/banner.json?" Parameters:nil isWithHUD:YES succeed:^(NSDictionary * _Nonnull responseDictionary) {
//        
//        
//    } failure:^(NSError * _Nonnull error) {
//        
//        
//    }];
    
    
    
    [DBPoster db_postURLString:@"index/banner.json?" parameters:nil succeed:^(NSDictionary *responseDictionary) {
        
        
    } failure:^(NSError *error) {
        
        
    }];
    

    
    
    
    
    
    
    
    
    //请求参数
//    NSDictionary *param=[[NSDictionary alloc]init];
//    
//    
//    [DBHTTPSSessionManager db_postRequestWithURLString:@"" Parameterss:param succeed:^(NSDictionary * _Nonnull responseDictionary) {
//        
//        
//    } failure:^(NSError * _Nonnull error) {
//        
//        
//    }];
    
    
}




@end
