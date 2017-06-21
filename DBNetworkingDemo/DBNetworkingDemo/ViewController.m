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

@interface ViewController ()

@property(nonatomic,strong) DBProgressHUD *hud;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    //配置在APPdelegate中，在APP代理代理方法didFinishLaunching中设置一次即可
    DBNetWorkingManager *manager=[DBNetWorkingManager sharedManager];
    manager.db_BaseURLString=@"http://taofei.me";
    manager.db_certificateString=@"*.dabay.cn";
    
    
    self.hud=[DBProgressHUD db_showLoading:@"加载中" toView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [DBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    
    
    
    
    
    
    
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
