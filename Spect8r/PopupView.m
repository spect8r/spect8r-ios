//
//  PopupView.m
//  Vouchify
//
//  Created by Kostya on 10.10.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "PopupView.h"

@interface PopupView ()
{
    float currentY;
}

@property (nonatomic, weak) UIView *popupView;

@property (nonatomic, assign) PopupType type;

@end

@implementation PopupView

- (instancetype)initWithFrame:(CGRect)frame type:(PopupType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.type = type;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [backgroundView setUserInteractionEnabled:false];
        [self addSubview:backgroundView];
        
        if (type == PopupTypeLocation) {
            [backgroundView setBackgroundColor:UIColorFromRGBAndAlpha(0x4A4A4A, 0.2)];
        } else if (type == PopupTypeContact) {
            if (!UIAccessibilityIsReduceTransparencyEnabled()) {
                backgroundView.backgroundColor = [UIColor clearColor];
                
                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
                UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                blurEffectView.frame = backgroundView.bounds;
                blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [blurEffectView setAlpha:0];
                [backgroundView addSubview:blurEffectView];
                
                [UIView animateWithDuration:0.3 animations:^{
                    [blurEffectView setAlpha:1];
                }];
            } else {
                backgroundView.backgroundColor = [UIColor blackColor];
            }
        }
        
        CGFloat popupViewW = 0;
        CGFloat popupViewH = 0;
        if (type == PopupTypeContact) {
            popupViewW = 307 * koef;
            popupViewH = 305 * koef;
        }
        else if (type == PopupTypeLocation) {
            popupViewW = 292 * koef;
            popupViewH = 288 * koef;
        }
        CGFloat popupViewX = (self.width - popupViewW) / 2;
        CGFloat popupViewY = (self.height - popupViewH) / 2;
        
        UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(popupViewX, popupViewY, popupViewW, popupViewH)];
        [popupView setBackgroundColor:[UIColor whiteColor]];
        [MitimGlobalData setRoundedCornersToView:popupView radius:8 * koef];
        self.popupView = popupView;
        [self addSubview:self.popupView];
        
        if (type == PopupTypeLocation) currentY = 14 * koef;
        else if (type == PopupTypeContact) currentY = 20 * koef;
        
        if (type == PopupTypeLocation) [self createLogo];
        [self createTitleLabel];
        [self createTextLabel];
        if (type == PopupTypeLocation) [self createButtonsForLocation];
        else if (type == PopupTypeContact) {
            [self createButtonsForContacts];
            
            CGRect frame = self.popupView.frame;
            frame.size.height = currentY;
            frame.origin.y = (self.height - frame.size.height) / 2;
            self.popupView.frame = frame;
        }
    }
    return self;
}

- (void)createLogo {
    CGFloat logoW = 127 * koef;
    CGFloat logoH = 27 * koef;
    CGFloat logoX = (self.popupView.frame.size.width - logoW) / 2;
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(logoX, currentY, logoW, logoH)];
    [logo setContentMode:UIViewContentModeScaleAspectFit];
    [logo setImage:[UIImage imageNamed:@"logo"]];
    [self.popupView addSubview:logo];
    
    currentY += logoH + 27 * koef;
}

- (void)createTitleLabel {
    CGFloat labelW = 277 * koef;
    CGFloat labelH = 0;
    if (self.type == PopupTypeContact) labelH = 24 * koef;
    else if (self.type == PopupTypeLocation) labelH = 72 * koef;
    CGFloat labelX = (self.popupView.frame.size.width - labelW) / 2;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, currentY, labelW, labelH)];
    [label setFont:BoldAppFont(20 * koef)];
    [label setTextColor:UIColorFromRGB(0x515151)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [self.popupView addSubview:label];
    
    if (self.type == PopupTypeContact) {
        currentY += labelH + 14 * koef;
        [label setText:NSLocalizedString(@"ARE_YOU_SURE", nil)];
        [label setNumberOfLines:1];
    }
    else if (self.type == PopupTypeLocation) {
        currentY += labelH + 19 * koef;
        [label setText:NSLocalizedString(@"CUSTOM_POPUP_LOCATION_TITLE", nil)];
        [label setNumberOfLines:3];
    }
}

- (void)createTextLabel {
    CGFloat labelW = 274 * koef;
    CGFloat labelH = 0;
    if (self.type == PopupTypeContact) labelH = 95 * koef;
    else if (self.type == PopupTypeLocation) labelH = 39 * koef;
    CGFloat labelX = (self.popupView.frame.size.width - labelW) / 2;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, currentY, labelW, labelH)];
    [label setFont:AppFont(16 * koef)];
    [label setTextColor:UIColorFromRGB(0x515151)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [self.popupView addSubview:label];
    
    if (self.type == PopupTypeContact) {
        currentY += labelH + 30 * koef;
        [label setText:NSLocalizedString(@"CUSTOM_POPUP_CONTACT", nil)];
        [label setNumberOfLines:5];
    }
    else if (self.type == PopupTypeLocation) {
        currentY += labelH + 30 * koef;
        [label setText:NSLocalizedString(@"CUSTOM_POPUP_LOCATION", nil)];
        [label setNumberOfLines:2];
    }
}

- (void)createButtonsForLocation {
    CGFloat buttonW = 134 * koef;
    CGFloat buttonH = 38 * koef;
    CGFloat gap = (self.popupView.frame.size.width - buttonW * 2) / 3;
    
    CGFloat dontAllowButtonX = gap;
    CGFloat allowButtonX = buttonW + gap * 2;
    
    UIButton *dontAllowButton = [[UIButton alloc] initWithFrame:CGRectMake(dontAllowButtonX, currentY, buttonW, buttonH)];
    [[dontAllowButton titleLabel] setFont:BoldAppFont(18 * koef)];
    [dontAllowButton setTitleColor:UIColorFromRGB(0x515151) forState:UIControlStateNormal];
    [dontAllowButton setTitle:NSLocalizedString(@"DONT_ALLOW", nil) forState:UIControlStateNormal];
    [dontAllowButton setBackgroundColor:[UIColor whiteColor]];
    [[dontAllowButton layer] setBorderColor:[UIColorFromRGB(0x515151) CGColor]];
    [[dontAllowButton layer] setBorderWidth:1 * koef];
    [MitimGlobalData setRoundedCornersToView:dontAllowButton radius:buttonH / 2];
    [dontAllowButton addTarget:self action:@selector(dontAllowButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.popupView addSubview:dontAllowButton];
    
    UIButton *allowButton = [[UIButton alloc] initWithFrame:CGRectMake(allowButtonX, currentY, buttonW, buttonH)];
    [[allowButton titleLabel] setFont:BoldAppFont(18 * koef)];
    [allowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [allowButton setTitle:NSLocalizedString(@"ALLOW", nil) forState:UIControlStateNormal];
    [allowButton setBackgroundColor:BLUE_COLOR];
    [MitimGlobalData setRoundedCornersToView:allowButton radius:buttonH / 2];
    [allowButton addTarget:self action:@selector(allowButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.popupView addSubview:allowButton];
}

- (void)createButtonsForContacts {
    CGFloat buttonW = 254 * koef;
    CGFloat buttonH = 38 * koef;
    CGFloat buttonX = (self.popupView.frame.size.width - buttonW) / 2;
    CGFloat gap = 16 * koef;
    
    UIButton *allowButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, currentY, buttonW, buttonH)];
    [[allowButton titleLabel] setFont:BoldAppFont(18 * koef)];
    [allowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [allowButton setTitle:NSLocalizedString(@"CONNECT_FRIENDS", nil) forState:UIControlStateNormal];
    [allowButton setBackgroundColor:BLUE_COLOR];
    [MitimGlobalData setRoundedCornersToView:allowButton radius:buttonH / 2];
    [allowButton addTarget:self action:@selector(allowButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.popupView addSubview:allowButton];
    
    currentY += buttonH + gap;
    
    UIButton *dontAllowButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, currentY, buttonW, buttonH)];
    [[dontAllowButton titleLabel] setFont:BoldAppFont(18 * koef)];
    [dontAllowButton setTitleColor:UIColorFromRGB(0x515151) forState:UIControlStateNormal];
    [dontAllowButton setTitle:NSLocalizedString(@"DONT_CONNECT_FRIENDS", nil) forState:UIControlStateNormal];
    [dontAllowButton setBackgroundColor:[UIColor whiteColor]];
    [[dontAllowButton layer] setBorderColor:[UIColorFromRGB(0x515151) CGColor]];
    [[dontAllowButton layer] setBorderWidth:1 * koef];
    [MitimGlobalData setRoundedCornersToView:dontAllowButton radius:buttonH / 2];
    [dontAllowButton addTarget:self action:@selector(dontAllowButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.popupView addSubview:dontAllowButton];
    
    currentY += buttonH + gap;
}

- (void)dontAllowButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dontAllowButtonClickedWithType:)]) {
        [self.delegate dontAllowButtonClickedWithType:self.type];
    }
}

- (void)allowButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(allowButtonClickedWithType:)]) {
        [self.delegate allowButtonClickedWithType:self.type];
    }
}

@end
