//
//  MitimAlertView.m
//
// Copyright (c) 2013 Darktt
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MitimAlertView.h"
#import <QuartzCore/QuartzCore.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000

#define MitimAlertTextAlignmentCenter   NSTextAlignmentCenter

#else

#define MitimAlertTextAlignmentCenter   UITextAlignmentCenter

#endif

// Macros
#define kDefaultBGColor [UIColor blackColor]
#define kDefaultAutoResizeMask UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin

// Tags
#define kAlertBackgroundTag     1000

#define kTitleLableTag          2001
#define kMessageLabelTag        2002
#define kPercentageTag          2006

#define kButtonBGViewTag        2099

#pragma mark - Implement MitimAlertBackgroundView Class

@interface MitimAlertBackgroundView : UIView
{
    UIWindow *previousKeyWindow;
    UIWindow *alertWindow;
    NSMutableArray *alertViews;
}

+ (MitimAlertInstancetype)currentBackground;
- (NSArray *)allAlertView;

@end

static MitimAlertBackgroundView *singletion = nil;

@implementation MitimAlertBackgroundView

+ (MitimAlertInstancetype)currentBackground
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletion = [MitimAlertBackgroundView new];
    });
    
    return singletion;
}

- (id)init
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self == nil) return nil;
    
    [self setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.5f]];
    [self setAlpha:0];
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:1];
    }];
    
    previousKeyWindow = [[UIApplication sharedApplication] keyWindow];
    
    alertWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [alertWindow setWindowLevel:UIWindowLevelAlert];
    [alertWindow setBackgroundColor:[UIColor clearColor]];
    [alertWindow addSubview:self];
    [alertWindow makeKeyAndVisible];
    
    alertViews = [NSMutableArray new];
    
    [self setHidden:YES];
    
    return self;
}

- (NSArray *)allAlertView
{
    return alertViews;
}

- (void)setAlpha:(CGFloat)alpha
{
    if (alertViews.count > 0) {
        alpha = 1.0f;
    }
    
    [super setAlpha:alpha];
}

- (void)setHidden:(BOOL)hidden
{
    if (alertViews.count > 0) {
        hidden = NO;
    }
    
    [super setHidden:hidden];
    
    [alertWindow setHidden:hidden];
    
    if (hidden) {
        [alertWindow resignKeyWindow];
        [previousKeyWindow makeKeyWindow];
    } else {
        [previousKeyWindow resignKeyWindow];
        [alertWindow makeKeyWindow];
    }
    
    [self setAlpha:1.0f];
}

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    
    MitimAlertView *alertView = alertViews.lastObject;
    [alertView setHidden:YES];
    
    if ([view isKindOfClass:[MitimAlertView class]]) {
        [alertViews addObject:view];
    }
}

- (void)willRemoveSubview:(UIView *)subview
{
    [super willRemoveSubview:subview];
    
    if ([subview isKindOfClass:[MitimAlertView class]]) {
        [alertViews removeObject:subview];
    }
    
    MitimAlertView *alertView = alertViews.lastObject;
    [alertView setHidden:NO];
}

@end

#pragma mark - Implement MitimAlertView Class

const static CGFloat kMotionEffectExtent = 30.0f;

@interface MitimAlertView ()
{
    MitimAlertViewAnimation _animationWhenDismiss;
    
    // Button Titles
    
    // Back ground
    UIView *_backgroundView;
    UIToolbar *_blurToolbar;
    
    BOOL _visible;
    BOOL _keyboardIsShown;
    
    BOOL _showForInputPassword;
}

@end

@implementation MitimAlertView

+ (MitimAlertInstancetype)alertViewWithAppFrame:(CGRect)appFrame
{
    MitimAlertView *alertView = [[MitimAlertView alloc] initWithAppFrame:(CGRect)appFrame];
    
    return alertView;
}

- (MitimAlertInstancetype)initWithAppFrame:(CGRect)appFrame
{
    self = [super init];
    
    if (self == nil) return nil;
    [self setMotionEffect];
    
    _backgroundView = nil;
    _visible = NO;
    
    _keyboardIsShown = NO;
    
    _showForInputPassword = NO;
    
    self.appFrame = appFrame;
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_blurToolbar != nil) {
        [_blurToolbar setFrame:self.bounds];
    }
    
}

#pragma mark - Property Methods

- (void)setDismissAnimationWhenButtonClicked:(MitimAlertViewAnimation)dismissAnimationWhenButtonClicked
{
    _animationWhenDismiss = dismissAnimationWhenButtonClicked;
}

- (MitimAlertViewAnimation)dismissAnimationWhenButtonClicked
{
    return _animationWhenDismiss;
}

- (BOOL)isVisible
{
    return _visible;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    [self.layer setCornerRadius:cornerRadius];
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (backgroundView == nil) {
        [self setBackgroundColor:kDefaultBGColor];
        
        _backgroundView = nil;
        
        return;
    }
    
    if ([_backgroundView isEqual:backgroundView]) {
        return;
    }

    [self setBackgroundColor:[UIColor clearColor]];
    
    [_backgroundView setFrame:self.bounds];
    
    [self insertSubview:_backgroundView atIndex:0];
}

- (UIView *)backgroundView
{
    
    return _backgroundView;
}

#pragma mark - Instance Methods

#pragma mark Blur Background

- (void)setBlurBackgroundWithColor:(UIColor *)color alpha:(CGFloat)alpha
{
    if (_blurToolbar == nil) {
        // Add alpha into color
        color = [color colorWithAlphaComponent:alpha];
        
        // Set blur use toolBar create it.
        _blurToolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
        [_blurToolbar setBarTintColor:color];
        
        [self.layer insertSublayer:_blurToolbar.layer atIndex:0];
    }
}

#pragma mark Show Alert View Methods

- (void)show
{
    [self showWithAnimation:MitimAlertViewAnimationDefault];
}

- (void)showForPasswordInputWithAnimation:(MitimAlertViewAnimation)animation;
{
    _showForInputPassword = YES;
    
    [self showWithAnimation:animation];
}

- (void)showWithAnimation:(MitimAlertViewAnimation)animation
{
    // If background color or background view not set, will set to default scenario.
    if (self.backgroundColor == nil && _backgroundView == nil) {
        
        if ([UIToolbar instancesRespondToSelector:@selector(setBarTintColor:)]) {
            [self setBlurBackgroundWithColor:nil alpha:0];
        } else {
            [self setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
    if (self.layer.cornerRadius == 0.0f) {
        [self.layer setCornerRadius:5.0f];
    }
    
    [self setViews];

    // Rotate self befoure show.
    CGFloat angle = [self angleForCurrentOrientation];
    [self setTransform:CGAffineTransformMakeRotation(angle)];
    
    // Background of alert view
    MitimAlertBackgroundView *backgroundView = [MitimAlertBackgroundView currentBackground];
    [backgroundView setHidden:NO];
    
    [self setCenter:backgroundView.center];
    [backgroundView addSubview:self];
    
    CAAnimation *showsAnimation = nil;
    
    switch (animation) {
        case MitimAlertViewAnimationDefault:
            showsAnimation = [self defaultShowsAnimation];
            break;
            
        case MitimAlertViewAnimationSlideTop:
            showsAnimation = [self sildeInBottomAnimation];
            break;
            
        case MitimAlertViewAnimationSlideBottom:
            showsAnimation = [self sildeInTopAnimation];
            break;
            
        case MitimAlertViewAnimationSlideLeft:
            // Slide in from right of screen.
            showsAnimation = [self sildeInRightAnimation];
            break;
            
        case MitimAlertViewAnimationSlideRight:
            // Slide in from left of screen.
            showsAnimation = [self sildeInLeftAnimation];
            break;
            
        default:
            NSLog(@"MitimAlertViewAnimation style error!!");
            break;
    }
    
    [self.layer addAnimation:showsAnimation forKey:@"popup"];
    
    [self performSelector:@selector(showsCompletion) withObject:nil afterDelay:showsAnimation.duration];
    
    // Receive notification for handle rotate issue
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotationHandle:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    

}

- (void)showsCompletion
{
    _visible = YES;
}

#pragma mark Dismiss Alert View Method

+ (BOOL)dismissAllAlertView
{
    NSArray *alertViews = [[MitimAlertBackgroundView currentBackground] allAlertView];
    
    if (alertViews.count == 0) {
        return NO;
    }
    
    [alertViews enumerateObjectsUsingBlock:^(MitimAlertView *alertView, NSUInteger idx, BOOL *stop) {
        [alertView dismiss];
    }];
    
    return YES;
}

- (void)dismiss
{
    [self dismissWithAnimation:MitimAlertViewAnimationDefault];
}

- (void)dismissWithAnimation:(MitimAlertViewAnimation)animation
{
    // Remove notification for rotate
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];

    if (_keyboardIsShown) {
        [_textField resignFirstResponder];
        
        // Remove notification
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    }
    
    CAAnimation *dismissAnimation = nil;
    
    switch (animation) {
        case MitimAlertViewAnimationDefault:
            dismissAnimation = [self defaultDismissAnimation];
            break;
            
        case MitimAlertViewAnimationSlideTop:
            dismissAnimation = [self sildeOutTopAnimation];
            break;
            
        case MitimAlertViewAnimationSlideBottom:
            dismissAnimation = [self sildeOutBottomAnimation];
            break;
            
        case MitimAlertViewAnimationSlideLeft:
            // Slide out to left of screen.
            dismissAnimation = [self sildeOutLeftAnimation];
            break;
            
        case MitimAlertViewAnimationSlideRight:
            // Slide out to right of screen.
            dismissAnimation = [self sildeOutRightAnimation];
            break;
            
        default:
            NSLog(@"MitimAlertViewAnimation style error!!");
            break;
    }
    
    [self.layer removeAllAnimations];
    [self.layer addAnimation:dismissAnimation forKey:@"dismiss"];
    
    [self performSelector:@selector(dismissCompletion) withObject:nil afterDelay:dismissAnimation.duration];
}

- (void)dismissWithoutAnimation
{
    // Remove notification for rotate
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    if (_keyboardIsShown) {
        [_textField resignFirstResponder];
        
        // Remove notification
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    }
    
    [self.layer removeAllAnimations];
    
    [self dismissCompletion];
}

- (void)dismissCompletion
{
    // Dismiss self
    [self removeFromSuperview];
    
    [UIView animateWithDuration:0.2f animations:^{
        [[MitimAlertBackgroundView currentBackground] setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [[MitimAlertBackgroundView currentBackground] setHidden:YES];
    }];
    
    // Remove dismiss animation
    [self.layer removeAllAnimations];
    
    _visible = NO;
    
}

#pragma mark Shake AlertView Method

- (void)shakeAlertView
{
    CAAnimation *shakeAnimation = [self shakeAnimation];
    
    [self.layer removeAllAnimations];
    [self.layer addAnimation:shakeAnimation forKey:@"Shake"];
}


#pragma mark - Set Views

- (void)setViews
{
}

- (UIButton *)setButtonWithTitle:(NSString *)buttonTitle
{
    UIColor *buttonColor = self.backgroundColor;
    
    if (buttonColor == nil) {
        buttonColor = [UIColor whiteColor];
    }
    
    UIColor *buttonTitleColor = [UIColor colorWithRed:0 green:122.0f/255.0f blue:1 alpha:1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:buttonColor];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [button setClipsToBounds:YES];
    
    return button;
}



- (void)renewLayout
{
    UILabel *titleLabel = (UILabel *)[self viewWithTag:kTitleLableTag];
    [titleLabel removeFromSuperview];
    titleLabel = nil;
    
    UILabel *messageLabel = (UILabel *)[self viewWithTag:kMessageLabelTag];
    [messageLabel removeFromSuperview];
    messageLabel = nil;
    
    [self setViews];
}

#pragma mark - Motion Effect Setting

- (void)setMotionEffect
{
    
    if (![self respondsToSelector:@selector(setMotionEffects:)]) {
        return;
    }
    
    UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                         type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    [xAxis setMinimumRelativeValue:@(-kMotionEffectExtent)];
    [xAxis setMaximumRelativeValue:@(kMotionEffectExtent)];
    
    UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                         type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    [yAxis setMinimumRelativeValue:@(-kMotionEffectExtent)];
    [yAxis setMaximumRelativeValue:@(kMotionEffectExtent)];
    
    UIMotionEffectGroup *motionEffect = [UIMotionEffectGroup new];
    [motionEffect setMotionEffects:@[xAxis, yAxis]];
    
    [self addMotionEffect:motionEffect];
}

#pragma mark - Default Animation

#define transformScale(scale) [NSValue valueWithCATransform3D:[self transform3DScale:scale]]

- (CATransform3D)transform3DScale:(CGFloat)scale
{
    // Add scale on current transform.
    CATransform3D currentTransfrom = CATransform3DScale(self.layer.transform, scale, scale, 1.0f);
    
    return currentTransfrom;
}

#define transformTranslateX(translate) [NSValue valueWithCATransform3D:[self transform3DTranslateX:translate]]
#define transformTranslateY(translate) [NSValue valueWithCATransform3D:[self transform3DTranslateY:translate]]

- (CATransform3D)transform3DTranslateX:(CGFloat)translate
{
    // Add scale on current transform.
    CATransform3D currentTransfrom = CATransform3DTranslate(self.layer.transform, translate, 1.0f, 1.0f);
    
    return currentTransfrom;
}

- (CATransform3D)transform3DTranslateY:(CGFloat)translate
{
    // Add scale on current transform.
    CATransform3D currentTransfrom = CATransform3DTranslate(self.layer.transform, 1.0f, translate, 1.0f);
    
    return currentTransfrom;
}

- (CAKeyframeAnimation *)animationWithValues:(NSArray*)values times:(NSArray*)times duration:(CGFloat)duration {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [animation setValues:values];
    [animation setKeyTimes:times];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setRemovedOnCompletion:NO];
    [animation setDuration:duration];
    
    return animation;
}

- (CGFloat)getMoveLengthForHeight
{
    CGFloat moveLength;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        moveLength = CGRectGetMidY([[MitimAlertBackgroundView currentBackground] bounds]) + CGRectGetMidY(self.bounds);
    } else {
        moveLength = CGRectGetMidX([[MitimAlertBackgroundView currentBackground] bounds]) + CGRectGetMidY(self.bounds);
    }
    
    return moveLength;
}

- (CGFloat)getMoveLengthForWidth
{
    CGFloat moveLength;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        moveLength = CGRectGetMidX([[MitimAlertBackgroundView currentBackground] bounds]) + CGRectGetMidX(self.bounds);
    } else {
        moveLength = CGRectGetMidY([[MitimAlertBackgroundView currentBackground] bounds]) + CGRectGetMidX(self.bounds);
    }
    
    return moveLength;
}

#pragma mark Show Animations

- (CAAnimation *)defaultShowsAnimation
{
    NSArray *frameValues = @[transformScale(0.1f), transformScale(1.15f), transformScale(0.9f), transformScale(1.0f)];
    NSArray *frameTimes = @[@(0.0f), @(0.5f), @(0.9f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.4f];
}

- (CAAnimation *)sildeInTopAnimation
{
    NSArray *frameValues = @[transformTranslateY(-800.0f), transformTranslateY(0.0f)];
    NSArray *frameTimes = @[@(0.0f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.8f];
}

- (CAAnimation *)sildeInBottomAnimation
{
    NSArray *frameValues = @[transformTranslateY(800.0f), transformTranslateY(0.0f)];
    NSArray *frameTimes = @[@(0.0f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.8f];
}

- (CAAnimation *)sildeInLeftAnimation
{
    NSArray *frameValues = @[transformTranslateX(-800.0f), transformTranslateX(0.0f)];
    NSArray *frameTimes = @[@(0.0f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.8f];
}

- (CAAnimation *)sildeInRightAnimation
{
    NSArray *frameValues = @[transformTranslateX(800.0f), transformTranslateX(0.0f)];
    NSArray *frameTimes = @[@(0.0f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.8f];
}

#pragma mark Dismiss Animations

- (CAAnimation *)defaultDismissAnimation
{
    NSArray *frameValues = @[transformScale(1.0f), transformScale(0.5f), transformScale(0.1f)];
    NSArray *frameTimes = @[@(0.0f), @(0.5f), @(1.0f)];
    
    CAKeyframeAnimation *animation = [self animationWithValues:frameValues times:frameTimes duration:0.25f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    return animation;
}

- (CAAnimation *)sildeOutTopAnimation
{
    CGFloat moveLength = [self getMoveLengthForHeight];
    
    NSArray *frameValues = @[transformTranslateY(0.0f), transformTranslateY(-moveLength)];
    NSArray *frameTimes = @[@(0.0f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.8f];
}

- (CAAnimation *)sildeOutBottomAnimation
{
    CGFloat moveLength = [self getMoveLengthForHeight];
    
    NSArray *frameValues = @[transformTranslateY(0.0f), transformTranslateY(moveLength)];
    NSArray *frameTimes = @[@(0.0f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.8f];
}

- (CAAnimation *)sildeOutLeftAnimation
{
    CGFloat moveLength = [self getMoveLengthForWidth];
    
    NSArray *frameValues = @[transformTranslateX(0.0f), transformTranslateX(-moveLength)];
    NSArray *frameTimes = @[@(0.0f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.8f];
}

- (CAAnimation *)sildeOutRightAnimation
{
    CGFloat moveLength = [self getMoveLengthForWidth];
    
    NSArray *frameValues = @[transformTranslateX(0.0f), transformTranslateX(moveLength)];
    NSArray *frameTimes = @[@(0.0f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.8f];
}

#pragma mark Shake Animations

- (CAAnimation *)shakeAnimation
{
    NSArray *frameValues = @[transformTranslateX(10.0f), transformTranslateX(-10.0f), transformTranslateX(6.0f), transformTranslateX(-6.0f),transformTranslateX(3.0f), transformTranslateX(-3.0f), transformTranslateX(0.0f)];
    NSArray *frameTimes = @[@(0.14f), @(0.28f), @(0.42f), @(0.57f), @(0.71f), @(0.85f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.5f];
}

#pragma mark - Rotation Handler

- (CGFloat)angleForCurrentOrientation {
    
	// Calculate a rotation transform that matches the current interface orientation.
	CGFloat angle = 0.0f;
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
	if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        angle = M_PI;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        angle = -M_PI_2;
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        angle = M_PI_2;
    }
    
	return angle;
}

- (void)rotationHandle:(NSNotification *)sender
{
    CGFloat angle = [self angleForCurrentOrientation];
        
    [self.layer removeAllAnimations];
    [self.layer setTransform:CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f)];
}

@end