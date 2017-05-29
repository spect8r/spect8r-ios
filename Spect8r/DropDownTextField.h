//
//  DropDownTextField.h
//  Vouchify
//
//  Created by Kostya on 21.04.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "IQDropDownTextField.h"
#import "IQDropDownTextField+SelectRow.h"
#import "MitimGlobalData.h"

@interface DropDownTextField : IQDropDownTextField

- (void) setActive:(BOOL)isActive;
- (void) hideArrow:(BOOL) isHide;

- (instancetype)initWithFrame:(CGRect)frame arrowDownImage:(UIImage *)arrowDownImage arrowUpImage:(UIImage *)arrowUpImage;

@property UIImageView *arrowImageView;

@property UIImage *arrowDownImage;
@property UIImage *arrowUpImage;

@property BOOL isActive;
@property BOOL isAddBusiness;

@end
