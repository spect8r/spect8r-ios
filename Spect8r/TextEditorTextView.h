//
//  TextEditorTextView.h
//  Vouchify
//
//  Created by Kostya on 13.07.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextEditorView.h"

@protocol TextEditorTextViewDelegate <NSObject>

- (void) updateTextViewHeights:(UITextView *) textView;

@end

@interface TextEditorTextView : UITextView <TextEditorViewDelegate, TextEditorTextViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize screenWidth:(CGFloat)screenWidth;

- (NSString *) encodeToHTML:(NSAttributedString *) attributedString;
- (NSAttributedString *) decodeFromHTMLWithString:(NSString *) string;
- (void) bulletsReturn;

@property (nonatomic, weak) id <TextEditorTextViewDelegate> thisDelegate;

@end
