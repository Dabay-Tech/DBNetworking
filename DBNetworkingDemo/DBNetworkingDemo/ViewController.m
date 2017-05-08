//
//  ViewController.m
//  DBNetworkingDemo
//
//  Created by Dabay on 2017/5/4.
//  Copyright © 2017年 Dabay. All rights reserved.
//

#import "ViewController.h"

#import "DBNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //配置在APPdelegate中，在APP代理代理方法didFinishLaunching中设置一次即可
    DBNetWorkingManager *manager=[DBNetWorkingManager sharedManager];
    manager.db_BaseURLString=@"http://taofei.me";
    manager.db_certificateString=@"*.dabay.cn";
    
    
    //请求参数
    NSDictionary *param=[[NSDictionary alloc]init];
    
    [DBHTTPSSessionManager db_postRequestWithURLString:@"" Parameterss:param succeed:^(NSDictionary * _Nonnull responseDictionary) {
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
    
}




@end
