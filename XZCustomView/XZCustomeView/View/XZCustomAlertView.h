//
//  XZCustomAlertView.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZTool.h"


/**
 alertView 类型
 */
typedef NS_ENUM(NSUInteger, XZAlertViewType)
{
    /**< 0:系统文字alertView样式提示窗 */
    XZAlertViewTypeSystemAlert                            = 0,
    /**< 1:系统alertView样式提示窗，有输入框 */
    XZAlertViewTypeSystemInputAlert                       = 1,
    /**< 2:验证手机号弹窗 */
    XZAlertViewTypeVerifyPhoneNumber                      = 2,
    
};

/**
 alertView 按钮tag值
 */
typedef NS_ENUM(NSUInteger, XZAlertViewBtnTag)
{
    
    /** 点击背景tag值 */
    XZAlertViewBtnTagBgCancel                            = -1,
    /** 取消按钮tag值 */
    XZAlertViewBtnTagCancel                              = 1000,
    /** 确认按钮tag值 */
    XZAlertViewBtnTagSure                                = 1001,
    /** 获取验证码按钮tag值 */
    XZAlertViewBtnTagVerificationCode                    = 1002,
    
};

/**
 TextField输入框 tag值
 */
typedef NS_ENUM(NSUInteger, XZTextFieldTag)
{
    
    /** 系统文字alertView样式弹窗输入框tag值 */
    XZTextFieldTagSystemAlert                                     = 2000,
    /** 手机号输入框tag值 */
    XZTextFieldTagPhoneNumber                                     = 2001,
    /** 验证码输入框tag值 */
    XZTextFieldTagVerificationCode                                = 2003,
    
    
};



@interface XZCustomAlertView : UIView

/** 弹窗类型 */
@property (nonatomic, assign) XZAlertViewType alertViewType;

/** 系统alertView样式提示窗的输入框 */
@property (nonatomic, strong) UITextField *systemInputAlertViewTextField;
/** 输入手机号 */
@property (nonatomic, strong) UITextField *inputMobileNumTextField;
/** 输入验证码 */
@property (nonatomic, strong) UITextField *inputPincodeTextField;
/** 获取pincode按钮 */
@property (nonatomic, strong) XZBorderButton *getPincodeButton;


//
typedef void (^textFieldChange)(UITextField *textField);
typedef BOOL (^textFieldShouldChange)(UITextField *textField ,NSRange range ,NSString *string);
typedef void (^XZCustomAlertViewClickBlock)(XZCustomAlertView *alertView , XZAlertViewBtnTag index ,XZAlertViewType alertViewType);

@property (nonatomic ,copy)textFieldChange textFieldChange;
@property (nonatomic ,copy)textFieldShouldChange textFieldShouldChange;
@property (nonatomic ,copy)XZCustomAlertViewClickBlock clickBlock;

#pragma mark - View Init


//自定义样式弹窗  -- 后期拓展
//- (instancetype)initCustomAlertViewWithImageArray:(NSArray *)imageArray
//                                  withbuttonArray:(NSArray *)buttonArray
//                                  withStatusImage:(UIImage *)statusImage
//                                   withPromptText:(NSString *)promptText
//                                withAlertViewType:(XZAlertViewType)alertViewType
//                                          handler:(void (^)(XZCustomAlertView *alertView, NSInteger buttonIndex ,XZAlertViewType alertViewType))block;


//系统样式弹窗
- (instancetype)initSystemAlertViewWithTitle:(NSString *)title
                                     message:(NSString *)message
                           cancelButtonTitle:(NSString *)cancelTitle
                            otherButtonTitle:(NSString *)otherTitle
                           isTouchBackground:(BOOL)isTouchBackground
                           withAlertViewType:(XZAlertViewType)alertViewType
                                     handler:(void (^)(XZCustomAlertView *alertView, XZAlertViewBtnTag index ,XZAlertViewType alertViewType))block;




//textFieldChange
- (void)setTextFieldChangeHandler:(void (^)(UITextField *textField))block;


//textFieldShoudChange
- (void)setTextFieldShoudChangeHandler:(BOOL (^)(UITextField *textField ,NSRange range ,NSString *string))block;



#pragma mark - Show/cancel Modal View
// 选择取消按钮
- (void)cancelAction;
// 显示模态视图
- (void)show;

@end
