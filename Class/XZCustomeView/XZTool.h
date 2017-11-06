//
//  XZTool.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZEnum.h"
#import "XZConst.h"
#import "Singleton.h"
#import "XZMacro.h"

#import "UIScreen+Extension.h"
#import "UIImage+Extension.h"
#import "UIDevice+Extension.h"

#import "XZBorderButton.h"

@interface XZTool : NSObject


// 设置自定义button
+ (void)setBorderColorAndBlueBackGroundColorFor:(XZBorderButton *) button;

// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font;
// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;
// 获取富文本字符串的长度
+ (CGSize)getSizeFromAttributeString:(NSAttributedString *)attributeString constrainedToSize:(CGSize)maxSize;

//去掉半角空格
+ (NSString *)removeHalfSpace:(NSString *)str;




@end
