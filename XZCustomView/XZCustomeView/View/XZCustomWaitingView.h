//
//  XZCustomWaitingView.h
//  XZCustomView
//
//  Created by LWX on 2017/11/1.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZCustomWaitingView : NSObject



/****************************************************************************************************************/

/**
 显示自适应模态菊花转+文字类型等待框
 提示框会根据文字多少自动拉长适配
 
 @param title 菊花转下方字体
 @param iconName 如果不需要菊花转 需要自定义图片  可传入自定义icon图   例：图标名字前半部分：XZ_loading  全名为：XZ_loading_0   注：图标命名一定要规范
 @param iconNumber icon图总共数量
 */
+ (void)showAdaptiveWaitingMaskView:(NSString *)title iconName:(NSString *)iconName iconNumber:(int)iconNumber;


/****************************************************************************************************************/

/**
 显示模态菊花转+固定大小文字类型等待框
 提示框大小是根据屏幕比例固定的
 
 @param title 菊花转下方字体
 @param iconName 如果不需要菊花转 需要自定义图片 可传入自定义icon图   例：图标名字前半部分：XZ_loading  全名为：XZ_loading_0   注：图标命名一定要规范
 @param iconNumber icon图总共数量
 */
+ (void)showWaitingMaskView:(NSString *)title iconName:(NSString *)iconName iconNumber:(int)iconNumber;
/**
 隐藏模态菊花转+固定大小文字类型等待框
 */
+ (void)hideWaitingMaskView;



/****************************************************************************************************************/

/**
 循环icon图  形成等待页面  翻书样式为例
 
 @param iconName icon图名字前半部分：XZ_loading  全名为：XZ_loading_0
 @param iconNumber icon图总共数量
 */
+ (void)showIconWaitingMaskViewWithIcon:(NSString *)iconName iconNumber:(int)iconNumber;
/**
 隐藏 循环icon图  形成等待页面  翻书样式为例
 
 @param isNeedWait 是否在移除等待界面的时候需要延迟0.5秒执行  根据自己项目需求决定  YES：延迟0.5秒   NO：不延迟直接执行移除
 */
+ (void)hideIconWaitingMaskView:(BOOL)isNeedWait;



/****************************************************************************************************************/

/**
 显示自动隐藏的提示窗口(图片+文字)
 
 @param string 提示框文字，如果不传则不显示
 @param image 提示框图片，如果不传则不显示
 @param duration 显示多长时间后消失
 */
+ (void)showAutoHidePromptView:(NSString *)string
                    background:(UIImage *)image
                      showTime:(float)duration;

/**
 显示自动隐藏的提示窗口(图片+文字)
 带回调   提示框消失后，会有block回调，以便于您在上层做些其他方面的处理
 
 @param string 提示框文字，如果不传则不显示
 @param image 提示框图片，如果不传则不显示
 @param duration 显示多长时间后消失
 */
+ (void)showAutoHidePromptView:(NSString*)string
                    background:(UIImage *)image
                      showTime:(float)duration
                    completion:(void(^)(void))completion;



/****************************************************************************************************************/

/**
 去除等待提示窗口遮罩层
 */
+ (void)hideAutoHidePromptView;



@end
