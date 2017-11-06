//
//  XZCustomActionSheetView.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "XZCustomActionSheetView.h"

#import "XZCustomWindowManager.h"

#import "XZTool.h"

static const int LeftRightMargin = 10.0; // 左右边距
static const int spaceMargin = 8; // 取消按钮间距
static const int buttonHeight = 50; // 按钮间距
static const int titleHeight =  45; // 标题间距


/** 控件颜色*/
#define COLOR_BUTTON_TITLE_CONFIRM   [UIColor colorWithRed:78.0/255.0 green:78.0/255.0 blue:78.0/255.0 alpha:1.0]

/** 分割线颜色*/
#define COLOR_ALERTVIEW_SEPORATE_LABEL_BACKGROUND   [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1.0]

#define COLOR_BUTTON_HEOGHT_COLOR [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:0.7]

/** 标题字体*/
#define FONT_TITLE_TEXT_15   [UIFont systemFontOfSize:15]

/** 按钮字体*/
#define FONT_BUTTON_TEXT_16  [UIFont systemFontOfSize:16]


@interface XZCustomActionSheetView()<UIGestureRecognizerDelegate>

/** 标题 */
@property (nonatomic, copy) NSString *titleStr;
/** 取消按钮文字 */
@property (nonatomic, copy) NSString *cancelTitle;
/** 选项按钮文字 */
@property (nonatomic, copy) NSArray *buttonTitles;
/** 是否显示选中图标 */  // 扩展功能
@property (nonatomic, assign) BOOL isShowSelecteState;

@property (nonatomic, strong) UIView *actionSheetBgView;

@property (assign , nonatomic) CGFloat viewHeight;

/** */
@property (nonatomic, copy) XZCustomActionSheetClickBlock clickBlock;

@end



@implementation XZCustomActionSheetView


/**
 上滑提示框
 
 @param title 标题
 @param cancelTitle 取消按钮标题
 @param buttonTitles 选项按钮标题数组
 @param clickBlock 选中按钮后的回调
 @return return value description
 */
- (instancetype)initCustomActionSheetWithTitle:(NSString *)title
                             cancelButtonTitle:(NSString *)cancelTitle
                             otherButtonTitles:(NSArray *)buttonTitles
                                        handle:(void (^)(XZCustomActionSheetView *actionSheetView , NSInteger index))clickBlock
{

    self = [self init];
    if (self) {
        self.titleStr = title;
        self.cancelTitle = cancelTitle;
        self.buttonTitles = buttonTitles;
        if (clickBlock) {
            self.clickBlock = clickBlock;
        }
        // 设置遮罩层和选择视图
        [self setMaskingViewAndActionSheeyView];
    }
    return self;
}


- (void)setMaskingViewAndActionSheeyView
{
    //配置背景
    [self configBackgroundView];
    //actionSheet背景view
    [self congfigActionSheetBackgroundView];
    //actionSheet
    [self configActionSheetView];
}

#pragma mark - config UI

- (void)configBackgroundView
{
    // 设置模态遮罩层的背景色
    [self setBackgroundColor:COLOR_MASKING_VIEW_BACKGROUND];
    
    // 设置模态遮罩层的大小
    self.frame = CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen screenHeight]);
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCustomActionSheetView:)];
    [gestureRecognizer setDelegate:self];
    [self addGestureRecognizer:gestureRecognizer];
}


//actionSheet背景view
- (void)congfigActionSheetBackgroundView
{
    self.actionSheetBgView = [[UIView alloc]init];
    self.actionSheetBgView .backgroundColor = XZClearColor;
    CGFloat hetght = buttonHeight * (self.buttonTitles.count + 1) + spaceMargin;
    if (self.titleStr.length > 0)
    {
        hetght += titleHeight;
        if (self.buttonTitles.count > 0) {
            hetght += 0.5;
        }
    }
    if (self.buttonTitles.count > 0) {
        hetght += 0.5 * (self.buttonTitles.count - 1);
    }
    self.viewHeight = hetght;
    self.actionSheetBgView .frame = CGRectMake(0, [UIScreen screenHeight] - hetght, [UIScreen screenWidth], hetght);
}


//actionSheet
- (void)configActionSheetView
{
    UIView *mainView = [[UIView alloc]init];
    mainView.frame = CGRectMake(LeftRightMargin, 0, CGRectGetWidth(self.actionSheetBgView.frame) - 2 *LeftRightMargin, CGRectGetHeight(self.actionSheetBgView.frame) - buttonHeight - spaceMargin);

    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 10;
    mainView.layer.masksToBounds = YES;
    [self.actionSheetBgView addSubview:mainView];
    
    //按钮高亮状态颜色
    UIImage *image = [UIImage imageWithColor:COLOR_BUTTON_HEOGHT_COLOR size:CGSizeMake(10, 10)];
    //标题
    CGFloat height = 0;
    if (self.titleStr.length > 0) {
        UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(mainView.frame), titleHeight)];
        [label setTextColor:[UIColor lightGrayColor]];
        [label setFont:FONT_TITLE_TEXT_15];
        [label setText:self.titleStr];
        [label setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:label];
        height +=titleHeight;
        
        if (self.buttonTitles.count > 0) {
            UILabel *labelSeperator = [[UILabel alloc] initWithFrame:CGRectMake(0, height, CGRectGetWidth(mainView.frame), 0.5)];
            labelSeperator.backgroundColor = COLOR_ALERTVIEW_SEPORATE_LABEL_BACKGROUND;
            [mainView addSubview:labelSeperator];
            height += 0.5;
        }
    }
    
    //按钮
    for (int i = 0; i < self.buttonTitles.count; i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( 0 , height , CGRectGetWidth(mainView.frame) , buttonHeight)];
        [button setTitle:[self.buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        [button.titleLabel setFont:FONT_BUTTON_TEXT_16];
        [button setTitleColor:COLOR_BUTTON_TITLE_CONFIRM forState:UIControlStateNormal];
        [mainView addSubview:button];
        [button setTag:i+1];
        [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        height += buttonHeight;
        
        if (i < self.buttonTitles.count - 1) {
            UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, height, CGRectGetWidth(mainView.frame), 0.5)];
            labelLine.backgroundColor = COLOR_ALERTVIEW_SEPORATE_LABEL_BACKGROUND;
            [mainView addSubview:labelLine];
            height += 0.5;
        }
    }
    
    // FIXME: 是否显示选中图标  扩展功能
    if (self.isShowSelecteState) {
        
    }
    
    //取消按钮
    UIButton *cancelBt = [[UIButton alloc] initWithFrame:CGRectMake( LeftRightMargin , CGRectGetHeight(self.actionSheetBgView.frame) - buttonHeight , CGRectGetWidth(mainView.frame) , buttonHeight)];
    [cancelBt setTitle:self.cancelTitle.length ? self.cancelTitle : @"取消" forState:UIControlStateNormal];
    [cancelBt setBackgroundColor:[UIColor whiteColor]];
    [cancelBt setBackgroundImage:image forState:UIControlStateHighlighted];
    [cancelBt setTitleColor:COLOR_BUTTON_TITLE_CONFIRM forState:UIControlStateNormal];
    [cancelBt.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [cancelBt setTag:0];
    cancelBt.layer.cornerRadius = 10;
    cancelBt.layer.masksToBounds = YES;
    [cancelBt addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionSheetBgView addSubview:cancelBt];
}


- (void)touchButton:(id)sender
{
    UIButton *bt = (UIButton *)sender;
    [self cancelAction:bt.tag];
}


#pragma mark -  show / cancel  method

// 隐藏模态视图
- (void)hideCustomActionSheetView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self cancelAction:-1];
}

// 选择取消按钮
- (void)cancelAction:(NSInteger)integer
{
    getWeakSelf;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.actionSheetBgView.frame = CGRectMake(0, [UIScreen screenHeight], [UIScreen screenWidth], weakSelf.viewHeight);
        weakSelf.alpha = 0;
        [weakSelf.actionSheetBgView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock (weakSelf , integer);
        }
        
        [[XZCustomWindowManager shareManager] removeAllCustomView:NO];
    }];
}

// 显示模态视图
- (void)show
{
    if (!self.actionSheetBgView) {
        return;
    }

    [[XZCustomWindowManager shareManager] addCustomView:self withType:XZCusomViewModelTypeActionSheet];
    
    [self addSubview:self.actionSheetBgView];
    getWeakSelf
    self.alpha = 0;
    self.actionSheetBgView.frame = CGRectMake(0, [UIScreen screenHeight], [UIScreen screenWidth], self.viewHeight);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1.0;
        weakSelf.actionSheetBgView.frame = CGRectMake(0, [UIScreen screenHeight] - weakSelf.viewHeight - spaceMargin, [UIScreen screenWidth], weakSelf.viewHeight);
    } completion:nil];
}



@end
