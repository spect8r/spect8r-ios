//
//  StandartTextField.m
//  Vouchify
//
//  Created by Kostya on 07.10.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "StandartTextField.h"
#import "MitimGlobalData.h"

@implementation StandartTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [MitimGlobalData setRoundedCornersToView:self radius:frame.size.height / 2];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setFont:AppFont(frame.size.height / 2.5)];
        [self setTextColor:UIColorFromRGB(0x636363)];
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColorFromRGB(0xFFFFFF).CGColor;
        
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.frame.size.width * 0.06, 10);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.frame.size.width * 0.06, 10);
}

@end
