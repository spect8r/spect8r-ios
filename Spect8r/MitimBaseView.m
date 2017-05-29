//
//  MitimBaseView.m
//  100
//
//  Created by Mykhailo Timashov on 5/24/15.
//  Copyright (c) 2015 Mitim Games. All rights reserved.
//

#import "MitimBaseView.h"

@implementation MitimBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.width = frame.size.width;
        self.height = frame.size.height;
        
    }
    return self;
}

@end
