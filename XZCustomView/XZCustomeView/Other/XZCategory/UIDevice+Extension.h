//
//  UIDevice+Extension.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * @brief iOS设备硬件类型枚举
 */
typedef NS_ENUM(NSUInteger,HQDeviceType) {
    
    // 未知的设备
    HQDeviceTypeUnknow,  // unknown device
    
    // 模拟器
    HQDeviceTypeSimulator, // on the simulator
    
    // iPod Touch
    HQDeviceTypeiPod1G,  // on iPod Touch
    HQDeviceTypeiPod2G ,  // on iPod Touch Second Generation
    HQDeviceTypeiPod3G,  // on iPod Touch Third Generation
    HQDeviceTypeiPod4G,  // on iPod Touch Fourth Generation
    HQDeviceTypeiPod5G,  // on iPod Touch Five Generation
    
    // iPhone
    HQDeviceTypeiPhone1G,  // on iPhone
    HQDeviceTypeiPhone3G,  // on iPhone 3G
    HQDeviceTypeiPhone3GS, // on iPhone 3GS
    HQDeviceTypeiPhone4,   // on iPhone 4
    HQDeviceTypeiPhone4S,  // on iPhone 4S
    HQDeviceTypeiPhone5,   // on iPhone 5  @"iPhone5,1"-model A1428, AT&T/Canada; @"iPhone5,2"-model A1429
    HQDeviceTypeiPhone5C,  // on iPhone 5C @"iPhone5,3"-iPhone5c-GSM-A1526; @"iPhone5,4"-iPhone5c-CDMA-A1532
    HQDeviceTypeiPhone5S,  // on iPhone 5S @"iPhone6,1"-iPhone5s-GSM-A1528; @"iPhone6,2"-iPhone5s-CDMA-A1533
    HQDeviceTypeiPhone6,   // on iPhone 6
    HQDeviceTypeiPhone6P,  // on iPhone 6 Plus
    HQDeviceTypeiPhone6S,   // on iPhone 6s
    HQDeviceTypeiPhone6SPlus,   // on iPhone 6sp
    HQDeviceTypeiPhone6SE,   // on iPhone 6se
    HQDeviceTypeiPhone7,   // on iPhone 7
    HQDeviceTypeiPhone7Plus,   // on iPhone 7p
    
    // iPad
    HQDeviceTypeiPad1G,   // on iPad 1rd, WiFi and 3G
    HQDeviceTypeiPad2G,   // on iPad 2rd, iPad2,1->WiFi, iPad2,2->GSM 3G, iPad2,3->CDMA 3G
    HQDeviceTypeiPad3G,   // on iPad 3rd, iPad3,1->WiFi, iPad3,2->GSM, iPad3,3->CDMA
    HQDeviceTypeiPad4G,   // on iPad 4th Generation iPad @"iPad3,4"
    HQDeviceTypeiPadMini, // on iPad Mini
};


//typedef NS_ENUM(NSUInteger,HQOSVersion) {
//    
//    // 不包括7
//    HQOSVersionOS7Earlier,
//    HQOSVersionOS8Earlier,
//    HQOSVersionOS9Earlier,
//    HQOSVersionOS10Earlier,
//    HQOSVersionOS11Earlier,
//    
//    HQOSVersionOSUnKnown,
//    
//};


@interface UIDevice (Extension)

#pragma mark - 设备信息

/**
 设备名字: iPhone6/iPadMini
 */
+ (NSString *)deviceName;

/**
设备型号枚举值
 */
+ (HQDeviceType)deviceType;
/**
 *  判断是否为小屏手机
 */
+ (BOOL)deviceIsSmallOne;
// 判断是否为iphone4或以下系列设备
+ (BOOL)deviceIsIphone4;
// 判断是否为iphone5系列设备
+ (BOOL)deviceIsIphone5;
// 判断是否为iphone6或iphone7小屏系列设备
+ (BOOL)deviceIsIphone6Or7;
// 判断是否为iphone6Plus或iphone7Plus大屏系列设备
+ (BOOL)deviceIsIphone6pOr7p;


/**
 是否是iPhone设备
 */
+ (BOOL)iPhone;

#pragma mark - 系统版本
/**
 返回iOS系统的主版本(4/5/6)
 */
+ (NSInteger)iOSMajorVersion;

/**
 返回iOS系统的全版本号(如：6.1.4)
 */
+ (NSString *)iOSDetailVersion;

/**
 *  判断是否为iosXXX之前的版本
 */
//+ (HQOSVersion)iOSVersionJudge;

/**
 当前系统版本是否大于某个版本
 
 @param version 对比的系统版本
 @return 是大于吗???
 */
+ (BOOL)iOSVersionLargeThan:(NSUInteger)version;

/**
 当前系统版本是否小于某个版本
 
 @param version 对比的系统版本
 @return 是小于吗???
 */
+ (BOOL)iOSVersionLessThan:(NSUInteger)version;


/*
 *  判断是否为ios7之前的版本
 */
//+ (BOOL)iSiOS7Earlier;

/*
 *  判断是否为ios8之前的版本
 */
//+ (BOOL)iSiOS8Earlier;

/*
 *  判断是否为ios9之前的版本
 */
//+ (BOOL)iSiOS9Earlier;



/* Get Local iOS language
 zh-Hans = 简体中文
 zh-Hant = 繁体中文
 en = 英文（其他国家默认语言）
 ja = 日语
 ar = 阿拉伯语言
 */
+ (NSString *)getLocaliOSLanguage;





@end
