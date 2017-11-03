//
//  XZTestVC.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZTestEnum.h"

@interface XZTestVC : UIViewController

/** 弹窗类型
 这个XZTestVC控制器 实现了首页列表和加载等待系列列表功能
 如果customViewType这个字段传值为0时，展示的为首页列表  如果传值为XZCustomViewTypeWaitingMaskView时，展示的为加载等待系列功能列表
 */
@property (nonatomic, assign) XZCustomViewType customViewType;



@end
