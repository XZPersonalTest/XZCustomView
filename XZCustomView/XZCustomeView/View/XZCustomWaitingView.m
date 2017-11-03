//
//  XZCustomWaitingView.m
//  XZCustomView
//
//  Created by LWX on 2017/11/1.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "XZCustomWaitingView.h"

#import "XZCustomWindowManager.h"

#import "XZTool.h"

@implementation XZCustomWaitingView



/****************************************************************************************************************/

/**
 显示自适应模态菊花转+文字类型等待框
 提示框会根据文字多少自动拉长适配
 
 @param title 菊花转下方字体
 @param iconName 如果不需要菊花转 需要自定义图片  可传入自定义icon图   例：图标名字前半部分：XZ_loading  全名为：XZ_loading_0   注：图标命名一定要规范
 @param iconNumber icon图总共数量
 */
+ (void)showAdaptiveWaitingMaskView:(NSString *)title
                           iconName:(NSString *)iconName
                         iconNumber:(int)iconNumber
{
    // 调用公共配置方法
    [XZCustomWaitingView configWaitingMaskViewUIWithTitle:title iconName:iconName iconNumber:iconNumber isNeedAdaptive:YES];
    
    DebugLog(@"TOOLS: Show Waiting Mask View...");
    
}


/****************************************************************************************************************/

/**
 显示模态菊花转+固定大小文字类型等待框
 提示框大小是根据屏幕比例固定的
 
 @param title 菊花转下方字体
 @param iconName 如果不需要菊花转 需要自定义图片 可传入自定义icon图   例：图标名字前半部分：XZ_loading  全名为：XZ_loading_0   注：图标命名一定要规范
 @param iconNumber icon图总共数量
 */
+ (void)showWaitingMaskView:(NSString *)title
                   iconName:(NSString *)iconName
                 iconNumber:(int)iconNumber
{
    // 调用公共配置方法
    [XZCustomWaitingView configWaitingMaskViewUIWithTitle:title iconName:iconName iconNumber:iconNumber isNeedAdaptive:NO];
    
    DebugLog(@"TOOLS: Show Waiting Mask View...");
}


/**
 配置图片+文字类型等待框UI 公共方法
 
 @param title 提示文字
 @param iconName 如果不需要菊花转 需要自定义图片 可传入自定义icon图   例：图标名字前半部分：XZ_loading  全名为：XZ_loading_0   注：图标命名一定要规范
 @param iconNumber icon图总共数量
 @param isNeedAdaptive 是否根据文字多少自动适配
 */
+ (void)configWaitingMaskViewUIWithTitle:(NSString *)title
                                iconName:(NSString *)iconName
                              iconNumber:(int)iconNumber
                          isNeedAdaptive:(BOOL)isNeedAdaptive
{
    
    // 先检查下是否已经存在一个提示等待框，如果存在先关闭这一个
    [XZCustomWaitingView hideWaitingMaskView];
    
    // 生成模态的view
    UIView *alertMaskView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen screenHeight])];
    // 模态view设置为透明色
    [alertMaskView setBackgroundColor:XZClearColor];
    alertMaskView.tag = 1000;
    
    UIFont *fontPromptText = [UIFont systemFontOfSize:16];
    // 设定绘制字符串高和宽
    CGSize sizeTitleString = [XZTool getSizeFromString:title withFont:fontPromptText constrainedToSize:CGSizeMake([UIScreen screenWidth]/3 - 20, [UIScreen screenHeight]/3)];
    
    float alertOvalViewWidth = [UIScreen screenWidth]/3;
    float alertOvalViewHeight = [UIScreen screenWidth]/3;
    
    // 中间显示提示文字与活动指示器的view
    UIView *alertOvalView = [[UIView alloc] initWithFrame:CGRectMake(alertMaskView.center.x - alertOvalViewWidth/2.0, alertMaskView.center.y - alertOvalViewHeight/2.0, alertOvalViewWidth, alertOvalViewHeight)];
    
    // FIXME: 设置提示框的背景色和透明度  根据项目需求可进行修改  默认为透明色
    [alertOvalView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    
    // 设置圆角
    alertOvalView.layer.cornerRadius = 7.5;
    alertOvalView.layer.masksToBounds = YES;
    
    // 活动指针器
    UIActivityIndicatorView *activityIndicatorView;
    UIImageView *imageView;
    CGRect tempRect;
    if (iconName) {
        imageView = [[UIImageView alloc] init];
        
        NSMutableArray * mutableArr = [[NSMutableArray alloc]init];
        CGSize imageSize;
        for (int i = 0; i < iconNumber; i++) {
            NSString* imageName = [NSString stringWithFormat:@"%@_%d",iconName, i];
            UIImage *image = [UIImage imageNamed:imageName];
            imageSize = image.size;
            [mutableArr addObject:image];
        }
        CGFloat imageView_W = imageSize.width*(alertOvalViewWidth/2.0)/imageSize.height;
        CGFloat imageView_H = alertOvalViewWidth/2.0;
        imageView.frame = CGRectMake((alertOvalViewWidth - imageView_W)/2.0, (alertOvalViewWidth - imageView_W)/2.0, imageView_W, imageView_H);
        
        imageView.animationImages = mutableArr;
        // FIXME: 动画加载频路 数值越小 动画越快  可根据自己项目需求修改
        [imageView setAnimationDuration:(iconNumber/15.0)];
        [imageView setAnimationRepeatCount:0];
        [imageView startAnimating];
        
        tempRect = imageView.frame;
    }
    else
    {
        // 活动指针器
        activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicatorView.center = CGPointMake(alertOvalViewWidth/2.0, alertOvalViewWidth/2.0);//CGPointMake(alertOvalView.bounds.size.width/2.0, 35);
        [activityIndicatorView startAnimating];
        
        tempRect = activityIndicatorView.frame;
        
    }
    
    //NSLog(@"DEBUG: indicator.frame = %@", NSStringFromCGRect(indicator.frame));
    
    // 文本提示Label
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake((alertOvalViewWidth - sizeTitleString.width) / 2.0, CGRectGetMaxY(tempRect) + 14, sizeTitleString.width, sizeTitleString.height)];
    promptLabel.numberOfLines = 0;
    promptLabel.text = title;
    [promptLabel setBackgroundColor:XZClearColor];
    [promptLabel setTextAlignment:NSTextAlignmentCenter];
    // FIXME: 字体颜色  可根据项目绣球进行修改  默认为黑色
    [promptLabel setTextColor:[UIColor whiteColor]];
    promptLabel.font = fontPromptText;
    
    if (isNeedAdaptive) {
        //修改背景view frame
        if (CGRectGetMaxY(promptLabel.frame) + 3 > [UIScreen screenWidth]/3) {
            CGRect rect = alertOvalView.frame;
            rect.size.height = CGRectGetMaxY(promptLabel.frame) + 3;
            alertOvalView.frame = rect;
        }
    }
    
    // 将提示文本的Label增加到alert上
    [alertOvalView addSubview:promptLabel];
    
    // 将活动指针器增加到alert上
    [alertOvalView addSubview:iconName ? imageView : activityIndicatorView];
    [alertMaskView addSubview:alertOvalView];
    
    [[XZCustomWindowManager shareManager] addCustomView:alertMaskView withType:XZCusomViewModelTypeHUD];
    
    DebugLog(@"TOOLS: Show Waiting Mask View...");
    
}


/**
 隐藏模态菊花转+固定大小文字类型等待框
 */
+ (void)hideWaitingMaskView
{
    [[XZCustomWindowManager shareManager] removeCustomViewWithType:XZCusomViewModelTypeHUD];
}



/****************************************************************************************************************/

/**
 循环icon图  形成等待页面  翻书样式为例
 
 @param iconName icon图名字前半部分：XZ_loading  全名为：XZ_loading_0   注：图标命名一定要规范
 @param iconNumber icon图总共数量
 */
+ (void)showIconWaitingMaskViewWithIcon:(NSString *)iconName iconNumber:(int)iconNumber{
    
    [self hideWaitingMaskView];
    
    // 先检查下是否已经存在一个提示等待框，如果存在先关闭这一个
    [self hideIconWaitingMaskView:NO];
    
    // 生成模态的view
    UIView *alertMaskView = [[UIView alloc] initWithFrame: CGRectMake(0, 64, [UIScreen screenWidth], [UIScreen screenHeight] - 64)];
    // 模态view设置为透明色
    [alertMaskView setBackgroundColor:[UIColor whiteColor]];
    alertMaskView.tag = 1002;
    
    
    UIImageView* mainImageView= [[UIImageView alloc]initWithFrame:CGRectMake(alertMaskView.center.x - 80/2.0, alertMaskView.center.y - 61 - 64, 80, 61)];
    NSMutableArray * mutableArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < iconNumber; i++) {
        NSString* imageName = [NSString stringWithFormat:@"%@_%d",iconName, i];
        UIImage *imageView = [UIImage imageNamed:imageName];
        [mutableArr addObject:imageView];
    }
    mainImageView.animationImages = mutableArr;
    [mainImageView setAnimationDuration:(iconNumber/15.0)];
    [mainImageView setAnimationRepeatCount:0];
    [mainImageView startAnimating];
    [alertMaskView addSubview:mainImageView];
    
    [[XZCustomWindowManager shareManager] addCustomView:alertMaskView withType:XZCusomViewModelTypeHUD];
    
    DebugLog(@"TOOLS: Show Waiting Mask View...");
}

/**
 隐藏 循环icon图  形成等待页面  翻书样式为例
 
 @param isNeedWait 是否在移除等待界面的时候需要延迟0.5秒执行  根据自己项目需求决定  YES：延迟0.5秒   NO：不延迟直接执行移除
 */
+ (void)hideIconWaitingMaskView:(BOOL)isNeedWait{
    if (isNeedWait) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[XZCustomWindowManager shareManager] removeCustomViewWithType:XZCusomViewModelTypeHUD];
            
        });
        
    }else{
        [[XZCustomWindowManager shareManager] removeCustomViewWithType:XZCusomViewModelTypeHUD];
        
    }
}



/****************************************************************************************************************/

/**
 显示自动隐藏的提示窗口(图片+文字)
 
 @param string 提示框文字，如果不传则不显示
 @param image 提示框图片，如果不传则不显示
 @param duration 显示多长时间后消失
 */
+ (void)showAutoHidePromptView:(NSString *)string
                    background:(UIImage *)image
                      showTime:(float)duration
{
    [self showAutoHidePromptView:string background:image showTime:duration completion:nil];
}

/**
 显示自动隐藏的提示窗口(图片+文字)
 带回调   提示框消失后，会有block回调，以便于您在上层做些其他方面的处理
 
 @param string 提示框文字，如果不传则不显示
 @param image 提示框图片，如果不传则不显示
 @param duration 显示多长时间后消失
 */
+ (void)showAutoHidePromptView:(NSString*)string
                    background:(UIImage*)image
                      showTime:(float)duration
                    completion:(void(^)(void))completion
{
    
    //    [self hideAutoHidePromptView];
    
    DebugLog(@"TOOLS: showAutoHidePromptView: string = %@, image = %@, duration = %f", string, image, duration);
    
    // 获取所要显示的字需要占据的空间大小
    UIFont *font = [UIFont systemFontOfSize:18];
    //设定绘制字符串高和宽
    CGSize sizeString = [XZTool getSizeFromString:string withFont:font constrainedToSize:CGSizeMake(200, [UIScreen screenHeight])];
    
    float width = sizeString.width;
    float height = sizeString.height;
    // 创建要显示的View
    UIView *alertView = nil;
    UIImageView *imageView = nil;
    UILabel *label = nil;
    
    // Gray.Wang:2015.04.10: Fix Warning For Xcode 6.3
    UIDeviceOrientation faceOrientation = [[UIDevice currentDevice] orientation];
    
    //是否有图片显示
    if (image != nil) {
        //获取图文混排的高度和宽度
        float imageWidth = CGImageGetWidth(image.CGImage)/2;
        float imageHeight = CGImageGetHeight(image.CGImage)/2;
        //40是字图片和背景的间距X2
        float alertVieWidth = (width > imageWidth ? width : imageWidth) + 40;
        //20是字和图片的间距 40是字图片和背景的间距X2
        float alertVieHeight = height + imageHeight + 30 + 40;
        
        alertView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen screenWidth]-alertVieWidth)/2.0, ([UIScreen screenHeight] -alertVieHeight)/2.0, alertVieWidth, alertVieHeight)];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((alertVieWidth - imageWidth)/2.0, 20, imageWidth, imageHeight)];
        [imageView setImage:image];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake((alertVieWidth - sizeString.width)/2, 10 + imageHeight + 30, sizeString.width, sizeString.height)];
        
        if ([UIDevice iOSMajorVersion] < 8) {
            // 若是横屏则旋转90度。
            if (UIDeviceOrientationIsLandscape(faceOrientation)) {
                [alertView setTransform: CGAffineTransformMakeRotation(-M_PI / 2)];
            }
        }
    }
    else
    {
        alertView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen screenWidth]-width)/2.0 - 20, ([UIScreen screenHeight]-height)/2.0 - 20, width+40, height+40)];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake((alertView.frame.size.width - width)/2.0, (alertView.frame.size.height - height)/2.0, width, height)];
        
        if ([UIDevice iOSMajorVersion] < 8) {
            // 若是横屏则旋转90度。
            if (UIDeviceOrientationIsLandscape(faceOrientation)) {
                [alertView setTransform: CGAffineTransformMakeRotation(-M_PI / 2)];
            }
        }
    }
    //设置文字对齐方式
    [label setTextAlignment:NSTextAlignmentCenter];
    //设置文字大小
    [label setFont:font];
    //设置文本
    [label setText:string];
    //设置文字颜色
    [label setTextColor:[UIColor whiteColor]];
    //设置label背景色为透明
    [label setBackgroundColor:XZClearColor];
    //设置label可以换行
    label.numberOfLines = 0;
    //设置label换行方式
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    
    [alertView setBackgroundColor:[UIColor blackColor]];
    //设定圆角
    alertView.layer.cornerRadius = 7.5;
    alertView.layer.masksToBounds = YES;
    //设定此view透明度
    [alertView setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8]];
    alertView.tag = 1003;
    [alertView addSubview:label];
    if (imageView != nil) {
        [alertView addSubview:imageView];
    }
    
    [[XZCustomWindowManager shareManager] addCustomView:alertView withType:XZCusomViewModelTypeAutoHideView];
    
    __weak typeof (alertView) weakalertView = alertView;
    getWeakSelf
    //开始动画设置
    [UIView animateWithDuration:duration animations:^{
        weakalertView.alpha = 0.79;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakalertView.alpha = 0;
        } completion:^(BOOL finished) {
            [weakSelf hideAutoHidePromptView];
            if (completion) {
                completion();
            }
        }];
    }];
}


/****************************************************************************************************************/

/**
 去除等待提示窗口遮罩层
 */
+ (void)hideAutoHidePromptView
{
    [[XZCustomWindowManager shareManager] removeCustomViewWithType:XZCusomViewModelTypeAutoHideView];
}









@end
