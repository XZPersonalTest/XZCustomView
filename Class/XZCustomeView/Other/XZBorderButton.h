//
//  XZBorderButton.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZBorderButton : UIButton

@property (nonatomic) BOOL isNeedBorder; // 是否要边框
@property (nonatomic) BOOL isNoNeedCorner; // 是否不需要圆角
@property (nonatomic) float cornerRadius; // 圆角的弧度
@property (nonatomic) float borderWidth;  // 边框宽度

@property (nonatomic, retain) UIColor *borderStateNormalColor; // 边框正常状态时的颜色
@property (nonatomic, retain) UIColor *borderStateHighlightedColor; // 边框高亮时的颜色
@property (nonatomic, retain) UIColor *borderStateDisabledColor; // 边框禁用时的颜色
@property (nonatomic, retain) UIColor *borderStateSelectedColor; // 边框选择时的颜色

@property (nonatomic, retain) UIColor *backgroundStateNormalColor; // 按钮正常状态时的背景颜色
@property (nonatomic, retain) UIColor *backgroundStateHighlightedColor; // 按钮高亮时的背景颜色
@property (nonatomic, retain) UIColor *backgroundStateDisabledColor; // 按钮禁用时的背景颜色
@property (nonatomic, retain) UIColor *backgroundStateSelectedColor; // 按钮选择时的背景颜色

@property (nonatomic, assign) BOOL avtive;

@end
