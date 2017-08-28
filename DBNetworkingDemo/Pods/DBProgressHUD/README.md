# DBProgressHUD

![Pod version](https://img.shields.io/cocoapods/v/DBProgressHUD.svg?style=flat)
[![Platform info](https://img.shields.io/cocoapods/p/DBProgressHUD.svg?style=flat)](http://cocoadocs.org/docsets/DBProgressHUD)
![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)



DBProgressHUD inherited from MBProgressHUD, is based on the MBProgressHUD part of the expansion of the function. Is still in the initial stage, follow-up will add more useful features.

## Requirements

`DBProgressHUD` works on iOS 8+ and requires ARC to build. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

- Foundation.framework
- UIKit.framework
- CoreGraphics.framework

You will need the latest developer tools in order to build `DBProgressHUD`. Old Xcode versions might work, but compatibility will not be explicitly maintained.

## Instructions

## Adding DBProgressHUD to your project

### CocoaPods

[CocoaPods](http://cocoapods.org/) is the recommended way to add DBProgressHUD to your project.

1. Add a pod entry for DBProgressHUD to your Podfile `pod 'DBProgressHUD'`
2. Install the pod(s) by running `pod install`.
3. Include DBProgressHUD wherever you need it with `#import "DBProgressHUD.h"`.

### Source files

Alternatively you can directly add the `DBProgressHUD.h` and `DBProgressHUD.m` source files to your project.

1. Download the [latest code version](https://github.com/Dabay-Tech/DBProgressHUD.git) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop `DBProgressHUD.h` and `DBProgressHUD.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. Include DBProgressHUD wherever you need it with `#import "DBProgressHUD.h"`.

## Usage

```objective-c
[DBProgressHUD db_showTips:@"大白科技-DBProgressHUD"];
[DBProgressHUD db_showLoading:@"DBProgressHUD-努力加载中" toView:self.view];
[DBProgressHUD db_showLoading:@"DBProgressHUD-加载中" toView:nil];
[DBProgressHUD db_showMessage:@"DBProgressHUD-showMessage"];
[DBProgressHUD db_showSuccess:@"DBProgressHUD-showSuccess" toView:nil];
[DBProgressHUD db_showSuccess:@"DBProgressHUD-请求成功"];
[DBProgressHUD db_showError:@"服务暂不可用，请稍后重试"];
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [DBProgressHUD db_hideHUDAnimated:NO];
});
```

## License

This code is distributed under the terms and conditions of the [MIT license](https://github.com/jdg/MBProgressHUD/blob/master/LICENSE).



