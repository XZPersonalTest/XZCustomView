//
//  XZPickerViewModel.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface XZPickerViewModel : NSObject

/** 选择的文字名 必填 */
@property (nonatomic, copy) NSString * pickerName;

/** 选择的code值  非必填，根据自己项目实际情况而定，如果填了，当选择某个选项的时候，会将这个code值一同返回出去，以便于您的使用 */
@property (nonatomic, copy) NSString * pickerCode;


@end


