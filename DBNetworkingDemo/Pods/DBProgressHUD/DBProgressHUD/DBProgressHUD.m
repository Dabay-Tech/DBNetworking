//
//  DBProgressHUD.m
//  DBProgressHUDDemo
//
//  Created by Dabay on 2017/6/20.
//  Copyright © 2017年 Dabay. All rights reserved.
//

#import "DBProgressHUD.h"
#import "DBLoadingImageView.h"






@implementation DBProgressHUD



/**
 显示纯文本形式的提示
 
 @param tips 提示的内容
 */
+(void)db_showTips:(NSString *)tips{

    __block UIView * blockView = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
        
        // 快速显示一个提示信息
        DBProgressHUD *hud = [DBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.detailsLabel.text = tips;
        hud.detailsLabel.font = [UIFont systemFontOfSize:15];
        hud.contentColor=[UIColor whiteColor];
        
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
        
        // 1.5秒之后再消失

        [hud hideAnimated:YES afterDelay:1.5];
    });

}


#pragma mark - 显示带有旋转动画的加载中的HUD

/**
 显示数据加载中的转圈的效果，并显示相应的提示信息（单行）
 
 @param message 加载的提示信息
 @param view HUD要加载到的View，这里的view可以传nil
 */
+ (void)db_showLoading:(NSString *)message toView:(UIView *)view{
    
    
    __block UIView * blockView = view;

    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
        
        // 快速显示一个提示信息
        DBProgressHUD *hud = [DBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.label.text = message;
        hud.label.font = [UIFont systemFontOfSize:15];
        //这里不要只是这是detailsLabel的textColor，因为MBProgressHUD内部会设置label/detailsLabel的颜色为contentColor
        hud.contentColor = [UIColor whiteColor];

        // 设置图片,添加动态加载logo
        DBLoadingImageView * loadImageView = [DBLoadingImageView loadImageView];
        hud.customView = loadImageView;
        
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        [blockView addSubview:hud];
        [hud showAnimated:YES];
        
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
    });
}


/**
 显示数据加载中的转圈的效果，并显示相应的提示信息(无需指定view，默认使用当前显示的控制器的view)
 
 @param message 加载时的提示信息
 */
+ (void)db_showLoading:(NSString *)message{

    [self db_showLoading:message toView:nil];

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
        
        if (!blockView) {
            blockView = [[UIApplication sharedApplication].windows lastObject];
        }
        // 快速显示一个提示信息
        DBProgressHUD *hud = [DBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.label.text = message;
        hud.contentColor = [UIColor whiteColor];
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
        
        [self db_startAnimationWithView:hud];
    });
}


/**
 显示错误信息（单行）
 
 @param error 错误信息
 @param view HUD要加载到的View
 */
+ (void)db_showError:(NSString *)error toView:(UIView *)view{
    [self db_show:error icon:@"icon_fail.png" view:view];
}


/**
 显示成功信息（单行）
 
 @param success 成功信息
 @param view HUD要加载到的View
 */
+ (void)db_showSuccess:(NSString *)success toView:(UIView *)view
{
    [self db_show:success icon:@"icon_success.png" view:view];
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
        DBProgressHUD *hud = [DBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.detailsLabel.text = text;
        hud.detailsLabel.font = [UIFont systemFontOfSize:15];
        hud.contentColor=[UIColor whiteColor];
        
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"DBProgressHUD.bundle/%@", icon]]];
        
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
//        hud.bezelView.color= [UIColor whiteColor];
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
        
        // 1.5秒之后再消失
        [self db_startAnimationWithView:hud];
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
        DBProgressHUD *hud = [DBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.detailsLabel.text = success;
        hud.contentColor = [UIColor whiteColor];
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"success.png"]]];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabel.font = [UIFont systemFontOfSize:15]; //Johnkui - added
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
        // 3秒之后再消失
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
        DBProgressHUD *hud = [DBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.detailsLabel.text = error;
        hud.contentColor = [UIColor whiteColor];
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"error.png"]]];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabel.font = [UIFont systemFontOfSize:15]; //Johnkui - added
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
        // 2秒之后再消失
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
        DBProgressHUD *hud = [DBProgressHUD showHUDAddedTo:blockView animated:YES];
        hud.detailsLabel.text = message;
        hud.contentColor = [UIColor whiteColor];
        //HUD的背景颜色
        hud.bezelView.color= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
        // YES代表需要蒙版效果
        hud.detailsLabel.font = [UIFont systemFontOfSize:15]; //Johnkui - added
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
+ (void )db_showMessage:(NSString *)message
{
    [self db_showMessage:message toView:nil];
}


/**
 隐藏加载中的LoadingView
 */
+(void)db_dismissLoadingMessage{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView * blockView =nil;
        if (blockView == nil) blockView = [[UIApplication sharedApplication].windows lastObject];
        [self hideHUDForView:blockView animated:YES];
    });
}



/**
 隐藏HUD--默认有隐藏动画
 
 @param view HUD所在的View
 */
+ (void)db_hideHUDForView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView * hudView =view;
        if (hudView == nil) hudView = [[UIApplication sharedApplication].windows lastObject];
        [self hideHUDForView:hudView animated:YES];
    });
}

/**
 隐藏HUD--默认有隐藏动画
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
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView * hudView = [[UIApplication sharedApplication].windows lastObject];
        [self hideHUDForView:hudView animated:animated];
    });
}


/** start animation */
+(void)db_startAnimationWithView:(UIView *)view{

    CGRect viewFrame = view.frame;
    viewFrame.origin.y -= 500;
    view.frame = viewFrame;
    viewFrame.origin.y+=500;
    
    //beginAnimations表示此后的代码要"参与到"动画中
    [UIView beginAnimations:nil context:nil];
    
    //设置动画时长
    [UIView setAnimationDuration:0.3];
    
    //修改按钮的frame
    view.frame = viewFrame;
    
    //commitAnimations,将beginAnimation之后的所有动画提交并生成动画
    [UIView commitAnimations];

}


@end
