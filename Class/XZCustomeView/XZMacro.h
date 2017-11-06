//
//  XZMacro.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#ifndef XZMacro_h
#define XZMacro_h


#pragma mark -- XZColorMacro
/********************************* XZColorMacro ****************************************/

#define RGBHex(rgbValue)         [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF00))/255.0 alpha:1.0]

#define RGBHexA(rgbValue,a)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF00))/255.0 alpha:a]

#define RGB(r, g, b)              [UIColor colorWithRed:(r)/255.0    green:(g)/255.0    blue:(b)/255.0    alpha:1]
#define RGBA(r, g, b, a)          [UIColor colorWithRed:(r)/255.f    green:(g)/255.f    blue:(b)/255.f    alpha:(a)]
#define PureColor(equalValue)     RGB(equalValue,equalValue,equalValue)

#define  XZClearColor             [UIColor clearColor]
#define  WhiteColor                RGB(255,255,255)//#ffffff
#define  BrownColor               [UIColor colorWithRed:170.0/255.0  green: 90.0/255.0  blue: 60.0/255.0  alpha:1]
#define  GreeColor                [UIColor colorWithRed: 87.0/255.0  green:159.0/255.0  blue:179.0/255.0  alpha:1]
#define  BlackColor               [UIColor colorWithRed: 85.0/255.0  green: 85.0/255.0  blue: 85.0/255.0  alpha:1]
#define  BGroundColor             [UIColor colorWithRed:144.0/255.0  green:144.0/255.0  blue:144.0/255.0  alpha:1]
#define  RedColorRF               [UIColor colorWithRed:240.0/255.0  green: 65.0/255.0  blue: 19.0/255.0  alpha:1]
#define  LineColor                [UIColor colorWithRed:224.0/255.0  green: 224.0/255.0 blue: 224.0/255.0 alpha:1]

#define XZMainFrameColor                    RGB(3,169,244)   //RGBHex(0X03a9f4)       //主题色
#define XZDangerousOperationColor           RGB(234, 62, 49)   //RGBHex(0Xea3e31)       //危险操作
#define XZImportantWordsColor               RGB(52,52,52)    //RGBHex(0X343434)         //重要文字
#define XZGeneralWordsColor                 RGB(128,128,128) //RGBHex(0X808080)      //一般文字
#define ReservedWordsColor                  RGB(153, 153, 153) //RGBHex(0X999999)      //预留文字
#define XZSeparationOfContentColor          RGB(221,221,221) //RGBHex(0Xdddddd)      //内容区域上的分割线
#define XZHighLightColor                    RGB(12,130,185)  //RGBHex(0X0c82b9)       //按钮点击时的颜色
 

#define XZSeparationColor                   RGB(229,229,229) //RGBHex(0Xe5e5e5)      //分割线
#define XZBgSeparationColor                 RGB(243,243,243) //RGBHex(0Xf3f3f3)      //部分背景色/分割线 列表间隔距离 白色背景上的分割线
#define XZContentBgColor                    RGB(247,247,247)  //RGBHex(0Xf7f7f7)     //内容区域底色
#define XZEmptyViewTextBgColor              RGB(191,204,225)  //RGBHex(0Xf7f7f7)     //空白页面文字色
#define XZEmptyViewTextLightBgColor         RGB(46,169,242)  //RGBHex(0Xf7f7f7)     //空白页面蓝色文字色


/** 控件颜色*/
#define COLOR_MASKING_VIEW_BACKGROUND    [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6]


/********************************* XZFontMacro ****************************************/

#define XZFont(fontSize) [UIFont systemFontOfSize:fontSize]

#define XZFont_Bold(fontBold) [UIFont boldSystemFontOfSize:fontBold]


#pragma mark -- XZOSMacro
/********************************* XZOSMacro ****************************************/


#define iOSUserDefaults                        [NSUserDefaults standardUserDefaults]
#define iOSFileManager                         [NSFileManager defaultManager]
#define iOSNotificationCenter                  [NSNotificationCenter defaultCenter]



//***********************************Log日志********************************************

#ifdef DEBUG
#define DEBUG_ERROR_ALERT   // Debug模式下使用Debug错误弹出框

#define DebugMode

#define DebugLog(fmt, ...) NSLog((@"DEBUG: ---%s [Line %d]---" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else
#define DebugLog(fmt, ...)
#define NSLog(...)
#endif


//==================================其他================================================
// block弱引用
#define getWeakSelf  __weak typeof (self) weakSelf = self;

#define getStrongSelf  __weak typeof (weakSelf) strongSelf = weakSelf;


#endif /* XZMacro_h */
