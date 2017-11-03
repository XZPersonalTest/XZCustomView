//
//  XZCusomViewModel.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, XZCusomViewModelType)
{
    /**< 0 HUD  BOOK */
    XZCusomViewModelTypeHUD                         = 0,
    /**< 1  自动隐藏提示窗*/
    XZCusomViewModelTypeAutoHideView                = 1,
    /**< 2：alertView */
    XZCusomViewModelTypeAlert                       = 2,
    /**< 3：actionSheetView */
    XZCusomViewModelTypeActionSheet                 = 3,
    /**< 4：pickerView */
    XZCusomViewModelTypePickerView                  = 4,
    
};


@interface XZCusomViewModel : NSObject

@property (weak , nonatomic) UIView *view;

@property (assign , nonatomic ) XZCusomViewModelType type;

@end
