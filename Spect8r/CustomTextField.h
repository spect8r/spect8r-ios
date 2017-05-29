//
//  CustomTextField.h
//  Vouchify
//
//  Created by Kostya on 04.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitimGlobalData.h"

@interface CustomTextField : UITextField <UITextFieldDelegate>

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *) textFieldImage placeholder:(NSString *) textFieldText secureTextField:(BOOL) secureTextField editMode:(BOOL) editMode;

- (void)addImage;

@property UIImageView *textFieldImageView;

@property BOOL editMode;

@end
