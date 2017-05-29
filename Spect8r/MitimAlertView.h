//
//  MitimAlertView.h
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

#import <Foundation/Foundation.h>
#import "MitimGlobalData.h"

#if __has_feature(objc_instancetype)
#define MitimAlertInstancetype instancetype
#else
#define MitimAlertInstancetype id
#endif

@class MitimAlertView;
@protocol MitimAlertViewDelegate;

// enumerations
/** The mode of display to user. */


/** Type of show or dismiss animations. */
typedef NS_ENUM(NSInteger, MitimAlertViewAnimation) {
    /** Default animation. */
    MitimAlertViewAnimationDefault = 0,
    
    /** The alert view slide to top side. */
    MitimAlertViewAnimationSlideTop,
    
    /** The alert view slide to bottom side. */
    MitimAlertViewAnimationSlideBottom,
    
    /** The alert view slide to left side. */
    MitimAlertViewAnimationSlideLeft,
    
    /** The alert view slide to right side. */
    MitimAlertViewAnimationSlideRight,
};

/// Custom alert view solved the ios UIAlertView can't addSubview problem at iOS7.
@interface MitimAlertView : UIView


+ (MitimAlertInstancetype)alertViewWithAppFrame:(CGRect)appFrame;
- (MitimAlertInstancetype)initWithAppFrame:(CGRect)appFrame;
- (void)setViews;
- (void)dismissWithoutAnimation;

@property CGRect appFrame;


















/** Default is MitimAlertViewAnimationDefault. 
 *
 * @brief The dismiss animetion, when button clicked.
 *
 * @see MitimAlertViewAnimation
 */
@property (nonatomic, assign) MitimAlertViewAnimation dismissAnimationWhenButtonClicked;


/** @brief Check alert view is visible. */
@property (nonatomic, readonly, getter = isVisible) BOOL visible;

/** Defalt is nil, when alert view clicked, value is the clicked button title.
 *
 * @brief The button title of clicked button.
 */
@property (nonatomic, readonly) NSString *clickedButtonTitle;




// View settings
/** Defauls value 0.0, when shown is 25.0 if value not changed.
 *
 * @brief The corner radius dispaly in alert view background.
 */
@property (assign) CGFloat cornerRadius;

/** Default is nil. 
 *
 * @brief The background view display in alert view.
 */
@property (nonatomic, retain) UIView *backgroundView;

/** Default is nil on not shown. inital it at shown.<br/>
 * Only can get it when MitimAlertViewMode is MitimAlertViewModeTextInput.
 *
 * @brief The UITextField appears MitimAlertViewModeTextInput.
 */
@property (nonatomic, readonly) UITextField *textField;


/** @brief Set iOS7 style blur background color
 *
 * @param color The color of blur display color.
 * @param alpha The opacity value of the color object, specified as a value from 0.0 to 1.0.
 *
 * @warning This method only available iOS7.
 */
- (void)setBlurBackgroundWithColor:(UIColor *)color alpha:(CGFloat)alpha NS_AVAILABLE_IOS(7_0);

/* 
 * Shows *
 */
/// @brief Shows popup alert with default animation.
- (void)show;

/** See the descriptions of the constants of the MitimAlertViewAnimation type for more information.
 * @brief Shows popup alert for input pasword with receiver animation and would not dissmiss when click button.</br>
 * Want to dismiss this alert to use dismiss or dismissWithAnimation: .
 *
 * @param animation A constant to define what animation will show alert view.
 */
- (void)showForPasswordInputWithAnimation:(MitimAlertViewAnimation)animation;

/** See the descriptions of the constants of the MitimAlertViewAnimation type for more information.
 * @brief Shows popup alert with receiver animation.
 *
 * @param animation A constant to define what animation will show alert view.
 */
- (void)showWithAnimation:(MitimAlertViewAnimation)animation;

- (void)setBackgroundView:(UIView *)backgroundView;

/*
 * Dismiss *
 */

/** @brief Hide all alert.
 *
 *  @return If Yes is succed hide all alert view, No is failed hide alert view or no alert view is shown.
 */
+ (BOOL)dismissAllAlertView;

/// @brief Hide alert with default animation.
- (void)dismiss;

/** See the descriptions of the constants of the MitimAlertViewAnimation type for more information.
 * @brief Hide alert with receiver animation.
 *
 * @param animation A constant to define what animation will dismiss alert view.
 */
- (void)dismissWithAnimation:(MitimAlertViewAnimation)animation;

/// @brief The shake animation, appearance like password error animation on OS X.
- (void)shakeAlertView;

@end

@protocol MitimAlertViewDelegate  <NSObject>

/** @brief Sent to the delegate when the user clicks a button on an alert view.
 *
 * @param alertView The alert view containing the button.
 * @param buttonIndex The button index of clicked button, value 0 is cancel button, 1 is positive button.
 */
- (void)alertView:(MitimAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@optional

/** @brief Sent to the delegate before an alert view is dismissed.
 *
 * @param alertView The alert view that is about to be dismissed.
 */
- (void)alertViewWillDismiss:(MitimAlertView *)alertView;

/** @brief Sent to the delegate after an alert view is dismissed from the screen.
 *
 * @param alertView The alert view that was dismissed.
 */
- (void)alertViewDidDismiss:(MitimAlertView *)alertView;

/** @brief Sent to the delegate when textField text did change.
 *
 * @param alertView The alert view containing textField.
 */
- (void)alertViewTextDidChanged:(MitimAlertView *)alertView;
- (void) close;

@end
