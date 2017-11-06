//
//  UIImage+Extension.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 根据颜色生成纯色的图片
 
 @param color 颜色
 @param size 大小
 @return 生成的image
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
    
@end
