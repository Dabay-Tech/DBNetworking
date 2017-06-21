//
//  DBProgressHUD.m
//  DBProgressHUDDemo
//
//  Created by Dabay on 2017/6/20.
//  Copyright © 2017年 Dabay. All rights reserved.
//

#import "DBProgressHUD.h"
#import "LoadingImageView.h"

@implementation DBProgressHUD


#pragma mark - 显示带有旋转动画的加载中的HUD

/**
 显示数据加载中的转圈的效果，并显示相应的提示信息（单行）
 
 @param message 加载的提示信息
 @param view HUD要加载到的View
 @return 返回HUD
 */
+ (DBProgressHUD *)db_showLoading:(NSString *)message toView:(UIView *)view {
    if (!view) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    DBProgressHUD *hud = [DBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType =MBProgressHUDAnimationFade;
    hud.backgroundColor = [UIColor clearColor];
    hud.bezelView.color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
    
    //设置提示
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:13];
    
    //这里不要只是这是detailsLabel的textColor，因为MBProgressHUD内部会设置label/detailsLabel的颜色为contentColor
    hud.contentColor = [UIColor whiteColor];
    
    //添加动态加载logo
    LoadingImageView * loadImageView = [LoadingImageView loadImageView];
    hud.customView = loadImageView;
    
    return hud;
}





#pragma mark - 显示提示消息


/**
 显示提示信息（单行）

 @param message 提示信息
 @param view HUD要加载到的View
 */
+ (void)db_showMessage:(NSString *)message toView:(UIView *)view {
    __block UIView * blockView = view;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.label.text = message;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
    });
    
}


/**
 显示错误信息（单行）

 @param error 错误信息
 @param view HUD要加载到的View
 */
+ (void)db_showError:(NSString *)error toView:(UIView *)view{
    [self db_show:error icon:@"error.png" view:view];
}


/**
 显示成功信息（单行）

 @param success 成功信息
 @param view HUD要加载到的View
 */
+ (void)db_showSuccess:(NSString *)success toView:(UIView *)view
{
    [self db_show:success icon:@"success.png" view:view];
}


/**
 显示带有图标的提示信息（单行）
 
 @param text 显示的信息内容
 @param icon 消息类型的图标
 @param view 要加载到的View
 */
+ (void)db_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    __block UIView * blockView = view;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
        
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.detailsLabel.text = text;
        hud.detailsLabel.font = [UIFont systemFontOfSize:15];
        
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"DBProgressHUD.bundle/%@", icon]]];
        
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
        
        // 1.5秒之后再消失
        [hud hideAnimated:YES afterDelay:1.5];
    });
}


#pragma mark 显示多行的提示信息


/**
 显示多行的成功信息。成功信息很多时，可以进行多行显示。（多行）

 @param success 成功信息
 @param view HUD要加载到的View
 */
+(void)db_showMultiLineSuccess:(NSString *)success toView:(UIView *)view
{
    __block UIView * blockView = view;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.detailsLabel.text = success;
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"success.png"]]];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabel.font = [UIFont systemFontOfSize:16]; //Johnkui - added
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
        // 1秒之后再消失
        [hud hideAnimated:YES afterDelay:1.5];
    });
}




/**
 显示多行的错误信息。错误信息很多时，可以进行多行显示。（多行）

 @param error 错误信息
 @param view HUD要加载到的View
 */
+(void)db_showMultiLineError:(NSString *)error toView:(UIView *)view
{
    __block UIView * blockView = view;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.detailsLabel.text = error;
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"error.png"]]];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabel.font = [UIFont systemFontOfSize:16]; //Johnkui - added
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
        // 1秒之后再消失
        [hud hideAnimated:YES afterDelay:1.5];
    });
}


/**
 显示多行的提示信息。提示内容很多时，可以进行多行显示。（多行）
 
 @param message 提示内容
 @param view HUD要加载到的View
 */
+(void)db_showMultiLineMessage:(NSString *)message toView:(UIView *)view
{
    __block UIView * blockView = view;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.detailsLabel.text = message;
        //HUD的背景颜色
        hud.bezelView.color= [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.645362367021276];
        // YES代表需要蒙版效果
        hud.detailsLabel.font = [UIFont systemFontOfSize:16]; //Johnkui - added
    });
}


#pragma mark - 没有指定HUD要加载的View时，对应调用的方法


/**
 显示多行的错误信息。错误信息很多时，可以进行多行显示。（多行，不指定View）
 
 @param error 错误信息
 */
+(void)db_showMultiLineError:(NSString *)error
{
    [self db_showMultiLineError:error toView:nil];
}

/**
 显示多行的成功信息。成功信息很多时，可以进行多行显示。（多行，不指定View）
 
 @param success 成功信息
 */
+(void)db_showMultiLineSuccess:(NSString *)success
{
    [self db_showMultiLineSuccess:success toView:nil];
}

/**
 显示多行的提示信息。提示内容很多时，可以进行多行显示。（多行，不指定View）
 
 @param message 提示信息
 */
+(void)db_showMultiLineMessage:(NSString *)message
{
    [self db_showMultiLineMessage:message toView:nil];
}


/**
 显示成功的信息（单行）
 
 @param success 成功信息
 */
+ (void)db_showSuccess:(NSString *)success
{
    [self db_showSuccess:success toView:nil];
}

/**
 显示错误的信息（单行）
 
 @param error 错误信息
 */
+ (void)db_showError:(NSString *)error
{
    [self db_showError:error toView:nil];
}

/**
 显示提示信息（单行）
 
 @param message 提示信息
 */
+ (void)db_showMessage:(NSString *)message
{
    [self db_showMessage:message toView:nil];
}


/**
 隐藏HUD
 
 @param view HUD所在的View
 */
+ (void)db_hideHUDForView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideHUDForView:view animated:YES];
    });
}

/**
 隐藏HUD
 */
+ (void)db_hideHUD
{
    [self db_hideHUDForView:nil];
}


/**
 隐藏HUD，带有动画
 
 @param animated 隐藏HUD的时候是否带有动画
 */
+ (void)db_hideHUDAnimated:(BOOL)animated
{
    [self db_hideHUDAnimated:animated];
}




@end
