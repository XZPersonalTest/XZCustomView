//
//  XZCustomWindowManager.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZTool.h"

#import "XZCusomViewModel.h"

@interface XZCustomWindowManager : NSObject

//自定义window
@property (strong , nonatomic) NSMutableArray<XZCusomViewModel *> *customViews;


@property (weak , nonatomic) UIView *defuatSuperView;

@property (weak , nonatomic) UIView *authorDefuatSuperView;

interfaceSingleton(Manager)


/**
 添加提示窗

 @param view 添加到哪个View上
 @param type 提示框类型
 @return 添加是否成功
 */
- (BOOL)addCustomView:(UIView *)view withType:(XZCusomViewModelType)type;


/**
 *  移除提示框的所有弹出窗 :是否包含hud
 */
- (void)removeAllCustomView:(BOOL)isHud;


/**
 移除当前提示窗，并显示上一个隐藏的提示窗

 @param view 显示提示框的View
 */
- (void)removeCustomView:(UIView *)view;


/**
 移除某一类弹出窗 :（hud）

 @param type 弹窗类型
 */
- (void)removeCustomViewWithType:(XZCusomViewModelType)type;

@end
