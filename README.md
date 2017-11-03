# XZCustomView
这是一个简单易用的弹窗小工具，集成了菊花转+文字，图片+文字等类型的等待窗、图片+文字类型的自动隐藏弹窗、自定义AlertView、PickView、SheetView等多种弹窗，满足你多方面需求

文件结构：class文件夹下包括XZCustomeView文件夹及XZCustomeViewDemo文件夹，XZCustomeViewDemo文件夹为demo演示文件，XZCustomeView文件夹内为功能文件

使用方法：
1.将XZCustomeView整个文件夹导入您的项目中
2.在AppDelegate文件中导入 #import "XZCustomWindowManager.h" 头文件
3.在程序启动方法里创建CustomView管理类：[XZCustomWindowManager shareManager].defuatSuperView = self.window;
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


    


![image](https://github.com/XZPersonalTest/Resources/blob/master/XZCustomView/waiting01.gif)

