//
//  MitimBaseAlertView.h
//  ForestResque
//
//  Created by Mykhailo Timashov on 1/16/16.
//  Copyright © 2016 Mitim Games. All rights reserved.
//

#import "MitimBaseView.h"

#define MitimBaseAlertViewAnimationTime 0.7

@interface MitimBaseAlertView : MitimBaseView

@property UIView *backgroundView;
//@property FXBlurView *backgroundBlurView;
@property UIView *contentView;

- (void) show;
- (void) hide;
- (void) hideWithoutAnimation;
- (void) dismiss;
- (void) dismissWithoutAnimation;

- (void) addContentView:(UIView*)contentView;

- (CGFloat) getDefaultContentWidth;

- (void) showWithAnim1;
- (void) hideWithAnim1;

@end
