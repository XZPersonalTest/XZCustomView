//
//  XZTestCell.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>


UIKIT_EXTERN NSString *const XZTestCellID;

@class XZTestModel;

@interface XZTestCell : UITableViewCell


/** 标题 */
@property (nonatomic, copy) XZTestModel * testModel;

@end
