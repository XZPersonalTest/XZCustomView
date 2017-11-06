//
//  XZCustomAlertView.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "XZCustomAlertView.h"


#import "XZCustomWindowManager.h"

// AlertView 中控件之间的距离限制
static const float ViewRadius = 8.0; // 弹窗圆角
static const int ButtonOrTextFieldHeight = 50; // 按钮高度
static const int LeftRightMargin = 30.0; // 左右边距
static const int TopMargin = 25; // 上边距
static const int DistanceBetweenUIControl = 21; // 控件间距

static const int textFieldHeight = 70; // 输入框高度
static const int contentLabelMaxHeight = 100; // 最大


// AlertView 尺寸大小
#define ALERTVIEW_HEIGHT_CREATE_GROUP           230.0 // 创建群组弹窗
#define ALERTVIEW_HEIGHT_INPUT_SCHOOL_NAME      146.0 // 创建群组弹窗
#define ALERTVIEW_HEIGHT_MODIFY_MOBILE          217.0 // 验证手机弹窗
#define ALERTVIEW_HEIGHT_MULTI_VIEW             222.0 // 功能弹窗

#define ALERTVIEW_SYSTEM_HEIGHT_MULTI_VIEW      200.0 //  系统弹窗高度

//#define ALERTVIEW_UP_DISTANCE           125.0 // 弹窗上偏移距离

// AlertView 中控件颜色
#define COLOR_ALERTVIEW_SELECTOR_VIEW_BACKGROUND        [UIColor whiteColor]
#define COLOR_ALERTVIEW_BUTTON_TITLE_CANCEL             [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0]
#define COLOR_ALERTVIEW_BUTTON_TITLE_CONFIRM            [UIColor colorWithRed:78.0/255.0 green:78.0/255.0 blue:78.0/255.0 alpha:1.0]
#define COLOR_ALERTVIEW_BUTTON_BACKGROUND               [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]
#define COLOR_ALERTVIEW_GETPINCODE_BUTTON_BACKGROUND    [UIColor colorWithRed:110.0/255.0 green:180.0/255.0 blue:250.0/255.0 alpha:1.0]
#define COLOR_ALERTVIEW_TEXTFIELD_BACKGROUND            [UIColor whiteColor]
#define COLOR_ALERTVIEW_SEPORATE_LABEL_BACKGROUND       [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1.0]

// AlertView 中控件字体大小

#define FONT_TEXT_18    [UIFont boldSystemFontOfSize:16]

@interface XZCustomAlertView ()<UIGestureRecognizerDelegate,UITextFieldDelegate>


//@property (nonatomic, strong) NSArray *buttonImageNameArray; // 图标名字数组
//@property (nonatomic, strong) NSArray *buttonTitleArray; // 图标名字数组
//@property (nonatomic, strong) UIImage *statusImage; // 显示的图片

/** 提示弹窗View */
@property (nonatomic, strong) UIView *selectorView;

/** 提示标题 */
@property (nonatomic, strong) NSString *title;
/** 提示内容 */
@property (nonatomic, strong) NSString *promptLabelText;

/** 记录窗口初始位置  以便于在键盘回落变化时  调整提示框位置 */
@property (assign, nonatomic) CGRect rect;
/** 是否点击背景移除 */
@property (nonatomic, assign) BOOL isTouchBackground;

/** 取消按钮标题 */
@property (nonatomic, strong) NSString *cancelTitle;
/** 其他按钮标题 */
@property (nonatomic, strong) NSString *otherTitle;


@end

@implementation XZCustomAlertView

#pragma mark - View Init



//系统样式弹窗
- (instancetype)initSystemAlertViewWithTitle:(NSString *)title
                                     message:(NSString *)message
                           cancelButtonTitle:(NSString *)cancelTitle
                            otherButtonTitle:(NSString *)otherTitle
                           isTouchBackground:(BOOL)isTouchBackground
                           withAlertViewType:(XZAlertViewType)alertViewType
                                     handler:(void (^)(XZCustomAlertView *alertView, XZAlertViewBtnTag index ,XZAlertViewType alertViewType))block
{
    self = [self init];
    if (self)
    {
        self.title = title;
        self.promptLabelText = message;
        self.cancelTitle = cancelTitle;
        self.otherTitle = otherTitle;
        self.isTouchBackground = isTouchBackground;
        self.alertViewType = alertViewType;
        if (block) {
            self.clickBlock = block;
        }
        // 设置遮罩层和选择视图
        [self setMaskingViewAndSelectorViewWithAlertViewType:alertViewType];
    }
    return self;
}




//自定义样式弹窗  -- 后期拓展
//- (instancetype)initCustomAlertViewWithImageArray:(NSArray *)imageArray
//                                  withbuttonArray:(NSArray *)buttonArray
//                                  withStatusImage:(UIImage *)statusImage
//                                   withPromptText:(NSString *)promptText
//                                withAlertViewType:(XZAlertViewType)alertViewType
//                                          handler:(void (^)(XZCustomAlertView *alertView, NSInteger buttonIndex ,XZAlertViewType alertViewType))block
//
//{
//    self = [self init];
//    if (self)
//    {
//        self.alertViewType = alertViewType;
//        self.buttonImageNameArray = imageArray;
//        self.buttonTitleArray = buttonArray;
//        self.statusImage = statusImage;
//        self.promptLabelText = promptText;
//        if (block) {
//            self.clickBlock = block;
//        }
//
//        // 设置遮罩层和选择视图
//        [self setMaskingViewAndSelectorViewWithAlertViewType:alertViewType];
//    }
//    return self;
//}


-(void)dealloc
{
    [iOSNotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [iOSNotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - CustomUI

/**
 *  设置遮罩层和选择视图
 */
- (void)setMaskingViewAndSelectorViewWithAlertViewType:(XZAlertViewType)alertViewType
{
    // 注册键盘显示事件
    [iOSNotificationCenter addObserver:self
                              selector:@selector(keyboardWillShowNotification:)
                                  name:UIKeyboardWillShowNotification
                                object:nil];
    // 注册键盘隐藏事件
    [iOSNotificationCenter addObserver:self
                              selector:@selector(keyboardWillHideNotification:)
                                  name:UIKeyboardWillHideNotification
                                object:nil];
    
    // 设置模态遮罩层的背景色
    [self setBackgroundColor:COLOR_MASKING_VIEW_BACKGROUND];
    
    // 设置模态遮罩层的大小
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    // 初始化选择框
    [self initSeletorViewWithAlertViewType:alertViewType];
    
    switch (alertViewType) {
        case XZAlertViewTypeSystemAlert:
        case XZAlertViewTypeSystemInputAlert:
        {//系统样式弹窗
            [self initSystomAlertView];
        }
            break;
            
        case XZAlertViewTypeVerifyPhoneNumber:
        {
            // 初始化验证手机内容
            [self initModifyMobileViewContent];
        }
            break;
            
        default:
        {
            // 初始化内容
            
        }
            break;
    }
}



- (void)initSeletorViewWithAlertViewType:(XZAlertViewType)alertViewType
{
    float heightView = 0.0;
    
    switch (alertViewType) {
        case XZAlertViewTypeSystemAlert:
        {
            CGFloat messageHeight = [XZTool getSizeFromString:self.promptLabelText withFont:FONT_TEXT_18 constrainedToSize:CGSizeMake(([UIScreen screenWidth] - LeftRightMargin*2 - 20), 1000)].height;
            
            messageHeight = messageHeight <= 30 ? textFieldHeight : contentLabelMaxHeight;
            
            if (self.title.length == 0)
            {
                heightView = ButtonOrTextFieldHeight + messageHeight;
            }else
            {
                heightView = ButtonOrTextFieldHeight * 2 + messageHeight;
            }
            
            // 创建选择视图的窗口
            self.selectorView = [[UIView alloc] initWithFrame:CGRectMake(LeftRightMargin, 0.0, [UIScreen mainScreen].bounds.size.width - LeftRightMargin*2, heightView)];
            
            self.selectorView.center = self.center;
            
        }
            break;
            
        case XZAlertViewTypeSystemInputAlert:
        {
            if (self.title.length == 0) {
                heightView = ButtonOrTextFieldHeight + textFieldHeight;
            }else
            {
                heightView = ButtonOrTextFieldHeight * 2 + textFieldHeight;
            }
            
            // 创建选择视图的窗口
            self.selectorView = [[UIView alloc] initWithFrame:CGRectMake(LeftRightMargin, 0.0, [UIScreen mainScreen].bounds.size.width - LeftRightMargin*2, heightView)];
            self.selectorView.center = self.center;
        }
            break;
            
        case XZAlertViewTypeVerifyPhoneNumber:
        {
            heightView = ALERTVIEW_HEIGHT_MODIFY_MOBILE;
            
            // 创建选择视图的窗口
            self.selectorView = [[UIView alloc] initWithFrame:CGRectMake(LeftRightMargin, /*(UISCREEN_BOUNDS_SIZE.height-heightView)/2*/self.center.y - heightView/2, [UIScreen mainScreen].bounds.size.width - LeftRightMargin*2, heightView)];
        }
            break;
            
        default:
        {
            heightView = ALERTVIEW_HEIGHT_MULTI_VIEW;
            // 创建选择视图的窗口
            self.selectorView = [[UIView alloc] initWithFrame:CGRectMake(LeftRightMargin, 0.0, [UIScreen mainScreen].bounds.size.width - LeftRightMargin*2, heightView)];
            self.selectorView.center = self.center;
        }
            break;
    }
    
    self.rect = self.selectorView.frame;
    // 设置矩形四个圆角半径
    [self.selectorView.layer setCornerRadius:ViewRadius];
    self.selectorView.layer.masksToBounds = YES;
    [self.selectorView setBackgroundColor:COLOR_ALERTVIEW_SELECTOR_VIEW_BACKGROUND];
    
    // 点击背景取消模态窗
    if (self.isTouchBackground)
    {
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCustomAlertView:)];
        [gestureRecognizer setDelegate:self];
        [self addGestureRecognizer:gestureRecognizer];
    }
}



#pragma mark - ModifyMobile Init

// 设置验证手机号弹窗内容
- (void)initModifyMobileViewContent
{
    self.inputMobileNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(DistanceBetweenUIControl/2, TopMargin, CGRectGetWidth(self.selectorView.frame) - DistanceBetweenUIControl, ButtonOrTextFieldHeight)];
    self.inputMobileNumTextField.placeholder = @"输入手机号";
    [self.inputMobileNumTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    self.inputMobileNumTextField.font = FONT_TEXT_18;
    self.inputMobileNumTextField.backgroundColor = COLOR_ALERTVIEW_TEXTFIELD_BACKGROUND;
    self.inputMobileNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.inputMobileNumTextField setKeyboardType:UIKeyboardTypeNumberPad];
    self.inputMobileNumTextField.delegate = self;
    self.inputMobileNumTextField.tag = XZTextFieldTagPhoneNumber;
    [self.inputMobileNumTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.inputPincodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(DistanceBetweenUIControl/2, CGRectGetMaxY(self.inputMobileNumTextField.frame) + DistanceBetweenUIControl, CGRectGetWidth(self.selectorView.frame)/2 - DistanceBetweenUIControl, ButtonOrTextFieldHeight)];
    self.inputPincodeTextField.placeholder = @"输入验证码";
    self.inputPincodeTextField.font = FONT_TEXT_18;
    self.inputPincodeTextField.backgroundColor = COLOR_ALERTVIEW_TEXTFIELD_BACKGROUND;
    self.inputPincodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.inputPincodeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.inputPincodeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    self.inputPincodeTextField.delegate = self;
    self.inputPincodeTextField.tag = XZTextFieldTagVerificationCode;
    [self.inputPincodeTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.getPincodeButton = [[XZBorderButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.inputPincodeTextField.frame) + DistanceBetweenUIControl/2, CGRectGetMaxY(self.inputMobileNumTextField.frame) + DistanceBetweenUIControl, CGRectGetWidth(self.selectorView.frame)/2 - DistanceBetweenUIControl/2, ButtonOrTextFieldHeight)];
    // 刚开始进入时，按钮设置为不可点击
//    self.getPincodeButton.enabled = NO;
    [self.getPincodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getPincodeButton setTitleColor:/*COLOR_ALERTVIEW_BUTTON_TITLE_CONFIRM*/COLOR_ALERTVIEW_TEXTFIELD_BACKGROUND forState:UIControlStateNormal];
    //  设置
    [XZTool setBorderColorAndBlueBackGroundColorFor:self.getPincodeButton];
    //self.getPincodeButton.backgroundColor = COLOR_ALERTVIEW_GETPINCODE_BUTTON_BACKGROUND;
    self.getPincodeButton.titleLabel.font = FONT_TEXT_18;
    self.getPincodeButton.tag = XZAlertViewBtnTagVerificationCode;
    self.getPincodeButton.layer.cornerRadius = ViewRadius;
    self.getPincodeButton.layer.masksToBounds = YES;
    [self.getPincodeButton addTarget:self action:@selector(touchSelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
   UIButton *buttonCancel = [[UIButton alloc]initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.getPincodeButton.frame) + DistanceBetweenUIControl, CGRectGetWidth(self.selectorView.frame)/2 - 0.5, ButtonOrTextFieldHeight)];
    [buttonCancel setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Left_BgLine"] forState:UIControlStateNormal];
    [buttonCancel setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Left_BgLine_h"] forState:UIControlStateHighlighted];
    [buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
    [buttonCancel setTitleColor:COLOR_ALERTVIEW_BUTTON_TITLE_CONFIRM forState:UIControlStateNormal];
//    buttonCancel.backgroundColor = COLOR_ALERTVIEW_BUTTON_BACKGROUND;
    buttonCancel.titleLabel.font = FONT_TEXT_18;
    buttonCancel.tag = XZAlertViewBtnTagCancel;
//    buttonCancel.layer.cornerRadius = ViewRadius;
//    buttonCancel.layer.masksToBounds = YES;
    [buttonCancel addTarget:self action:@selector(touchRemoveAlertViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSure = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonCancel.frame) + 1, CGRectGetMaxY(self.getPincodeButton.frame) + DistanceBetweenUIControl, CGRectGetWidth(self.selectorView.frame)/2 - 0.5, ButtonOrTextFieldHeight)];
    [buttonSure setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Reight_BgLine"] forState:UIControlStateNormal];
    [buttonSure setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Reight_BgLine_h"] forState:UIControlStateHighlighted];
    [buttonSure setTitle:@"确定" forState:UIControlStateNormal];
    [buttonSure setTitleColor:COLOR_ALERTVIEW_BUTTON_TITLE_CONFIRM forState:UIControlStateNormal];
//    buttonSure.backgroundColor = COLOR_ALERTVIEW_BUTTON_BACKGROUND;
    buttonSure.titleLabel.font = FONT_TEXT_18;
    buttonSure.tag = XZAlertViewBtnTagSure;
//    buttonSure.layer.cornerRadius = ViewRadius;
//    buttonSure.layer.masksToBounds = YES;
    [buttonSure addTarget:self action:@selector(touchRemoveAlertViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelSeperator = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(buttonCancel.frame), CGRectGetMinY(buttonCancel.frame) /*+ ViewRadius*/, 1.0, CGRectGetHeight(buttonCancel.frame) /*- 2*ViewRadius*/)];
    labelSeperator.backgroundColor = COLOR_ALERTVIEW_SEPORATE_LABEL_BACKGROUND;
    
    [self.selectorView addSubview:self.inputMobileNumTextField];
    [self.selectorView addSubview:self.inputPincodeTextField];
    [self.selectorView addSubview:self.getPincodeButton];
    [self.selectorView addSubview:buttonCancel];
    [self.selectorView addSubview:buttonSure];
    [self.selectorView addSubview:labelSeperator];
    
    // 设置第一响应
    [self.inputMobileNumTextField becomeFirstResponder];
}


//系统样式弹窗
- (void)initSystomAlertView
{
    CGFloat height = 0;
    if (self.title) //标题
    {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.selectorView.frame), ButtonOrTextFieldHeight)];
        [titleLabel setFont:XZFont(18)];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setText:self.title];
        [self.selectorView addSubview:titleLabel];
        
        height = ButtonOrTextFieldHeight;
        
        if (self.alertViewType == XZAlertViewTypeSystemAlert)
        {
            //分割线
            UILabel *labelSeperator = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(self.selectorView.frame), 0.5)];
            labelSeperator.backgroundColor = [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:0.8];
            [self.selectorView addSubview:labelSeperator];
            
            height += 0.5;
        }
    }
    
    if (self.alertViewType == XZAlertViewTypeSystemInputAlert)
    { //输入框
        
        self.systemInputAlertViewTextField = [[UITextField alloc]initWithFrame:CGRectMake(DistanceBetweenUIControl/2, height + (textFieldHeight - ButtonOrTextFieldHeight)/2, CGRectGetWidth(self.selectorView.frame) - DistanceBetweenUIControl, ButtonOrTextFieldHeight)];
    
        self.systemInputAlertViewTextField.backgroundColor = COLOR_ALERTVIEW_TEXTFIELD_BACKGROUND;

        [self.systemInputAlertViewTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        self.systemInputAlertViewTextField.textAlignment = NSTextAlignmentCenter;
        self.systemInputAlertViewTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.systemInputAlertViewTextField.returnKeyType = UIReturnKeyDone;
        [self.selectorView addSubview:self.systemInputAlertViewTextField];
        self.systemInputAlertViewTextField.delegate = self;
        self.systemInputAlertViewTextField.tag = XZTextFieldTagSystemAlert;
        [self.systemInputAlertViewTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        
        
        height += textFieldHeight;
    }
    else
    {
       //内容
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, height, CGRectGetWidth(self.selectorView.frame) - 20, CGRectGetHeight(self.selectorView.frame) - height - ButtonOrTextFieldHeight )];
        
        messageLabel.numberOfLines = 0;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.promptLabelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:6];//调整行间距
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        
        NSRange range = NSMakeRange(0, [self.promptLabelText length]);
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        [attributedString addAttribute:NSForegroundColorAttributeName value:RGB(67,67,67) range:range];
        [attributedString addAttribute:NSFontAttributeName value:XZFont(18) range:range];
        
        [messageLabel setAttributedText:attributedString];
        [self.selectorView addSubview:messageLabel];
        
        height += CGRectGetHeight(messageLabel.frame);
    }
    

    //分割线
    UILabel *labelDownSeperator = [[UILabel alloc] initWithFrame:CGRectMake(0,height, CGRectGetWidth(self.selectorView.frame), 0.5)];
    labelDownSeperator.backgroundColor = [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:0.8];
    [self.selectorView addSubview:labelDownSeperator];
    height += 0.5;
    
    
    if (self.cancelTitle.length == 0 || self.otherTitle.length == 0)
    {
        NSString *buttonTitle = self.cancelTitle.length > 0 ? self.cancelTitle :self.otherTitle;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, height,CGRectGetWidth(self.selectorView.frame), CGRectGetHeight(self.selectorView.frame) - height)];
        
        [button setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Left_BgLine"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Left_BgLine_h"] forState:UIControlStateHighlighted];
        
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        
        [button setTitleColor:COLOR_ALERTVIEW_BUTTON_TITLE_CONFIRM forState:UIControlStateNormal];
        button.backgroundColor = COLOR_ALERTVIEW_BUTTON_BACKGROUND;
        button.titleLabel.font = FONT_TEXT_18;
        button.tag = XZAlertViewBtnTagCancel;
        [button addTarget:self action:@selector(touchRemoveAlertViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectorView addSubview:button];
        
    }else
    {
        UIButton *buttonCancel = [[UIButton alloc] initWithFrame:CGRectMake(0.0, height, CGRectGetWidth(self.selectorView.frame)/2 - 0.5,  CGRectGetHeight(self.selectorView.frame) - height)];
        [buttonCancel setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Left_BgLine"] forState:UIControlStateNormal];
        [buttonCancel setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Left_BgLine_h"] forState:UIControlStateHighlighted];
        [buttonCancel setTitle:self.cancelTitle forState:UIControlStateNormal];
        [buttonCancel setTitleColor:COLOR_ALERTVIEW_BUTTON_TITLE_CONFIRM forState:UIControlStateNormal];
        //    buttonCancel.backgroundColor =  COLOR_ALERTVIEW_BUTTON_BACKGROUND;
        buttonCancel.titleLabel.font = FONT_TEXT_18;
        buttonCancel.tag = XZAlertViewBtnTagCancel;
        
        [buttonCancel addTarget:self action:@selector(touchRemoveAlertViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *buttonSure= [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(buttonCancel.frame) + 0.5, height, CGRectGetWidth(self.selectorView.frame)/2 ,  CGRectGetHeight(self.selectorView.frame) - height)];
        
        [buttonSure setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Reight_BgLine"] forState:UIControlStateNormal];
        [buttonSure setBackgroundImage:[UIImage imageNamed:@"XZ_Alert_Reight_BgLine_h"] forState:UIControlStateHighlighted];
        
        [buttonSure setTitle:self.otherTitle forState:UIControlStateNormal];
        
        [buttonSure setTitleColor:COLOR_ALERTVIEW_BUTTON_TITLE_CONFIRM forState:UIControlStateNormal];
        buttonSure.titleLabel.font = FONT_TEXT_18;
        buttonSure.tag = XZAlertViewBtnTagSure;
        
        [buttonSure addTarget:self action:@selector(touchRemoveAlertViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *labelSeperator = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(buttonCancel.frame), CGRectGetMinY(buttonCancel.frame) /*+ ViewRadius*/, 0.5, CGRectGetHeight(buttonCancel.frame)/* - 2*ViewRadius*/)];
        labelSeperator.backgroundColor = COLOR_ALERTVIEW_SEPORATE_LABEL_BACKGROUND;
        
        [self.selectorView addSubview:buttonCancel];
        [self.selectorView addSubview:buttonSure];
        [self.selectorView addSubview:labelSeperator];
    }
    
    if (self.systemInputAlertViewTextField) {
        // 设置第一响应
        [self.systemInputAlertViewTextField becomeFirstResponder];
    }
}




#pragma mark - Touch Button Action

/**
 点击提示框上面需要移除提示框的按钮   例：取消/确认按钮
 
 @param sender 选择的按钮
 */
- (void)touchRemoveAlertViewButtonAction:(id)sender
{
    UIButton *buttonSelect = (UIButton *)sender;
    
    if (self.clickBlock) {
        self.clickBlock (self , buttonSelect.tag , self.alertViewType);
    }
    [self cancelAction];
}

/**
 点击提示框上面不需要移除提示框的按钮   例：获取验证码按钮
 
 @param sender 点击的按钮
 */
- (void)touchSelectButtonAction:(id)sender
{
    UIButton *buttonSelect = (UIButton *)sender;
    if (self.clickBlock) {
        self.clickBlock (self , buttonSelect.tag , self.alertViewType);
    }
    
}


/**
 选择取消按钮
 */
- (void)cancelAction
{
    [[XZCustomWindowManager shareManager] removeAllCustomView:NO];
}


#pragma mark - Show Or Hide Alert View
// 显示模态视图
- (void)show
{
    if (!self.selectorView) {
        return;
    }
    [[XZCustomWindowManager shareManager] addCustomView:self withType:XZCusomViewModelTypeAlert];
    
    [self addSubview:self.selectorView];
    
    getWeakSelf
    self.alpha = 0;
    self.selectorView.layer.opacity = 0.5f;
    self.selectorView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         weakSelf.alpha = 1.0;
                         self.selectorView.layer.opacity = 1.0f;
                         self.selectorView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
    
}

// 隐藏模态视图
- (void)hideCustomAlertView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (self.clickBlock) {
        self.clickBlock (self , XZAlertViewBtnTagBgCancel , self.alertViewType);
    }
    [self cancelAction];
}

#pragma mark - text Field Change block
//textFieldChange
- (void)setTextFieldChangeHandler:(void (^)(UITextField *textField))block
{
    if (block) {
        self.textFieldChange = block;
    }
}


//textFieldShoudChange
- (void)setTextFieldShoudChangeHandler:(BOOL (^)(UITextField *textField ,NSRange range ,NSString *string))block
{
    if (block) {
        self.textFieldShouldChange = block;
    }
}


#pragma mark textFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = YES;
    if (self.textFieldShouldChange) {
      result =  self.textFieldShouldChange(textField,range,string);
    }
    return result;
}

- (void)textFieldChange:(UITextField *)textField
{
    
    if (self.textFieldChange) {
        self.textFieldChange(textField);
    }
}


#pragma mark -
#pragma mark NotificationCenter

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    //keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    //     Restore the size of the text view (fill self's view).
    //     Animate the resize so that it's in sync with the disappearance of the keyboard.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = 0.0;
    [animationDurationValue getValue:&animationDuration];
    
    // 得到键盘的高度
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];

    self.selectorView.frame = CGRectMake(self.rect.origin.x, self.rect.origin.y - keyboardRect.size.height/2, self.rect.size.width, self.rect.size.height);
    
    [UIView commitAnimations];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    //NSLog(@"DEBUG: keyboardWillHideNotification");
    NSDictionary* userInfo = [notification userInfo];
    
    //     Restore the size of the text view (fill self's view).
    //     Animate the resize so that it's in sync with the disappearance of the keyboard.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = 0.0;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.selectorView.frame = self.rect;
    
    [UIView commitAnimations];
}



@end
