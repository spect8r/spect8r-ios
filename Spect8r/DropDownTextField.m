//
//  DropDownTextField.m
//  Vouchify
//
//  Created by Kostya on 21.04.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "DropDownTextField.h"
#import "IQKeyBoardManager/IQKeyboardManager.h"

@implementation DropDownTextField

- (instancetype)initWithFrame:(CGRect)frame arrowDownImage:(UIImage *)arrowDownImage arrowUpImage:(UIImage *)arrowUpImage
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrowUpImage = arrowUpImage;
        self.arrowDownImage = arrowDownImage;
        
        CGFloat arrowImageViewW = self.frame.size.width * 33 / 575;
        CGFloat arrowImageViewH = arrowImageViewW * 13 / 33;
        CGFloat arrowImageViewX = self.frame.size.width - arrowImageViewW - self.frame.size.width * 0.05;
        CGFloat arrowImageViewY = (self.frame.size.height - arrowImageViewH) / 2;
        
        CGFloat paddingViewW = self.frame.size.width - arrowImageViewX + self.frame.size.width * 0.04;
        CGFloat paddingViewH = self.frame.size.height;
        CGFloat paddingViewX = self.frame.size.width - paddingViewW;
        CGFloat paddingViewY = 0;
        
        UIView *rightPaddingView = [[UIView alloc] initWithFrame:CGRectMake(paddingViewX, paddingViewY, paddingViewW, paddingViewH)];
        rightPaddingView.userInteractionEnabled = false;
        self.rightView = rightPaddingView;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, paddingViewY, self.frame.size.width * 0.05, paddingViewH)];
        leftPaddingView.userInteractionEnabled = false;
        self.leftView = leftPaddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(arrowImageViewX, arrowImageViewY, arrowImageViewW, arrowImageViewH)];
        [self.arrowImageView setImage:arrowDownImage];
        self.arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.arrowImageView];
        
        [self setFont:AppFont(self.frame.size.height / 2.5)];
        [self setTextColor:UIColorFromRGB(0x636363)];
        
        [self addTarget:self.delegate action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self.delegate action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return self;
}

- (void) setActive:(BOOL)isActive {
    self.isActive = isActive;
    if (isActive) {
        [self.arrowImageView setImage:self.arrowUpImage];
        [self setBackgroundColor:[UIColor whiteColor]];
    } else {
        [self.arrowImageView setImage:self.arrowDownImage];
        [self setBackgroundColor:UIColorFromRGB(0xf7f7f7)];
    }
    if (self.isAddBusiness) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

- (void) hideArrow:(BOOL) isHide {
    if (isHide) {
        self.arrowImageView.hidden = true;
    } else {
        self.arrowImageView.hidden = false;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

@end
