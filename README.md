
# DBNetworking

DBNetworking is a high level request util based on AFNetworking. It's developed by the iOS Team of Dabay-Tech. It provides a High Level API for network request.

## Requirements

`DBNetworking` works on iOS 8+ and requires ARC to build. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

- Foundation.framework
- UIKit.framework
- CoreGraphics.framework

You will need the latest developer tools in order to build `DBNetworking`. Old Xcode versions might work, but compatibility will not be explicitly maintained.

## Instructions

## Adding DBProgressHUD to your project

### CocoaPods

[CocoaPods](http://cocoapods.org/) is the recommended way to add DBNetworking to your project.

1. Add a pod entry for DBProgressHUD to your Podfile `pod 'DBNetworking'`
2. Install the pod(s) by running `pod install`.
3. Include DBProgressHUD wherever you need it with `#import "DBNetworking.h"`.

### Source files

Alternatively you can directly add the `DBNetworking.h` and `DBNetworking.m` source files to your project.

1. Download the [latest code version](https://github.com/Dabay-Tech/DBNetworking.git) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop `DBNetworking.h` and `DBNetworking.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. Include DBProgressHUD wherever you need it with `#import "DBNetworking.h"`.

## Usage

### At the every beginning

```objective-c
DBNetWorkingManager *manager=[DBNetWorkingManager sharedManager];
manager.db_BaseURLString=@"http://taofei.me";
manager.db_certificateString=@"donkey.dabay.cn";
```

### DBPoster

DBPoster is useful tool for post request, providing three function.

#### HUD tips show out  by default

```objective-c
/**
 DBNetworking--发送POST请求--带有默认的HUD提示
 
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_URLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;
```

#### No HUD tips show out 

```objective-c
/**
 DBNetworking--发送POST请求--没有默认的HUD提示

 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
+(void)db_withoutHUDWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters succeed:(SuccessBlock)successBlock failure:(FailedBlock)failedBlock;
```

#### HUD tips show out in Specified view

```objective-c
/**
 DBNetworking--发送POST请求--指定HUD显示在View上

 @param view HUD显示在View上
 @param URLString 网络请求的URL地址字符串
 @param parameters 网络请求的参数
 @param successBlock 网络请求成功的回调
 @param failedBlock 网络请求失败的回调
 */
```

#### Using DBPoster

```objective-c
[DBPoster db_withHUDInView:self.view URLString:@"index/banner.json?" parameters:nil succeed:^(NSDictionary *responseDict) {

    NSLog(@"请求成功");
} failure:^(NSError *error) {
    NSLog(@"请求失败");
}];
```

## License

This code is distributed under the terms and conditions of the [MIT license](https://github.com/jdg/MBProgressHUD/blob/master/LICENSE).




