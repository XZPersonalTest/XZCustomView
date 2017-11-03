//
//  UIDevice+Extension.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "UIDevice+Extension.h"
#import <sys/utsname.h>


NSString *const HQDeviceNameiPhone          = @"iPhone";
NSString *const HQDeviceNameiPhone3G        = @"iPhone3G";
NSString *const HQDeviceNameiPhone3GS       = @"iPhone3GS";
NSString *const HQDeviceNameiPhone4         = @"iPhone4";
NSString *const HQDeviceNameiPhone4S        = @"iPhone4S";
NSString *const HQDeviceNameiPhone5         = @"iPhone5";
NSString *const HQDeviceNameiPhone5C        = @"iPhone5C";
NSString *const HQDeviceNameiPhone5S        = @"iPhone5S";
NSString *const HQDeviceNameiPhone6Plus     = @"iPhone6 Plus";
NSString *const HQDeviceNameiPhone6         = @"iPhone6";
NSString *const HQDeviceNameiPhone6S        = @"iPhone6S";
NSString *const HQDeviceNameiPhone6SPlus    = @"iPhone6SPlus";
NSString *const HQDeviceNameiPhone6SE       = @"iPhone6SE";
NSString *const HQDeviceNameiPhone7         = @"iPhone7";
NSString *const HQDeviceNameiPhone7Plus     = @"iPhone7Plus";
NSString *const HQDeviceNameiPad1           = @"iPad1";
NSString *const HQDeviceNameiPad2           = @"iPad2";
NSString *const HQDeviceNameiPad3           = @"iPad3";
NSString *const HQDeviceNameiPad4           = @"iPad4";
NSString *const HQDeviceNameiPadMini        = @"iPadMini";
NSString *const HQDeviceNameiPod1           = @"iPod1";
NSString *const HQDeviceNameiPod2           = @"iPod2";
NSString *const HQDeviceNameiPod3           = @"iPod3";
NSString *const HQDeviceNameiPod4           = @"iPod4";
NSString *const HQDeviceNameiPod5           = @"iPod5";
NSString *const HQDeviceNameSimulator       = @"ios simulator";

@implementation UIDevice (Extension)

//
+ (NSString *)deviceName
{
    // 获取设备信息
    struct utsname systemInfo = {0};
    uname(&systemInfo);
    
    NSString * strMachine = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString * strMachineType = nil;
    
    // 判断设备类型
    if ([strMachine hasPrefix:@"iPhone1,1"]) {
        strMachineType = HQDeviceNameiPhone;
    }
    else if ([strMachine hasPrefix:@"iPhone1,2"])
    {
        strMachineType = HQDeviceNameiPhone3G;
    }
    else if ([strMachine hasPrefix:@"iPhone2,1"])
    {
        strMachineType = HQDeviceNameiPhone3GS;
    }
    else if ([strMachine hasPrefix:@"iPhone3"])
    {
        strMachineType = HQDeviceNameiPhone4;
    }
    else if ([strMachine hasPrefix:@"iPhone4"])
    {
        strMachineType = HQDeviceNameiPhone4S;
    }
    else if ([strMachine hasPrefix:@"iPhone5,1"] ||
             [strMachine hasPrefix:@"iPhone5,2"])
    {
        strMachineType = HQDeviceNameiPhone5;
    }
    else if ([strMachine hasPrefix:@"iPhone5,3"] ||
             [strMachine hasPrefix:@"iPhone5,4"])
    {
        strMachineType = HQDeviceNameiPhone5C;
    }
    else if ([strMachine hasPrefix:@"iPhone6,1"] ||
             [strMachine hasPrefix:@"iPhone6,2"])
    {
        strMachineType = HQDeviceNameiPhone5S;
    }
    else if ([strMachine hasPrefix:@"iPhone7,1"])
    {
        strMachineType = HQDeviceNameiPhone6Plus;
    }
    else if ([strMachine hasPrefix:@"iPhone7,2"])
    {
        strMachineType = HQDeviceNameiPhone6;
    }
    
    else if ([strMachine isEqualToString:@"iPhone8,1"])
    {
        strMachineType = HQDeviceNameiPhone6S;
    }
    else if ([strMachine isEqualToString:@"iPhone8,2"])
    {
        strMachineType = HQDeviceNameiPhone6SPlus;
    }
    else if ([strMachine isEqualToString:@"iPhone8,4"])
    {
        strMachineType = HQDeviceNameiPhone6SE;
    }
    else if ([strMachine isEqualToString:@"iPhone9,1"])
    {
        strMachineType = HQDeviceNameiPhone7;
    }
    else if ([strMachineType isEqualToString:@"iPhone9,2"])
    {
        strMachineType = HQDeviceNameiPhone7Plus;
    }
    else if ([strMachine hasPrefix:@"iPad1"])
    {
        strMachineType = HQDeviceNameiPad1;
    }
    else if ([strMachine hasPrefix:@"iPad2"])
    {
        strMachineType = HQDeviceNameiPad2;
    }
    else if ([strMachine isEqualToString:@"iPad3,1"] ||
             [strMachine isEqualToString:@"iPad3,2"] ||
             [strMachine isEqualToString:@"iPad3,3"])
    {
        strMachineType = HQDeviceNameiPad3;
    }
    else if ([strMachine hasPrefix:@"iPad3,4"])
    {
        strMachineType = HQDeviceNameiPad4;
    }
    else if ([strMachine hasPrefix:@"iPad2,5"])
    {
        strMachineType = HQDeviceNameiPadMini;
    }
    else if ([strMachine hasPrefix:@"iPod1,1"])
    {
        strMachineType = HQDeviceNameiPod1;
    }
    else if ([strMachine hasPrefix:@"iPod2,1"])
    {
        strMachineType = HQDeviceNameiPod2;
    }
    else if ([strMachine hasPrefix:@"iPod3,1"])
    {
        strMachineType = HQDeviceNameiPod3;
    }
    else if ([strMachine hasPrefix:@"iPod4,1"])
    {
        strMachineType = HQDeviceNameiPod4;
    }
    else if ([strMachine hasPrefix:@"iPod5,1"])
    {
        strMachineType = HQDeviceNameiPod5;
    }
    else if ([strMachine hasSuffix:@"86"] || [strMachine isEqual:@"x86_64"])
    {
        strMachineType = HQDeviceNameSimulator;
    }
    
    NSLog(@"TOOLS: iOSMachineHardwareType - strMachine = %@, strMachineType = %@", strMachine, strMachineType);
    
    return strMachineType;
}


// 获取iOS设备硬件类型，返回枚举型（iPhone3GS、iPhone4、iPhone4S、iPhone5）
+ (HQDeviceType)deviceType
{
    // 获取设备信息
    NSString * strMachineType = [self deviceName];
    
    HQDeviceType deviceType = HQDeviceTypeUnknow;
    // 判断设备类型
    if ([strMachineType isEqualToString:HQDeviceNameiPhone]) {
        deviceType = HQDeviceTypeiPhone1G;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone3G])
    {
        deviceType = HQDeviceTypeiPhone3G;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone3GS])
    {
        deviceType = HQDeviceTypeiPhone3GS;

    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone4])
    {
        deviceType = HQDeviceTypeiPhone4;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone4S])
    {
        deviceType = HQDeviceTypeiPhone4S;

    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone5])
    {
        deviceType = HQDeviceTypeiPhone5;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone5C])
    {
        deviceType = HQDeviceTypeiPhone5C;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone5S] )
    {
        deviceType = HQDeviceTypeiPhone5S;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone6Plus])
    {
        deviceType = HQDeviceTypeiPhone6P;

    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone6])
    {
        deviceType = HQDeviceTypeiPhone6;  

    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone6S])
    {
        deviceType = HQDeviceTypeiPhone6S;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone6SPlus])
    {
        deviceType = HQDeviceTypeiPhone6SPlus;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone6SE])
    {
        deviceType = HQDeviceTypeiPhone6SE;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone7])
    {
        deviceType = HQDeviceTypeiPhone7;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPhone7Plus])
    {
        deviceType = HQDeviceTypeiPhone7Plus;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPad1])
    {
        deviceType = HQDeviceTypeiPad1G;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPad2])
    {
        deviceType = HQDeviceTypeiPad2G;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPad3])
    {
        deviceType = HQDeviceTypeiPad3G;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPad4])
    {
        deviceType = HQDeviceTypeiPad4G;
    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPadMini])
    {
        deviceType = HQDeviceTypeiPadMini;

    }
    else if ([strMachineType isEqualToString:HQDeviceNameiPod1])
    {
        deviceType = HQDeviceTypeiPod1G;

    }
    else if ([strMachineType hasPrefix:HQDeviceNameiPod2])
    {
        deviceType = HQDeviceTypeiPod2G;

    }
    else if ([strMachineType hasPrefix:HQDeviceNameiPod3])
    {
        deviceType = HQDeviceTypeiPod3G;
    }
    else if ([strMachineType hasPrefix:HQDeviceNameiPod4])
    {
        deviceType = HQDeviceTypeiPod4G;
    }
    else if ([strMachineType hasPrefix:HQDeviceNameiPod5])
    {
        deviceType = HQDeviceTypeiPod5G;
    }
    else if ([strMachineType hasSuffix:HQDeviceNameSimulator])
    {
        deviceType = HQDeviceTypeSimulator;
    }
    
    
    return deviceType;
}




// 判断是否为小屏手机
+ (BOOL)deviceIsSmallOne
{
    BOOL isSmallDevice = NO;
    switch ([UIDevice deviceType]) {
        case HQDeviceTypeiPhone1G:
        case HQDeviceTypeiPhone3G:  // on iPhone 3G
        case HQDeviceTypeiPhone3GS: // on iPhone 3GS
        case HQDeviceTypeiPhone4:   // on iPhone 4
        case HQDeviceTypeiPhone4S:  // on iPhone 4S
        case HQDeviceTypeiPhone5:   // on iPhone 5  @"iPhone5,1"-model A1428, AT&T/Canada; @"iPhone5,2"-model A1429
        case HQDeviceTypeiPhone5C: // on iPhone 5C @"iPhone5,3"-iPhone5c-GSM-A1526; @"iPhone5,4"-iPhone5c-CDMA-A1532
        case HQDeviceTypeiPhone5S:  // on iPhone 5S @"iPhone:
        {
            isSmallDevice = YES;
        }
            break;
            
        default:
            break;
    }
    
    return isSmallDevice;
}

// 判断是否为iphone4或以下系列设备
+ (BOOL)deviceIsIphone4
{
    BOOL isSmallDevice = NO;
    switch ([UIDevice deviceType]) {
        case HQDeviceTypeiPhone1G:
        case HQDeviceTypeiPhone3G:  // on iPhone 3G
        case HQDeviceTypeiPhone3GS: // on iPhone 3GS
        case HQDeviceTypeiPhone4:   // on iPhone 4
        case HQDeviceTypeiPhone4S:  // on iPhone 4S
        {
            isSmallDevice = YES;
        }
            break;
            
        default:
            break;
    }
    
    return isSmallDevice;
}

// 判断是否为iphone5系列设备
+ (BOOL)deviceIsIphone5
{
    BOOL isSmallDevice = NO;
    switch ([UIDevice deviceType]) {
        case HQDeviceTypeiPhone5:   // on iPhone 5  @"iPhone5,1"-model A1428, AT&T/Canada; @"iPhone5,2"-model A1429
        case HQDeviceTypeiPhone5C: // on iPhone 5C @"iPhone5,3"-iPhone5c-GSM-A1526; @"iPhone5,4"-iPhone5c-CDMA-A1532
        case HQDeviceTypeiPhone5S:  // on iPhone 5S @"iPhone:
        {
            isSmallDevice = YES;
        }
            break;
            
        default:
            break;
    }
    
    return isSmallDevice;
}


// 判断是否为iphone6或iphone7小屏系列设备
+ (BOOL)deviceIsIphone6Or7
{
    BOOL isSmallDevice = NO;
    switch ([UIDevice deviceType]) {
        case HQDeviceTypeiPhone6:   // on iPhone 6
        case HQDeviceTypeiPhone6S: // on iPhone 6s
        case HQDeviceTypeiPhone6SE:  // on iPhone 6se
        case HQDeviceTypeiPhone7:   // on iPhone 7
        {
            isSmallDevice = YES;
        }
            break;
            
        default:
            break;
    }
    
    return isSmallDevice;
}


// 判断是否为iphone6Plus或iphone7Plus大屏系列设备
+ (BOOL)deviceIsIphone6pOr7p
{
    BOOL isSmallDevice = NO;
    switch ([UIDevice deviceType]) {
        case HQDeviceTypeiPhone6P:   // on iPhone 6 Plus
        case HQDeviceTypeiPhone6SPlus: // on iPhone 6sp
        case HQDeviceTypeiPhone7Plus:  // on iPhone 6se
        {
            isSmallDevice = YES;
        }
            break;
            
        default:
            break;
    }
    
    return isSmallDevice;
}


// 是否是iPhone设备
+ (BOOL)iPhone
{
    // 获取设备信息
    UIDevice* deviceInfo = [UIDevice currentDevice];
    
    return [deviceInfo.model isEqualToString:@"iPhone"];
}


#pragma mark - 系统版本
/**
 返回iOS系统的主版本(4/5/6)
 */
+ (NSInteger)iOSMajorVersion
{
    NSInteger nMaxVersion =  [[[[self iOSDetailVersion] componentsSeparatedByString:@"."] firstObject] integerValue];
    
    return nMaxVersion;
}


// 返回iOS系统的全版本号(如：6.1.4)
+ (NSString *)iOSDetailVersion
{
    
//    NSInteger version = -1;
//    
//    if ([self iOS8Earlier]) {
//        // 获取设备信息
//        UIDevice* deviceInfo = [UIDevice currentDevice];
//        //NSLog(@"TOOLS: getCurrentiOSMajorVersion = %@", deviceInfo.systemVersion);
//        
//        // systemVersion方法ios8后就失效了,需要使用NSProcessInfo方法,
//        version = [deviceInfo.systemVersion integerValue]; // 7.1.1/7-1-1
//    }else{
//        
//        // FIXME:这个方法不能适配7系统 只能是8以后的系统可以用
//        version = [NSProcessInfo processInfo].operatingSystemVersion.majorVersion;
//        
//    }
    
    // 这个方法现在是任何版本通用的
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    
    return phoneVersion;
}



/**
 *  判断是否为iosXXX之前的版本
 */
//+ (HQOSVersion)iOSVersionJudge
//{
//    
//    double versionNumber = floor(NSFoundationVersionNumber);
//    
//    if (versionNumber < NSFoundationVersionNumber_iOS_6_1) {
//        return HQOSVersionOS7Earlier; // 不包括7
//    }else if(versionNumber < NSFoundationVersionNumber_iOS_8_0){
//        return HQOSVersionOS8Earlier;
//    }else if(versionNumber <= NSFoundationVersionNumber_iOS_8_4){
//        return HQOSVersionOS9Earlier;
//    }else if(versionNumber <= NSFoundationVersionNumber_iOS_9_x_Max){
//        return HQOSVersionOS10Earlier;
//    }
//    else if (versionNumber > NSFoundationVersionNumber_iOS_9_x_Max)
//    {
//        return HQOSVersionOS11Earlier;
//        
//    }
//    else
//    {
//        return HQOSVersionOSUnKnown;
//        
//    }
//}


/**
 当前系统版本是否大于某个版本

 @param version 对比的系统版本
 @return 是大于吗???
 */
+ (BOOL)iOSVersionLargeThan:(NSUInteger)version
{

    NSAssert(version >= 7, @"请填写有效版本,系统适配版本为>=7");
    
    return [self iOSMajorVersion] > version;
    
}

/**
 当前系统版本是否小于某个版本
 
 @param version 对比的系统版本
 @return 是小于吗???
 */
+ (BOOL)iOSVersionLessThan:(NSUInteger)version
{
    NSAssert(version >= 7, @"请填写有效版本,系统适配版本为>=7");
    
    return [self iOSMajorVersion] < version;
}


/*
 *  判断是否为ios7之前的版本
 */
//+ (BOOL)iSiOS7Earlier
//{
//    
//    return floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1;
//}


/*
 *  判断是否为ios8之前的版本
 */
//+ (BOOL)iSiOS8Earlier
//{
//    // UIDevice方法效率低,苹果官方建议使用宏定义
//    //    UIDevice *device = [UIDevice currentDevice];
//    //    float sysVersion = [device.systemVersion floatValue];
//    //
//    //    if (sysVersion < 8.0f) {
//    //        return YES;
//    //    }
//    
//    //    if ([NSProcessInfo.processInfo isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){7,1,0}]) {
//    //        NSLog(@"Hello from > iOS 7.1");
//    //    }
//    
//    return floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_8_0;
//}

/*
 *  判断是否为ios9之前的版本
 */
//+ (BOOL)iSiOS9Earlier
//{
//    
//    return floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_8_4;
//}


/* Get Local iOS language
 zh-Hans = 简体中文
 zh-Hant = 繁体中文
 en = 英文（其他国家默认语言）
 ja = 日语
 ar = 阿拉伯语言
 */
+ (NSString *)getLocaliOSLanguage
{
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *systemlanguage = nil;
    
    if (languages)
    {
        systemlanguage = [languages objectAtIndex:0];
    }
    
    return systemlanguage;
}



@end
