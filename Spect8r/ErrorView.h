//
//  ErrorView.h
//  Vouchify
//
//  Created by Mykhailo Timashov on 3/10/16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitimBaseView.h"

@interface ErrorView : MitimBaseView

- (instancetype)initWithFrame:(CGRect)frame errorMessage:(NSString*)errorMessage;


@end
