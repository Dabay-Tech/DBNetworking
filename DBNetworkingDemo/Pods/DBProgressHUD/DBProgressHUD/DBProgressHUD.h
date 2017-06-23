//
//  DBProgressHUD.h
//  DBProgressHUDDemo
//
//  Created by Dabay on 2017/6/20.
//  Copyright © 2017年 Dabay. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>




@interface DBProgressHUD : MBProgressHUD


/**
 显示数据加载中的转圈的效果，并显示相应的提示信息
 
 @param message 加载时的提示信息
 @param view HUD要加载到的View
 @return 返回HUD
 */
+ (DBProgressHUD *)db_showLoading:(NSString *)message toView:(UIView *)view;




#pragma mark - 提示内容单行的HUD - （单行）

/**
 显示成功信息（单行）
 
 @param success 成功信息
 @param view HUD要加载到的View
 */
+ (void)db_showSuccess:(NSString *)success toView:(UIView *)view;

/**
 显示错误信息（单行）
 
 @param error 错误信息
 @param view HUD要加载到的View
 */
+ (void)db_showError:(NSString *)error toView:(UIView *)view;

/**
 显示提示信息（单行）
 
 @param message 提示信息
 @param view HUD要加载到的View
 */
+ (DBProgressHUD *)db_showMessage:(NSString *)message toView:(UIView *)view;


/**
 显示成功的信息（单行）

 @param success 成功信息
 */
+ (void)db_showSuccess:(NSString *)success;


/**
 显示错误的信息（单行）

 @param error 错误信息
 */
+ (void)db_showError:(NSString *)error;


/**
 显示提示信息（单行）

 @param message 提示信息
 */
+ (DBProgressHUD *)db_showMessage:(NSString *)message;


/**
 隐藏带有动画的加载HUD
 */
-(void)db_dismissLoadingMessage;

/**
 隐藏HUD

 @param view HUD所在的View
 */
+ (void)db_hideHUDForView:(UIView *)view;


/**
 隐藏HUD
 */
+ (void)db_hideHUD;


/**
 隐藏HUD，带有动画

 @param animated 隐藏HUD的时候是否带有动画
 */
+ (void)db_hideHUDAnimated:(BOOL)animated;





#pragma mark - 提示内容可以换行的HUD - （多行）

/**
 显示多行的成功信息。成功信息很多时，可以进行多行显示。（多行，指定View）
 
 @param success 成功信息
 @param view HUD要加载到的View
 */
+ (void)db_showMultiLineSuccess:(NSString *)success toView:(UIView *)view;

/**
 显示多行的错误信息。错误信息很多时，可以进行多行显示。（多行）
 
 @param error 错误信息
 @param view HUD要加载到的View
 */
+ (void)db_showMultiLineError:(NSString *)error toView:(UIView *)view;

/**
 显示多行的提示信息。提示内容很多时，可以进行多行显示。（多行）
 
 @param message 提示内容
 @param view HUD要加载到的View
 */
+ (void)db_showMultiLineMessage:(NSString *)message toView:(UIView *)view;


/**
 显示多行的成功信息。成功信息很多时，可以进行多行显示。（多行，不指定View）

 @param success 成功信息
 */
+ (void)db_showMultiLineSuccess:(NSString *)success;


/**
 显示多行的错误信息。错误信息很多时，可以进行多行显示。（多行，不指定View）

 @param error 错误信息
 */
+ (void)db_showMultiLineError:(NSString *)error;



/**
 显示多行的提示信息。提示内容很多时，可以进行多行显示。（多行，不指定View）

 @param message 提示信息
 */
+ (void)db_showMultiLineMessage:(NSString *)message;



@end
