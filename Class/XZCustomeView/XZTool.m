//
//  XZTool.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "XZTool.h"

@implementation XZTool

// 设置自定义button
+ (void)setBorderColorAndBlueBackGroundColorFor:(XZBorderButton *) button
{
    // 需要边框
    button.isNeedBorder = NO;
    // 按钮正常时颜色
    button.backgroundStateNormalColor = RGB(3, 169, 244);
    // 按钮高亮时颜色
    button.backgroundStateHighlightedColor = RGB(6, 140, 210);
    // 按钮不可点击时颜色
    button.backgroundStateDisabledColor = RGB(204, 204, 204);
    // 边框正常时的颜色
    button.borderStateNormalColor = [UIColor whiteColor];
    // 边框高亮时的颜色
    button.borderStateHighlightedColor = [UIColor yellowColor];
}



// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font
{
    if (stringText == nil || font == nil)
    {
        return CGSizeZero;
    }
    CGSize size = CGSizeZero;
    
    if ([stringText respondsToSelector:@selector(sizeWithAttributes:)])
    {
        size = [stringText sizeWithAttributes:[NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName]];
    }
    return size;
}

// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font constrainedToSize:(CGSize)maxSize
{
    if (stringText == nil || font == nil)
    {
        return CGSizeZero;
    }
    CGSize size = CGSizeZero;
    
    if ([stringText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        CGRect rect = [stringText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName] context:nil];
        size = CGSizeMake(rect.size.width, rect.size.height);
    }
    
    return size;
}

// 获取富文本字符串的长度
+ (CGSize)getSizeFromAttributeString:(NSAttributedString *)attributeString constrainedToSize:(CGSize)maxSize
{
    if (attributeString == nil)
    {
        return CGSizeZero;
    }
    CGSize size = CGSizeZero;
    
    if ([attributeString respondsToSelector:@selector(boundingRectWithSize:options:context:)])
    {
        size = [attributeString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
    }
    
    return size;
}


//去掉半角空格
+ (NSString *)removeHalfSpace:(NSString *)str
{
    NSString *sapceStr = [self replaceUnicode:[NSString stringWithFormat:@"%@",@"\\u0020"]];
    str = [str stringByReplacingOccurrencesOfString:sapceStr withString:@""];
    return str;
}

//Unicode码转NSString
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
//                                                           mutabilityOption:NSPropertyListImmutable
//                                                                     format:NULL
//                                                           errorDescription:NULL];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData
                                                                    options:NSPropertyListImmutable
                                                                     format:NULL
                                                                      error:NULL];
    
    //NSLog(@"Output = %@", returnStr);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}



@end
