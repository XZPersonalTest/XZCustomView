//
//  XZTestEnum.h
//  XZCustomView
//
//  Created by LWX on 2017/10/31.
//  Copyright © 2017年 LWX. All rights reserved.
//

#ifndef XZTestEnum_h
#define XZTestEnum_h


/**
 弹窗类型
 */
typedef NS_ENUM (NSUInteger, XZCustomViewType){
    
    XZCustomViewTypeWaitingMaskView                      = 1,     // 等待提示框
    XZCustomViewTypeAlertView                            = 2,     // 警告视图提示框
    XZCustomViewTypeActionSheetView                      = 3,     // 动作表单视图
    XZCustomViewTypePickerView                           = 4,     // 选择视图
    
    
};


/**
 等待提示框类型
 */
typedef NS_ENUM (NSUInteger, XZCustomViewWaitingType)
{
    
    XZCustomViewWaitingTypeAdaptiveTitleSize                    = 1,     // 自适应文字+菊花等待窗类型
    XZCustomViewWaitingTypeFixedTitleSize                       = 2,     // 固定文字大小+菊花等待窗类型
    XZCustomViewWaitingTypeLoopIcon                             = 3,     // 循环Icon图标形成的等待界面
    XZCustomViewWaitingTypeAutoHideView                         = 4,     // 自动隐藏提示框
    XZCustomViewWaitingTypeTitle                                = 5,     // 纯文字提醒
    
};


/**
 警告视图提示框类型
 */
typedef NS_ENUM (NSUInteger, XZCustomViewAlertViewType)
{
    
    XZCustomViewAlertViewTypeSystemAlertOneBtn                                = 1,     // 系统文字alertView样式提示窗一个按钮
    XZCustomViewAlertViewTypeSystemAlertTwoBtn                                = 2,     // 系统文字alertView样式提示窗两个按钮
    XZCustomViewAlertViewTypeSystemInputAlert                                 = 3,     // 系统alertView样式提示窗，有输入框
    XZCustomViewAlertViewTypeVerifyPhoneNumber                                = 4,     // 验证手机号弹窗
    
};



#endif /* XZTestEnum_h */


