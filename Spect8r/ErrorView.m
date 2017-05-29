//
//  ErrorView.m
//  Vouchify
//
//  Created by Mykhailo Timashov on 3/10/16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "ErrorView.h"
#import "MitimGlobalData.h"

@implementation ErrorView

- (instancetype)initWithFrame:(CGRect)frame errorMessage:(NSString*)errorMessage
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [errorLabel setTextAlignment:NSTextAlignmentCenter];
        [errorLabel setTextColor:[UIColor redColor]];
        [errorLabel setFont:AppFont(self.height * 0.25)];
        [errorLabel setNumberOfLines:2];
        [errorLabel setText:errorMessage];
        [self addSubview:errorLabel];
        
        
        [MitimGlobalData setTimeout:^{
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        } time:3000];
    }
    return self;
}

@end
