//
//  Singleton.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

// 这里宏定义了interface内容
#define interfaceSingleton(name) + (instancetype)share##name;
// 这里宏定义implementation内容
#define implementationSingleton(name) \
static id _instance; \
+ (instancetype)share##name \
{ \
if (_instance == nil) { \
_instance = [[self alloc] init]; \
} \
return _instance; \
} \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}


#endif /* Singleton_h */
