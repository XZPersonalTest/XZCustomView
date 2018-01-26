//
//  XZTestVC.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "XZTestVC.h"

#import "XZTestCell.h"

#import "XZTestManager.h"

// 祥子SDK
#import "XZHeader.h"

@interface XZTestVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 数据Model数组 */
@property (nonatomic, strong) NSMutableArray * models;

/** 接收系统文字alertView样式弹窗输入框输入的内容 */
@property (nonatomic, copy) NSString * systemTextFieldStr;
/** 接收手机号输入框输入的内容 */
@property (nonatomic, copy) NSString * phoneNumberStr;
/** 接收验证码输入框输入的内容 */
@property (nonatomic, copy) NSString * verificationCodeStr;


@end

@implementation XZTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.models = [XZTestManager loadDataWithCustomViewType:self.customViewType];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [XZCustomWaitingView hideIconWaitingMaskView:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.models.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XZTestCell *cell = [tableView dequeueReusableCellWithIdentifier:XZTestCellID];

    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XZTestCell class]) owner:nil options:nil].firstObject;

    }
    cell.testModel = self.models[indexPath.row];
    
    return cell;

}

// Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XZTestModel *model = self.models[indexPath.row];
    
    getWeakSelf
    
    switch (self.customViewType) {
            // 等待提示框
        case XZCustomViewTypeWaitingMaskView:
        {
            switch (model.customViewWaitingType) {
                    // 自适应文字+菊花等待窗类型
                case XZCustomViewWaitingTypeAdaptiveTitleSize:
                {
                    [XZCustomWaitingView showAdaptiveWaitingMaskView:@"努力加载中努力加载中..." iconName:@"XZ_mei_tuan" iconNumber:4];
                    
//                    [XZCustomWaitingView showAdaptiveWaitingMaskView:@"努力加载中..." iconName:nil iconNumber:0];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [XZCustomWaitingView hideWaitingMaskView];
                        
                    });
                    
                }
                    break;
                    // 固定文字大小+菊花等待窗类型
                case XZCustomViewWaitingTypeFixedTitleSize:
                {
                    [XZCustomWaitingView showWaitingMaskView:@"努力加载中..." iconName:nil iconNumber:0];
                    
//                    [XZCustomWaitingView showWaitingMaskView:@"努力加载中..." iconName:nil iconNumber:0];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [XZCustomWaitingView hideWaitingMaskView];
                        
                    });
                    
                }
                    break;
                    // 循环Icon图标形成的等待界面
                case XZCustomViewWaitingTypeLoopIcon:
                {
                    [XZCustomWaitingView showIconWaitingMaskViewWithIcon:@"XZ_loading" iconNumber:11];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [XZCustomWaitingView hideIconWaitingMaskView:YES];
                    });
                    
                }
                    break;
                    // 自动隐藏提示框
                case XZCustomViewWaitingTypeAutoHideView:
                {
                    // 没有block回调   不再演示
//                    [XZCustomWaitingView showAutoHidePromptView:@"我是会消失的" background:[UIImage imageNamed:@"XZ_no_net"] showTime:XZWaitingViewAutoHideTime_1];
                    
                    // 窗口隐藏后有回调的
                    [XZCustomWaitingView showAutoHidePromptView:@"我是会消失的" background:[UIImage imageNamed:@"XZ_maintenance"] showTime:XZWaitingViewAutoHideTime_1 completion:^{
        
                        DebugLog(@"提示框消失后，你要做些什么呢？？？");
                    }];
                    
                    
                }
                    break;
                    // 纯文字自动隐藏提示框
                case XZCustomViewWaitingTypeTitle:
                {
                    // 没有block回调   不再演示
//                    [XZCustomWaitingView showAutoHidePromptView:@"我是会消失的" background:nil showTime:XZWaitingViewAutoHideTime_1];
                    
                    // 窗口隐藏后有回调的
                    [XZCustomWaitingView showAutoHidePromptView:@"我是会消失的" background:nil showTime:XZWaitingViewAutoHideTime_1 completion:^{
                        
                        DebugLog(@"提示框消失后，你要做些什么呢？？？");
                    }];
                    
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            // 警告视图提示框
        case XZCustomViewTypeAlertView:
        {
            switch (model.customViewAlertViewType) {
                    // 系统文字alertView样式提示窗一个按钮
                case XZCustomViewAlertViewTypeSystemAlertOneBtn:
                {
                    [XZCustomViewManager showSystemAlertViewWithTitle:nil
                                                              message:@"我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子我就是闲来没事，提示一下子"
                                                    cancelButtonTitle:@"提示个毛啊"
                                                     otherButtonTitle:nil
                                                    isTouchbackground:YES
                                                    withAlertViewType:XZAlertViewTypeSystemAlert
                                                              handler:^(XZCustomAlertView *alertView, XZAlertViewBtnTag buttonIndex, XZAlertViewType alertViewType)
                    {
                        
                        switch (buttonIndex) {
                            case XZAlertViewBtnTagBgCancel:
                            {
                                
                                DebugLog(@"你好像点击了背景");
                            }
                                break;
                            case XZAlertViewBtnTagCancel:
                            {
                                
                                DebugLog(@"你好像点击了提示个毛啊按钮");
                            }
                                break;
//                            case XZAlertViewBtnTagSure:
//                            {
//
//                                DebugLog(@"你好像点击了好吧按钮");
//                            }
//                                break;
                                
                            default:
                                break;
                        }
                        
                    }];
                    
                }
                    break;
                    
                    // 系统文字alertView样式提示窗两个按钮
                case XZCustomViewAlertViewTypeSystemAlertTwoBtn:
                {
                    [XZCustomViewManager showSystemAlertViewWithTitle:@"提示"
                                                              message:@"我就是闲来没事下子我一下子我"
                                                    cancelButtonTitle:@"提示个毛啊"
                                                     otherButtonTitle:@"好吧"
                                                    isTouchbackground:YES
                                                    withAlertViewType:XZAlertViewTypeSystemAlert
                                                              handler:^(XZCustomAlertView *alertView, XZAlertViewBtnTag buttonIndex, XZAlertViewType alertViewType)
                     {
                         
                         switch (buttonIndex) {
                             case XZAlertViewBtnTagBgCancel:
                             {
                                 
                                 DebugLog(@"你好像点击了背景");
                             }
                                 break;
                             case XZAlertViewBtnTagCancel:
                             {
                                 
                                 DebugLog(@"你好像点击了提示个毛啊按钮");
                             }
                                 break;
                             case XZAlertViewBtnTagSure:
                             {
                                 
                                 DebugLog(@"你好像点击了好吧按钮");
                             }
                                 break;
                                 
                             default:
                                 break;
                         }
                         
                     }];
                    
                }
                    break;
                    // 系统alertView样式提示窗，有输入框
                case XZCustomViewAlertViewTypeSystemInputAlert:
                {
                    
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
                                 
                                 DebugLog(@"你好像点击了背景");
                             }
                                 break;
                             case XZAlertViewBtnTagCancel:
                             {
                                 
                                 DebugLog(@"你好像点击了坚决不输入按钮");
                             }
                                 break;
                             case XZAlertViewBtnTagSure:
                             {
                                 
                                 DebugLog(@"你好像点击了好吧按钮");
                             }
                                 break;
                                 
                             default:
                                 break;
                         }
                         
                         DebugLog(@"+++++++系统alertView样式提示窗输入框%@",self.systemTextFieldStr);
                  
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
                    
                }
                    break;
                    // 验证手机号弹窗
                case XZCustomViewAlertViewTypeVerifyPhoneNumber:
                {
                    XZCustomAlertView *alertView = [XZCustomViewManager showSystemAlertViewWithTitle:@"验证您的手鸡号"
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
                                 
                                 DebugLog(@"你好像点击了背景");
                             }
                                 break;
                             case XZAlertViewBtnTagCancel:
                             {
                                 
                                 DebugLog(@"你好像点击了取消按钮");
                             }
                                 break;
                             case XZAlertViewBtnTagSure:
                             {
                                 
                                 DebugLog(@"你好像点击了确定按钮");
                             }
                                 break;
                             case XZAlertViewBtnTagVerificationCode:
                             {
                                 
                                 DebugLog(@"你好像点击了获取验证码按钮");
                             }
                                 break;
                                 
                             default:
                                 break;
                         }
                         
                         DebugLog(@"+++++++你输入的手鸡号是%@",self.phoneNumberStr);
                         DebugLog(@"+++++++你输入的验证码是%@",self.verificationCodeStr);
                         
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
                    
                }
                    break;
                    
                default:
                    break;
            }
            
            
        }
            break;
            
            
            
            
            
        default:
        {
            
            switch (model.customViewType) {
                case XZCustomViewTypeWaitingMaskView:
                {
                    
                    XZTestVC *testVC = [[XZTestVC alloc] init];
                    
                    testVC.customViewType = XZCustomViewTypeWaitingMaskView;
                    
                    [self.navigationController pushViewController:testVC animated:YES];
                    
                    
                }
                    break;
                case XZCustomViewTypeAlertView:
                {
                    
                    XZTestVC *testVC = [[XZTestVC alloc] init];
                    
                    testVC.customViewType = XZCustomViewTypeAlertView;
                    
                    [self.navigationController pushViewController:testVC animated:YES];
                    
                }
                    break;
                case XZCustomViewTypeActionSheetView:
                {
                    
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
                    
                }
                    break;
                case XZCustomViewTypePickerView:
                {
                    [XZCustomWaitingView showAutoHidePromptView:@"程序员正在放血祭天,更多功能，敬请期待......" background:nil showTime:XZWaitingViewAutoHideTime_1];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
    }
    
    
}



#pragma mark - textField delegate


// 判断输入内容长度
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



//收回键盘
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
