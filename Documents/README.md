
# DBNetworking

DBNetworking是基于AFNetworking开发的网络请求框架。DBNetworking集成依赖于AFNetworking(3.1.0)、DBProgressHUD，提供HTTPS请求的相关方法，并可以自动监控网络状态的改变并弹出相应的提示。在网络请求时有提供默认的加载中提示。

## 简介

## 将DBNetworking加入到项目中

建议使用CocoaPods对项目中的第三方框架进行管理。

- 在Podfile文件中添加`pod 'DBNetworking'`；
- 使用`pod install`命令将DBNetworking加入到项目中；
- 在使用的时候将其引入或者在PCH文件中将其引入；

## DBNetworking的使用

### 初始化

在发送网络请求之前要对网络请求的管理者进行初始化操作，如下：

```objective-c
DBNetWorkingManager *manager=[DBNetWorkingManager sharedManager];
manager.db_BaseURLString=@"http://taofei.me";
manager.db_certificateString=@"donkey.dabay.cn";
```

DBNetWorkingManager使用sharedManager方法创建后作为单例存在，然后设置项目的基地址和HTTPS请求相关的证书名称，并且将证书加入到项目中。

### DBPoster

DBPoster是专门发送POST请求的类，在项目中如果POST请求使用的频率比较高，使用DBPoster发送POST请求可以简化代码。DBPoster中提供了一些实用的方法。

#### 网络请求默认带有HUD提示加载中

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

#### 网络请求的同时不显示HUD提示加载中 

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

#### 网络请求的同时加载HUD到特定的View上

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

#### DBPoster的使用

```objective-c
[DBPoster db_withHUDInView:self.view URLString:@"index/banner.json?" parameters:nil succeed:^(NSDictionary *responseDict) {

    NSLog(@"请求成功");
} failure:^(NSError *error) {
    NSLog(@"请求失败");
}];
```






