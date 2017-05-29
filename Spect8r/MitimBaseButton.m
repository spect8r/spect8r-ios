//
//  MitimBaseButton.m
//  100
//
//  Created by Mykhailo Timashov on 5/25/15.
//  Copyright (c) 2015 Mitim Games. All rights reserved.
//

#import "MitimBaseButton.h"

@implementation MitimBaseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = frame.size.width;
        self.height = frame.size.height;
        [MitimGlobalData setRoundedCornersToButton:self];
    }
    return self;
}

@end
