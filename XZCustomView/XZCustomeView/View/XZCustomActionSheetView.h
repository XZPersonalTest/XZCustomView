//
//  XZCustomActionSheetView.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZCustomActionSheetView;

@interface XZCustomActionSheetView : UIView


typedef void (^XZCustomActionSheetClickBlock)(XZCustomActionSheetView *actionSheetView , NSInteger index);

/**
 上滑提示框

 @param title 标题
 @param cancelTitle 取消按钮标题
 @param buttonTitles 选项按钮标题数组
 @param clickBlock 选中按钮后的回调
 @return return value description
 */
- (instancetype)initCustomActionSheetWithTitle:(NSString *)title
                             cancelButtonTitle:(NSString *)cancelTitle
                             otherButtonTitles:(NSArray *)buttonTitles
                                        handle:(void (^)(XZCustomActionSheetView *actionSheetView , NSInteger index))clickBlock;


/**
 显示模态视图
 */
- (void)show;


@end
