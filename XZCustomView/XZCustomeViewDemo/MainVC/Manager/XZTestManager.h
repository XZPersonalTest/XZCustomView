//
//  XZTestManager.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZTestModel.h"

@interface XZTestManager : NSObject


/**
 获取数据
 
 @return 数据Model数组
 */
+ (NSMutableArray *)loadDataWithCustomViewType:(XZCustomViewType)customViewType;


@end
