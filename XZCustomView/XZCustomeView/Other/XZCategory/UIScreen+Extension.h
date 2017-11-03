//
//  UIScreen+Extension.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Extension)


+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGRect)bounds;

+ (CGSize)size;

+ (CGFloat)scale;

+ (BOOL)isRetina;

+ (BOOL)isIPAD;

+ (BOOL)isIPHONE;



@end
