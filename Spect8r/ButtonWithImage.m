//
//  ButtonWithImage.m
//  Vouchify
//
//  Created by Kostya on 11.10.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "ButtonWithImage.h"

@implementation ButtonWithImage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat shareImageViewWH = 12 * koef;
        CGFloat shareImageViewX = 6;
        CGFloat shareImageViewY = (self.height - shareImageViewWH) / 2;
        
        UIImageView *shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(shareImageViewX, shareImageViewY, shareImageViewWH, shareImageViewWH)];
        [shareImageView setContentMode:UIViewContentModeScaleAspectFit];
        [shareImageView setImage:[UIImage imageNamed:@"share"]];
        [self addSubview:shareImageView];
        
        CGFloat labelW = 50 * koef;
        CGFloat labelH = 18 * koef;
        CGFloat labelX = CGRectGetMaxX(shareImageView.frame) + 3;
        CGFloat labelY = (self.height - labelH) / 2;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        [label setFont:AppFont(kNavigationBarButtonsTitleFontSize)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:NSLocalizedString(@"SHARE", nil)];
        [self addSubview:label];
        
        CGRect frame = label.frame;
        frame.size.width = [label.text sizeWithAttributes:
                            @{NSFontAttributeName: AppFont(kNavigationBarButtonsTitleFontSize)}].width;
        label.frame = frame;
         
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        CGSize size = [label.text sizeWithAttributes:
                       @{NSFontAttributeName: AppFont(kNavigationBarButtonsTitleFontSize)}];
        
        frame = self.frame;
        frame.size.width = label.frame.size.width + shareImageView.frame.size.width + 15 * koef;
        frame.size.height = size.height + kNavigationBarButtonsTitleHeightOffset * 2;
        self.frame = frame;
        
        frame = shareImageView.frame;
        frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
        shareImageView.frame = frame;
        
        frame = label.frame;
        frame.origin.x = CGRectGetMaxX(shareImageView.frame) + 3;
        frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
        label.frame = frame;
        
        [MitimGlobalData setRoundedCornersToView:self radius:self.frame.size.height / 3.5];
        
    }
    return self;
}

@end
