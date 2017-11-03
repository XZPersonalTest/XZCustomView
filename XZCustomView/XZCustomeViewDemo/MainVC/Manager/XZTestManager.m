//
//  XZTestManager.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "XZTestManager.h"

@implementation XZTestManager



/**
 获取数据
 
 XZCustomViewTypeWaitingMaskView                      = 1,     // 等待提示框
 XZCustomViewTypeAlertView                            = 2,     // 警告视图提示框
 XZCustomViewTypeActionSheetView                      = 3,     // 动作表单视图
 XZCustomViewTypePickerView                           = 4,     // 选择视图
 
 @return 数据Model数组
 */
+ (NSMutableArray *)loadDataWithCustomViewType:(XZCustomViewType)customViewType
{
    
    NSMutableArray *mutArr = [NSMutableArray new];
    
    switch (customViewType) {
        case XZCustomViewTypeWaitingMaskView:
        {
            NSArray *arr = @[@"自适应文字+菊花等待窗类型", @"固定文字大小+菊花等待窗类型", @"循环Icon图标形成的等待界面", @"自动隐藏提示框", @"纯文字提醒"];
            
            for (int i = 0; i < arr.count; i ++) {
                
                XZTestModel *model = [[XZTestModel alloc] init];
                model.title = arr[i];
                model.customViewWaitingType = i + 1;
                
                [mutArr addObject:model];
            }
            
            
        }
            break;
        case XZCustomViewTypeAlertView:
        {
            NSArray *arr = @[@"系统文字alertView样式单按钮提示窗", @"系统文字alertView样式双按钮提示窗", @"系统alertView样式提示窗，有输入框", @"验证手机号弹窗"];
            
            for (int i = 0; i < arr.count; i ++) {
                
                XZTestModel *model = [[XZTestModel alloc] init];
                model.title = arr[i];
                model.customViewAlertViewType = i + 1;
                
                [mutArr addObject:model];
            }
            
            
        }
            break;
            
        default:
        {
            
            NSArray *arr = @[@"加载等待系列", @"警告提示系列", @"表单视图系列", @"选择卡视图系列"];
            
            for (int i = 0; i < arr.count; i ++) {
                
                XZTestModel *model = [[XZTestModel alloc] init];
                model.title = arr[i];
                model.customViewType = i + 1;
                
                [mutArr addObject:model];
            }
            
        }
            break;
    }
    
    return mutArr;
}



@end
