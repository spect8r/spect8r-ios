//
//  CustomTextField.m
//  Vouchify
//
//  Created by Kostya on 04.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *) textFieldImage placeholder:(NSString *) textFieldText secureTextField:(BOOL) secureTextField editMode:(BOOL) editMode
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        
        self.editMode = editMode;
        
        CGFloat textFieldImageViewW = self.frame.size.width * 30 / 435;
        CGFloat textFieldImageViewH = textFieldImageViewW;
        CGFloat textFieldImageViewX = textFieldImageViewW;
        CGFloat textFieldImageViewY = (self.frame.size.height - textFieldImageViewH) / 2;
        
        CGFloat paddingW;
        if (textFieldImage) {
            paddingW = textFieldImageViewX  +textFieldImageViewW + 10;
        } else {
            paddingW = 20;
        }
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingW, 20)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        [MitimGlobalData setRoundedCornersToView:self radius:self.frame.size.height / 2];

        self.textFieldImageView = [[UIImageView alloc] initWithFrame:CGRectMake(textFieldImageViewX, textFieldImageViewY, textFieldImageViewW, textFieldImageViewH)];
        self.textFieldImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.textFieldImageView setImage:textFieldImage];
        [self addSubview:self.textFieldImageView];
        
        if (self.editMode == true) {
            [self setFont:AppFont(self.frame.size.height / 2.2)];
            self.placeholder = textFieldText;
            self.secureTextEntry = secureTextField;
            self.returnKeyType = UIReturnKeyDone;
            self.layer.borderWidth = 1;
            self.layer.borderColor = UIColorFromRGB(0xdcdcdc).CGColor;
        } else {
            [self setFont:BoldAppFont(self.frame.size.height / 2.5)];
            UIColor *color = [UIColor darkGrayColor];
            if (textFieldText) self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textFieldText attributes:@{NSForegroundColorAttributeName: color}];
            [self setUserInteractionEnabled:false];
        }
        
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
        [theTextField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
    return YES;
}

- (void)addImage {
    [self.textFieldImageView setImage:[UIImage imageNamed:@"arrowIcon"]];
    CGRect frame = self.textFieldImageView.frame;
    frame.size.width = self.frame.size.width * 20 / 435;
    frame.size.height = frame.size.width;
    frame.origin.x = self.frame.size.width - frame.size.width * 2;
    frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
    self.textFieldImageView.frame = frame;
}

@end
