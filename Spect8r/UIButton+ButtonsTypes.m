//
//  UIButton+RoundedNavigationBarButton.m
//  Vouchify
//
//  Created by attum on 5/6/16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "UIButton+ButtonsTypes.h"
#import "MitimGlobalData.h"
#import "ButtonWithImage.h"

@implementation UIButton (ButtonsTypes)

+ (UIButton *)navigationBarButtonItemWithText:(NSString *)text {
    CGRect frame = CGRectZero;
    CGSize size = [text sizeWithAttributes:
                  @{NSFontAttributeName: AppFont(kNavigationBarButtonsTitleFontSize)}];
    frame.size = CGSizeMake(size.width + kNavigationBarButtonsTitleWidthOffset * 2, size.height + kNavigationBarButtonsTitleHeightOffset * 2);
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:text forState:UIControlStateNormal];
    [button.titleLabel setFont:AppFont(kNavigationBarButtonsTitleFontSize)];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.userInteractionEnabled = true;
    [MitimGlobalData setRoundedCornersToView:button radius:frame.size.height / 3.5];
    return button;
}

+ (UIButton *)navigationShareBarButtonItem {
    ButtonWithImage* button = [[ButtonWithImage alloc] initWithFrame:CGRectZero];
    button.userInteractionEnabled = true;
    return button;
}

@end
