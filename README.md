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
![image](https://github.com/XZPersonalTest/Resources/blob/master/XZCustomView/waiting04.gif) ![image](https://github.com/XZPersonalTest/Resources/blob/master/XZCustomView/waiting05.gif)

    6.警告视图提示框
        * 系统文字alertView样式提示窗一个按钮
```
    /**
    系统样式AlertView弹窗

    @param title 弹窗标题
    @param message 弹窗提示内容  如果为带有输入框的弹窗，不需要输入提示内容
    @param cancelTitle 取消按钮标题
    @param otherTitle 其他按钮标题 不填则显示为一个按钮
    @param isTouchBackground 是否需要开启点击背景移除弹窗功能
    @param alertViewType 弹窗类型
        /**< 0:系统文字alertView样式提示窗 */
        XZAlertViewTypeSystemAlert                            = 0,
        /**< 1:系统alertView样式提示窗，有输入框 */
        XZAlertViewTypeSystemInputAlert                       = 1,
        /**< 2:验证手机号弹窗 */
        XZAlertViewTypeVerifyPhoneNumber                      = 2,
    @param block 点击按钮后的block回调
    @return XZCustomAlertView
    */
    [XZCustomViewManager showSystemAlertViewWithTitle:@"提示"
                                              message:@"好吧，提示吧"
                                    cancelButtonTitle:@"取消"
                                     otherButtonTitle:@"好吧"
                                    isTouchbackground:YES
                                    withAlertViewType:XZAlertViewTypeSystemAlert
                                              handler:^(XZCustomAlertView *alertView, XZAlertViewBtnTag buttonIndex, XZAlertViewType alertViewType)
    {
        /** 点击背景tag值 */
        XZAlertViewBtnTagBgCancel                            = -1,
        /** 取消按钮tag值 */
        XZAlertViewBtnTagCancel                              = 1000,
        /** 确认按钮tag值 */
        XZAlertViewBtnTagSure                                = 1001,
        /** 获取验证码按钮tag值 */
        XZAlertViewBtnTagVerificationCode                    = 1002,

        switch (buttonIndex) {
            case XZAlertViewBtnTagBgCancel:
            {

                DebugLog(@"您好像点击了背景");
            }
                break;
            case XZAlertViewBtnTagCancel:
            {

                DebugLog(@"您好像点击了取消按钮");
            }
                break;
            case XZAlertViewBtnTagSure:
            {

                DebugLog(@"您好像点击了好吧按钮");
            }
                break;

            default:
                break;
        }

    }];
```
        * 系统alertView样式提示窗，有输入框
```
    getWeakSelf
    XZCustomAlertView *alertView = [XZCustomViewManager showSystemAlertViewWithTitle:@"输入个什么吧"
                                                                             message:nil
                                                                   cancelButtonTitle:@"坚决不输入"
                                                                    otherButtonTitle:@"好吧"
                                                                   isTouchbackground:YES
                                                                   withAlertViewType:XZAlertViewTypeSystemInputAlert
                                                                             handler:^(XZCustomAlertView *alertView, XZAlertViewBtnTag buttonIndex, XZAlertViewType alertViewType)
    {

        switch (buttonIndex) {
            case XZAlertViewBtnTagBgCancel:
            {

                DebugLog(@"您好像点击了背景");
            }
                break;
            case XZAlertViewBtnTagCancel:
            {

                DebugLog(@"您好像点击了坚决不输入按钮");
            }
                break;
            case XZAlertViewBtnTagSure:
            {

                DebugLog(@"您好像点击了好吧按钮");
            }
                break;

            default:
                break;
        }

        DebugLog(@"+++++++系统alertView样式提示窗输入框%@",self.systemTextFieldStr);

    }];

    // textField输入完成回调方法
    [alertView setTextFieldChangeHandler:^(UITextField *textField) {
        [weakSelf textFieldChange:textField];
    }];

    // textField变化回调方法
    [alertView setTextFieldShoudChangeHandler:^(UITextField *textField, NSRange range, NSString *string)
    {
        return [weakSelf textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }];
    
```
        * 验证手机号弹窗 
```
    XZCustomAlertView *alertView = [XZCustomViewManager showSystemAlertViewWithTitle:@"验证您的手机号"
                                                                             message:nil
                                                                   cancelButtonTitle:nil
                                                                    otherButtonTitle:nil
                                                                   isTouchbackground:NO
                                                                   withAlertViewType:XZAlertViewTypeVerifyPhoneNumber
                                                                             handler:^(XZCustomAlertView *alertView, XZAlertViewBtnTag buttonIndex, XZAlertViewType alertViewType)
    {

        switch (buttonIndex) {
            case XZAlertViewBtnTagBgCancel:
            {

                DebugLog(@"您好像点击了背景");
            }
                break;
            case XZAlertViewBtnTagCancel:
            {

                DebugLog(@"您好像点击了取消按钮");
            }
                break;
            case XZAlertViewBtnTagSure:
            {

                DebugLog(@"您好像点击了确定按钮");
            }
                break;
            case XZAlertViewBtnTagVerificationCode:
            {

                DebugLog(@"您好像点击了获取验证码按钮");
            }
                break;

            default:
                break;
        }

        DebugLog(@"+++++++您输入的手机号是%@",self.phoneNumberStr);
        DebugLog(@"+++++++您输入的验证码是%@",self.verificationCodeStr);

    }];

    [alertView setTextFieldChangeHandler:^(UITextField *textField) {
        // 判断字符长度
        [weakSelf textFieldChange:textField];
    }];

    [alertView setTextFieldShoudChangeHandler:^(UITextField *textField, NSRange range, NSString *string)
    {
        // 判断表情
        return [weakSelf textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }];
```
### 备注：在使用：验证手机号弹窗 、系统有输入框样式提示窗   两种弹窗时，一定要实现下边两个回调方法，以获取输入框内容
```
    // textField输入完成回调方法
    - (void)textFieldChange:(UITextField *)textField
    {
        NSString *text = textField.text;
        //去掉半角空格
        text = [XZTool removeHalfSpace:text];
        //去掉空格
        text =  [text stringByReplacingOccurrencesOfString:@" "withString:@""];
        
        if (textField.markedTextRange == nil && text.length > 11)
        {
            //获取设备类型
            if ([UIDevice deviceIsSmallOne]) {
                [textField resignFirstResponder];
            }
            [XZCustomWaitingView showAutoHidePromptView:@"字符长度已到达最大" background:nil showTime:XZWaitingViewAutoHideTime_1];
            textField.text = [text substringToIndex:11];
        }
        
        //    /** 系统文字alertView样式弹窗输入框tag值 */
        //    XZTextFieldTagSystemAlert                                     = 2000,
        //    /** 手机号输入框tag值 */
        //    XZTextFieldTagPhoneNumber                                     = 2001,
        //    /** 验证码输入框tag值 */
        //    XZTextFieldTagVerificationCode                                = 2003,
        
        // FIXME: 根据你的需要  通过textField的tag值，获取不同的输入框输入的内容
        switch (textField.tag) {
            case XZTextFieldTagSystemAlert:
            {
                self.systemTextFieldStr = textField.text;
            }
                break;
            case XZTextFieldTagPhoneNumber:
            {
                self.phoneNumberStr = textField.text;
            }
                break;
            case XZTextFieldTagVerificationCode:
            {
                self.verificationCodeStr = textField.text;
            }
                break;
            
            default:
                break;
        }
    
    }
    
    // textField变化变化时调用
    - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
    {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
    #pragma clang diagnostic pop
    
            if ([UIDevice deviceIsSmallOne]) {
                if (textField.isFirstResponder) {
                    [textField resignFirstResponder];
                }
            }
            
            [XZCustomWaitingView showAutoHidePromptView:@"禁止输入表情" background:nil showTime:XZWaitingViewAutoHideTime_1];
            return NO;
        }
        if ([string isEqualToString:@"\n"]) {
            [textField resignFirstResponder];
            return NO;
        }
        return YES;
    }
    
```

    7.SheetView弹窗
```
    /**
    上滑提示框

    @param title 标题
    @param cancelTitle 取消按钮标题
    @param buttonTitles 选项按钮标题数组
    @param clickBlock 选中按钮后的回调
    @return XZCustomActionSheetView
    */
    [XZCustomViewManager showCustomActionSheetWithTitle:@"哈喽你好"
                                      cancelButtonTitle:@"不好"
                                      otherButtonTitles:@[@"你好", @"我好", @"大家好"]
                                                 handle:^(XZCustomActionSheetView *actionSheetView, NSInteger index) {

        switch (index) {
            case -1:
            {
                DebugLog(@"你点击了空白处");
            }
                break;
            case 0:
            {
                DebugLog(@"你点击了不好");
            }
                break;
            case 1:
            {
                DebugLog(@"你点击了你好");
            }
                break;
            case 2:
            {
                DebugLog(@"你点击了我好");
            }
                break;
            case 3:
            {
                DebugLog(@"你点击了大家好");
            }
                break;

            default:
                break;
        }

    }];
```



















