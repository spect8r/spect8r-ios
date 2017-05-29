//
//  ContactsButton.m
//  Vouchify
//
//  Created by Kostya on 07.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "ContactsButton.h"
#import "UILabel+dynamicSizeMe.h"

@implementation ContactsButton

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *) buttonImage buttonLabel:(NSString *) buttonLabel isRegistration:(BOOL) isRegistration hasSharedConnection:(BOOL) hasSharedConnection
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat buttonImageViewW = self.frame.size.width * 142 / 760;
        CGFloat buttonImageViewH = buttonImageViewW;
        CGFloat buttonImageViewX = 0;
        CGFloat buttonImageViewY = (self.frame.size.height - buttonImageViewH) / 2;
        
        self.buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(buttonImageViewX, buttonImageViewY, buttonImageViewW, buttonImageViewH)];
        [self.buttonImageView setImage:buttonImage];
        [self addSubview:self.buttonImageView];
        
        CGFloat buttonLabelW = self.frame.size.width - buttonImageViewW - self.frame.size.width * 0.05 - self.frame.size.width * 100 / 760;
        CGFloat buttonLabelX = buttonImageViewW + self.frame.size.width * 0.05;
        CGFloat buttonLabelH = self.frame.size.height / 2;
        CGFloat buttonLabelY = 0;
        
        self.buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonLabelX, buttonLabelY, buttonLabelW, buttonLabelH)];
        [self.buttonLabel setText:buttonLabel];
        [self.buttonLabel setFont:BoldAppFont(buttonLabelH / 2)];
        [self.buttonLabel setTextColor:UIColorFromRGB(0x555555)];
        [self.buttonLabel resizeToFit];
        [self addSubview:self.buttonLabel];
        
        if (isRegistration) {
            if (hasSharedConnection == false) {
                CGFloat connectNowLabelW = self.frame.size.width * 0.4;
                CGFloat connectNowLabelH = self.frame.size.height / 3;
                CGFloat connectNowLabelX = buttonImageViewW + self.frame.size.width * 0.05;
                CGFloat connectNowLabelY = buttonImageViewY + buttonImageViewH - connectNowLabelH;
                
                self.connectNowLabel = [[UILabel alloc] initWithFrame:CGRectMake(connectNowLabelX, connectNowLabelY, connectNowLabelW, connectNowLabelH)];
                [self.connectNowLabel setFont:BoldAppFont(connectNowLabelH * 0.55)];
                [self.connectNowLabel setTextColor:UIColorFromRGB(0x555555)];
                [self.connectNowLabel setText:NSLocalizedString(@"CONNECT_NOW", nil)];
                [MitimGlobalData setRoundedCornersToView:self.connectNowLabel radius:connectNowLabelH / 2];
                [self.connectNowLabel setBackgroundColor:UIColorFromRGB(0xE8E8E8)];
                [self.connectNowLabel setTextAlignment:NSTextAlignmentCenter];
                [self addSubview:self.connectNowLabel];
            } else {
                CGRect frame = self.buttonLabel.frame;
                frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
                self.buttonLabel.frame = frame;
            }
        } else {
            CGRect frame = self.buttonLabel.frame;
            frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
            self.buttonLabel.frame = frame;
        }
        
        CGFloat arrowImageViewW = self.frame.size.width * 100 / 760;
        CGFloat arrowImageViewH = arrowImageViewW / 1.5;
        CGFloat arrowImageViewX = self.frame.size.width - arrowImageViewW;
        CGFloat arrowImageViewY = (self.frame.size.height - arrowImageViewH) / 2;
        
        self.checkedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(arrowImageViewX, arrowImageViewY, arrowImageViewW, arrowImageViewH)];
        if (isRegistration) {
            [self.checkedImageView setImage:[UIImage imageNamed:@"checked"]];
        } else {
            [self.checkedImageView setImage:[UIImage imageNamed:@"arrowIcon"]];
        }
        self.checkedImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.checkedImageView];
        if (hasSharedConnection == false) self.checkedImageView.hidden = true;
        
        self.hasSharedConnection = false;
    
    }
    return self;
}

- (void) updateImage {
    if (self.checkedImageView) {
        self.hasSharedConnection = true;
        self.checkedImageView.hidden = false;
        if (self.connectNowLabel) self.connectNowLabel.hidden = true;
    }
}

- (void) centerText {
    CGRect frame = self.buttonLabel.frame;
    frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
    self.buttonLabel.frame = frame;
}

@end
