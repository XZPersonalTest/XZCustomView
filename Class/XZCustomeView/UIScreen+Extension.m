//
//  UIScreen+Extension.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "UIScreen+Extension.h"

@implementation UIScreen (Extension)

+ (CGFloat)screenWidth
{
    return [self size].width;

}
+ (CGFloat)screenHeight
{
    
    return [self size].height;

}
+ (CGRect)bounds
{
    return [UIScreen mainScreen].bounds;
}
+ (CGSize)size
{
    return [self bounds].size;
}
+ (CGFloat)scale
{
    return [UIScreen mainScreen].scale;
}

+ (BOOL)isRetina
{
    return [[UIScreen mainScreen] scale] >= 2.0 ? YES:NO;
}
+ (BOOL)isIPAD
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES:NO;
}
+ (BOOL)isIPHONE
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone?YES:NO;
}
@end
