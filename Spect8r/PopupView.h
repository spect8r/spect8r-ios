//
//  PopupView.h
//  Vouchify
//
//  Created by Kostya on 10.10.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "MitimBaseView.h"
#import "MitimBaseViewController.h"

@protocol PopupViewDelegate <NSObject>

- (void)dontAllowButtonClickedWithType:(PopupType)type;
- (void)allowButtonClickedWithType:(PopupType)type;

@end

@interface PopupView : MitimBaseView

- (instancetype)initWithFrame:(CGRect)frame type:(PopupType)type;

@property (nonatomic, weak) id<PopupViewDelegate> delegate;

@end
