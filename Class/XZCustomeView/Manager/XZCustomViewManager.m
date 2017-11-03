//
//  XZCustomViewManager.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "XZCustomViewManager.h"


@implementation XZCustomViewManager

#pragma mark - actionSheet

/**
 上滑提示框

 @param title 标题
 @param cancelTitle 取消按钮标题
 @param buttonTitles 选项按钮标题数组
 @param clickBlock 选中按钮后的回调
 @return return value description
 */
+ (XZCustomActionSheetView *)showCustomActionSheetWithTitle:(NSString *)title
                                          cancelButtonTitle:(NSString *)cancelTitle
                                          otherButtonTitles:(NSArray *)buttonTitles
                                                     handle:(void (^)(XZCustomActionSheetView *actionSheetView , NSInteger index))clickBlock
{
    XZCustomActionSheetView *actionSheet = [[XZCustomActionSheetView alloc]initCustomActionSheetWithTitle:title
                                                                                        cancelButtonTitle:cancelTitle
                                                                                        otherButtonTitles:buttonTitles
                                                                                                   handle:clickBlock];
    [actionSheet show];
    return actionSheet;
}



#pragma  mark - alertView


/**
 系统样式AlertView弹窗

 @param title 弹窗标题
 @param message 弹窗提示内容
 @param cancelTitle 取消按钮标题
 @param otherTitle 其他按钮标题
 @param isTouchBackground 是否需要开启点击背景移除弹窗功能
 @param alertViewType 弹窗类型
 @param block 点击按钮后的block回调
 @return return value description
 */
+ (XZCustomAlertView *)showSystemAlertViewWithTitle:(NSString *)title
                                            message:(NSString *)message
                                  cancelButtonTitle:(NSString *)cancelTitle
                                   otherButtonTitle:(NSString *)otherTitle
                                  isTouchbackground:(BOOL)isTouchBackground
                                  withAlertViewType:(XZAlertViewType)alertViewType
                                            handler:(void (^)(XZCustomAlertView *alertView, XZAlertViewBtnTag buttonIndex ,XZAlertViewType alertViewType))block
{
    XZCustomAlertView *alert = [[XZCustomAlertView alloc]initSystemAlertViewWithTitle:title
                                                                              message:message
                                                                    cancelButtonTitle:cancelTitle
                                                                     otherButtonTitle:otherTitle
                                                                    isTouchBackground:isTouchBackground
                                                                    withAlertViewType:alertViewType
                                                                              handler:block];
    [alert show];
    return alert;
    
}


///**
// 自定义样式AlertView弹窗  -- 后期拓展
//
// @param imageArray <#imageArray description#>
// @param buttonArray <#buttonArray description#>
// @param statusImage <#statusImage description#>
// @param promptText <#promptText description#>
// @param alertViewType <#alertViewType description#>
// @param block <#block description#>
// @return <#return value description#>
// */
//+ (XZCustomAlertView *)showCustomAlertViewWithImageArray:(NSArray *)imageArray
//                                         withbuttonArray:(NSArray *)buttonArray
//                                         withStatusImage:(UIImage *)statusImage
//                                          withPromptText:(NSString *)promptText
//                                       withAlertViewType:(XZAlertViewType)alertViewType
//                                                 handler:(void (^)(XZCustomAlertView *alertView, NSInteger buttonIndex ,XZAlertViewType alertViewType))block
//{
//    XZCustomAlertView *alert = [[XZCustomAlertView  alloc]initCustomAlertViewWithImageArray:imageArray
//                                                                            withbuttonArray:buttonArray
//                                                                            withStatusImage:statusImage
//                                                                             withPromptText:promptText
//                                                                          withAlertViewType:alertViewType
//                                                                                    handler:block];
//    [alert show];
//    return alert;
//
//}





@end
