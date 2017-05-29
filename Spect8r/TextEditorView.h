//
//  TextEditorView.h
//  Vouchify
//
//  Created by Kostya on 12.07.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "MitimBaseView.h"

@protocol TextEditorViewDelegate <NSObject>

- (void) clickedBoldButton;
- (void) clickedUnderlineButton;
- (void) clickedBulletButton;

@end

@interface TextEditorView : MitimBaseView <TextEditorViewDelegate>

@property (nonatomic, weak) id <TextEditorViewDelegate> delegate;

@end
