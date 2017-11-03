# XZCustomView
**这是一个简单易用的弹窗小工具，集成了菊花转+文字，图片+文字等类型的等待窗、图片+文字类型的自动隐藏弹窗、自定义AlertView、PickView、SheetView等多种弹窗，满足你多方面需求**

## 文件结构：
**class文件夹下包括XZCustomeView文件夹及XZCustomeViewDemo文件夹，XZCustomeViewDemo文件夹为demo演示文件，XZCustomeView文件夹内为功能文件**

## 使用方法：
    1.将XZCustomeView整个文件夹导入您的项目中
    2.在AppDelegate文件中导入 #import "XZCustomWindowManager.h" 头文件
    3.在程序启动方法里创建CustomView管理类：[XZCustomWindowManager shareManager].defuatSuperView = self.window;
```
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        // Override point for customization after application launch.

        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

        XZTestVC *testVC = [[XZTestVC alloc] init];

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:testVC];

        self.window.rootViewController = nav;

        [XZCustomWindowManager shareManager].defuatSuperView = self.window;

        [self.window makeKeyAndVisible];

        return YES;

    }
```
    4.在需要使用弹窗的界面导入头文件：#import "XZHeader.h"
    5.等待提示框的使用
        * 自适应文字高度+菊花等待窗类型
```
        // 显示等待窗 此处的图标如果不传，则自动显示为菊花转
        [XZCustomWaitingView showAdaptiveWaitingMaskView:@"努力加载中敬请期待..." iconName:@"XZ_mei_tuan" iconNumber:4];
        
        // 隐藏等待窗
        [XZCustomWaitingView hideWaitingMaskView];
```
![image](https://github.com/XZPersonalTest/Resources/blob/master/XZCustomView/waiting01.gif)


        * 固定文字高度+菊花等待窗类型
```
        // 显示等待窗 此处的图标如果不传，则自动显示为菊花转
        [XZCustomWaitingView showWaitingMaskView:@"努力加载中..." iconName:@"XZ_mei_tuan" iconNumber:4];
        
        // 隐藏等待窗
        [XZCustomWaitingView hideWaitingMaskView];
```
![image](https://github.com/XZPersonalTest/Resources/blob/master/XZCustomView/waiting02.gif)

        * 循环Icon图标形成的等待界面
```
    // 显示等待窗 此处的图标名字必传
    [XZCustomWaitingView showIconWaitingMaskViewWithIcon:@"XZ_loading" iconNumber:11];

    // 隐藏等待窗 后边传入的BOOL值，YES代表延迟0.5秒后移除等待界面，NO：为立即移除等待界面
    [XZCustomWaitingView hideIconWaitingMaskView:YES];
```
![image](https://github.com/XZPersonalTest/Resources/blob/master/XZCustomView/waiting03.gif)

        * 自动隐藏提示框
```
    // 没有block回调 此处的图片如果不传，则显示为纯文字， showTime：弹窗显示时间
    [XZCustomWaitingView showAutoHidePromptView:@"我是会消失的" background:[UIImage imageNamed:@"XZ_no_net"] showTime:1];

    // 有block回调，窗口隐藏后有回调的 此处的图片如果不传，则显示为纯文字， showTime：弹窗显示时间
    [XZCustomWaitingView showAutoHidePromptView:@"我是会消失的" background:[UIImage imageNamed:@"XZ_maintenance"] showTime:1 completion:^{

        DebugLog(@"提示框消失后，你要做些什么呢？？？");
    }];
```
![image](https://github.com/XZPersonalTest/Resources/blob/master/XZCustomView/waiting04.gif)

![image](https://github.com/XZPersonalTest/Resources/blob/master/XZCustomView/waiting05.gif)






















