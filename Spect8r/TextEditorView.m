//
//  TextEditorView.m
//  Vouchify
//
//  Created by Kostya on 12.07.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "TextEditorView.h"

@interface TextEditorView ()

@property (nonatomic, weak) UIButton *boldButton;
@property (nonatomic, weak) UIButton *underlineButton;
@property (nonatomic, weak) UIButton *bulletButton;

@end

@implementation TextEditorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        CALayer *topBorder = [CALayer layer];
        topBorder.frame = CGRectMake(0.0f, 0.0f, self.width, 1.0f);
        topBorder.backgroundColor = [UIColor grayColor].CGColor;
        [self.layer addSublayer:topBorder];
        
        CGFloat insetSize = self.width * 0.02;
        UIEdgeInsets insets = UIEdgeInsetsMake(insetSize, insetSize, insetSize, insetSize);
        
        CGFloat gap = self.width * 0.1;
        CGFloat buttonWH = self.height * 0.9;
        CGFloat buttonY = (self.height - buttonWH) / 2;
        CGFloat underlineButtonX = (self.width - buttonWH) / 2;
        CGFloat boldButtonX = underlineButtonX - buttonWH - gap;
        CGFloat bulletButtonX = underlineButtonX + buttonWH + gap;
        
        UIButton *boldButton = [[UIButton alloc] initWithFrame:CGRectMake(boldButtonX, buttonY, buttonWH, buttonWH)];
        [boldButton setImage:[UIImage imageNamed:@"bold"] forState:UIControlStateNormal];
        [boldButton addTarget:self action:@selector(clickedBoldButton:) forControlEvents:UIControlEventTouchUpInside];
        [boldButton setImageEdgeInsets:insets];
        self.boldButton = boldButton;
        [self addSubview:self.boldButton];
        
        UIButton *underlineButton = [[UIButton alloc] initWithFrame:CGRectMake(underlineButtonX, buttonY, buttonWH, buttonWH)];
        [underlineButton setImage:[UIImage imageNamed:@"underline"] forState:UIControlStateNormal];
        [underlineButton addTarget:self action:@selector(clickedUnderlineButton:) forControlEvents:UIControlEventTouchUpInside];
        [underlineButton setImageEdgeInsets:insets];
        self.underlineButton = underlineButton;
        [self addSubview:self.underlineButton];
        
        UIButton *bulletButton = [[UIButton alloc] initWithFrame:CGRectMake(bulletButtonX, buttonY, buttonWH, buttonWH)];
        [bulletButton setImage:[UIImage imageNamed:@"bullet"] forState:UIControlStateNormal];
        [bulletButton addTarget:self action:@selector(clickedBulletButton:) forControlEvents:UIControlEventTouchUpInside];
        [bulletButton setImageEdgeInsets:insets];
        self.bulletButton = bulletButton;
        [self addSubview:self.bulletButton];
    }
    return self;
}

- (void) clickedBoldButton:(id)sender {
    [self clickedBoldButton];
}

- (void) clickedUnderlineButton:(id)sender {
    [self clickedUnderlineButton];
}

- (void) clickedBulletButton:(id)sender {
    [self clickedBulletButton];
}

- (void) clickedBoldButton {
    if (self.delegate) [self.delegate clickedBoldButton];
}

- (void) clickedUnderlineButton {
    if (self.delegate) [self.delegate clickedUnderlineButton];
}

- (void) clickedBulletButton {
    if (self.delegate) [self.delegate clickedBulletButton];
}

@end
