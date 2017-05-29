//
//  MitimBaseAlertView.m
//  ForestResque
//
//  Created by Mykhailo Timashov on 1/16/16.
//  Copyright © 2016 Mitim Games. All rights reserved.
//

#import "MitimBaseAlertView.h"

@implementation MitimBaseAlertView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    if (self) {
//        self.backgroundBlurView = [[FXBlurView alloc] initWithFrame:self.bounds];
//        [self.backgroundBlurView setDynamic:YES];
//        [self.backgroundBlurView setUserInteractionEnabled:true];


        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [self.backgroundView setBackgroundColor:UIColorFromRGB(0x000000)];
        [self.backgroundView setUserInteractionEnabled:true];
    }
    return self;
}

- (void) addContentView:(UIView*)contentView{
    CGRect frame = contentView.frame;
    frame.origin.x = (self.frame.size.width - frame.size.width)/2;
    frame.origin.y = (self.frame.size.height - frame.size.height)/2;
    contentView.frame = frame;
    
    self.contentView = contentView;
}

- (void) show {
    [self.backgroundView setAlpha:0];
    [self addSubview:self.backgroundView];
//    [self.backgroundBlurView setAlpha:0];
//    [self addSubview:self.backgroundBlurView];

    
    CGRect newContentViewFrame;
    if (self.contentView){
        newContentViewFrame = self.contentView.frame;
        
        CGRect frame = self.contentView.frame;
        frame.origin.x -= self.width;
        self.contentView.frame = frame;
        
        [self addSubview:self.contentView];
    }
    
    [UIView animateWithDuration:MitimBaseAlertViewAnimationTime animations:^{
        [self.backgroundView setAlpha:0.5];
//        [self.backgroundBlurView setAlpha:1];
        if (self.contentView){
            self.contentView.frame = newContentViewFrame;
        }
    }];
}

- (void) hide {
    [UIView animateWithDuration:MitimBaseAlertViewAnimationTime animations:^{
        [self.backgroundView setAlpha:0];
//        [self.backgroundBlurView setAlpha:0];
        if (self.contentView){
            CGRect frame = self.contentView.frame;
            frame.origin.x += self.width;
            self.contentView.frame = frame;
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void) hideWithoutAnimation {
    [self removeFromSuperview];
}

- (void) dismiss {
    [self hide];
}

- (void) dismissWithoutAnimation {
    [self hideWithoutAnimation];
}

- (CGFloat) getDefaultContentWidth{
    return IS_IPAD ? (self.width * 0.7) : (self.width * 0.93);
}



- (void) showWithAnim1{
//    [self.backgroundBlurView setAlpha:0];
//    [self addSubview:self.backgroundBlurView];
    [self.backgroundView setAlpha:0];
    [self addSubview:self.backgroundView];
    
    [UIView animateWithDuration:MitimBaseAlertViewAnimationTime animations:^{
//        [self.backgroundBlurView setAlpha:1];
        [self.backgroundView setAlpha:0.5];
    }];
    
    NSLog(@"self.contentView = %@",self.contentView);
    if (self.contentView){
        [self addSubview:self.contentView];
        
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        }
        completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                }
                completion:^(BOOL finishedTwo){
                    if (finishedTwo) {
                        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
                        }
                        completion:^(BOOL finishedTree) {
                            if (finishedTree) {
                                [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                }
                                completion:^(BOOL finished) {
                                }];
                            }
                        }];
                    }
                }];
            }
        }];
    }
}

- (void) hideWithAnim1 {
    [UIView animateWithDuration:MitimBaseAlertViewAnimationTime animations:^{
        [self.backgroundView setAlpha:0];
        [self.contentView setAlpha:0];        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
