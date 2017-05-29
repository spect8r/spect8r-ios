//
//  ContactsButton.h
//  Vouchify
//
//  Created by Kostya on 07.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitimGlobalData.h"

@interface ContactsButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *) buttonImage buttonLabel:(NSString *) buttonLabel isRegistration:(BOOL) isRegistration hasSharedConnection:(BOOL) hasSharedConnection;

- (void) updateImage;
- (void) centerText;

@property UIImageView *buttonImageView;
@property UIImageView *userImageView;
@property UIImageView *followersImageView;
@property UIImageView *checkedImageView;

@property UILabel *connectNowLabel;
@property UILabel *buttonLabel;
@property UILabel *userLabel;
@property UILabel *followersLabel;

@property BOOL hasSharedConnection;

@end
