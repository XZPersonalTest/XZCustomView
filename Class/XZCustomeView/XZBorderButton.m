//
//  XZBorderButton.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "XZBorderButton.h"
#import "XZMacro.h"

// 边框颜色定义
#define COLOR_BORDER_NORMAL           [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]
#define COLOR_BORDER_HIGHLIGHTED      [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5]
#define COLOR_BORDER_DISABLED         [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5]

// 背景颜色定义
#define COLOR_BACKGROUND_HIGHLIGHTED  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]

@implementation XZBorderButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib {
    [super awakeFromNib];
    self.avtive = YES;
}

- (void)dealloc {
    self.borderStateNormalColor = nil;
    self.borderStateHighlightedColor = nil;
    self.borderStateDisabledColor = nil;
    self.borderStateSelectedColor = nil;
    
    self.backgroundStateNormalColor = nil;
    self.backgroundStateHighlightedColor = nil;
    self.backgroundStateDisabledColor = nil;
    self.backgroundStateSelectedColor = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isNeedBorder == YES)
    {
        [self.layer setMasksToBounds:YES];
        // 边框宽度
        [self.layer setBorderWidth:1.0];
        if (self.borderWidth) {
            [self.layer setBorderWidth:self.borderWidth];
        }
        
        if (self.borderStateNormalColor == nil) {
            self.borderStateNormalColor = COLOR_BORDER_NORMAL;
        }
        
        if (self.borderStateHighlightedColor == nil) {
            self.borderStateHighlightedColor = COLOR_BORDER_HIGHLIGHTED;
        }
        
        if (self.borderStateDisabledColor == nil) {
            self.borderStateDisabledColor = COLOR_BORDER_DISABLED;
        }
        
        if (self.borderStateSelectedColor == nil) {
            self.borderStateSelectedColor = COLOR_BORDER_NORMAL;
        }
    }
    
    // 如果需要圆角
    if (self.isNoNeedCorner == NO)
    {
        if (self.cornerRadius < 0.1) {
            self.cornerRadius = 3.0;
        }
        
        // 设置矩形四个圆角半径
        [self.layer setCornerRadius:self.cornerRadius];
    }
    
    // 默认如果高亮没有背景颜色，则使用白色
    if (self.backgroundStateHighlightedColor == nil) {
        self.backgroundStateHighlightedColor = COLOR_BACKGROUND_HIGHLIGHTED;
    }
    
    switch (self.state) {
        case UIControlStateNormal: // 正常状态
        {
            if (self.isNeedBorder == YES && self.borderStateNormalColor)
            {
                // 边框颜色
                [self.layer setBorderColor:self.borderStateNormalColor.CGColor];
            }
            
            if (self.backgroundStateNormalColor) {
                [self setBackgroundColor:self.backgroundStateNormalColor];
            }
            else {
                [self setBackgroundColor:XZClearColor];
            }
        }
            break;
            
        case UIControlStateHighlighted: // 高亮状态
        {
            if (self.isNeedBorder == YES && self.borderStateHighlightedColor)
            {
                // 边框颜色
                [self.layer setBorderColor:self.borderStateHighlightedColor.CGColor];
            }
            
            if (self.backgroundStateHighlightedColor) {
                [self setBackgroundColor:self.backgroundStateHighlightedColor];
            }
            else {
                [self setBackgroundColor:XZClearColor];
            }
        }
            break;
            
        case UIControlStateDisabled: // 禁用状态
        {
            if (self.isNeedBorder == YES && self.borderStateDisabledColor)
            {
                // 边框颜色
                [self.layer setBorderColor:self.borderStateDisabledColor.CGColor];
            }
            
            if (self.backgroundStateDisabledColor) {
                [self setBackgroundColor:self.backgroundStateDisabledColor];
            }
            else {
                [self setBackgroundColor:XZClearColor];
            }
        }
            break;
            
        case UIControlStateSelected: // 选中状态
        {
            if (self.isNeedBorder == YES && self.borderStateSelectedColor)
            {
                // 边框颜色
                [self.layer setBorderColor:self.borderStateSelectedColor.CGColor];
            }
            
            if (self.backgroundStateSelectedColor) {
                [self setBackgroundColor:self.backgroundStateSelectedColor];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
