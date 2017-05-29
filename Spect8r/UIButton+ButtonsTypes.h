//
//  UIButton+RoundedNavigationBarButton.h
//  Vouchify
//
//  Created by attum on 5/6/16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ButtonsTypes)

+ (UIButton*) navigationBarButtonItemWithText:(NSString*) text;
+ (UIButton *)navigationShareBarButtonItem;

@end
