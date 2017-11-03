//
//  XZTestModel.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZTestEnum.h"


@interface XZTestModel : NSObject

/** 标题 */
@property (nonatomic, copy) NSString * title;

/** 弹窗类型 */
@property (nonatomic, assign)  XZCustomViewType customViewType;

/** 等待提示框类型 */
@property (nonatomic, assign) XZCustomViewWaitingType customViewWaitingType;

/** AlertView弹窗类型 */
@property (nonatomic, assign) XZCustomViewAlertViewType customViewAlertViewType;

@end
