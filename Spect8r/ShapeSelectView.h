//
//  ShapeSelectView.h
//  MKDropdownMenuExample
//
//  Created by Max Konovalov on 18/03/16.
//  Copyright © 2016 Max Konovalov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShapeSelectView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *shapeView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property UIImage *icon, *selected_icon;
@property (assign, nonatomic) BOOL selected;

@end
