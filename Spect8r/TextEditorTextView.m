//
//  TextEditorTextView.m
//  Vouchify
//
//  Created by Kostya on 13.07.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "TextEditorTextView.h"

@interface TextEditorTextView ()
{
    float thisFontSize;
}

@end

@implementation TextEditorTextView

- (instancetype)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize screenWidth:(CGFloat)screenWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        
        thisFontSize = fontSize;
        TextEditorView *inputView = [[TextEditorView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth * 0.12)];
        inputView.delegate = self;
        self.inputAccessoryView = inputView;
        [self setFont:AppFont(fontSize)];
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColorFromRGB(0xd7d7d7).CGColor;
        [MitimGlobalData setRoundedCornersToView:self radius:screenWidth * 0.02];
        [self setTextColor:[UIColor blackColor]];
        CGFloat descriptionTextInset = screenWidth * 0.035;
        self.textContainerInset = UIEdgeInsetsMake(descriptionTextInset, descriptionTextInset, descriptionTextInset, descriptionTextInset);
        self.allowsEditingTextAttributes = true;
    }
    return self;
}

- (void) clickedBoldButton {
    NSRange selectedRange = [self selectedRange];
    
    if (selectedRange.length > 0) {
        NSDictionary *currentAttributesDict = [self.textStorage attributesAtIndex:selectedRange.location effectiveRange:nil];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:currentAttributesDict];
        
        UIFont *currentFont = [dict objectForKey:NSFontAttributeName];
        
        UIFont *newFont = nil;
        if (currentFont == [UIFont systemFontOfSize:thisFontSize]) {
            newFont = BoldAppFont(thisFontSize);
        } else {
            newFont = AppFont(thisFontSize);
        }
        
        [dict setObject:newFont forKey:NSFontAttributeName];
        
        [self.textStorage beginEditing];
        [self.textStorage setAttributes:dict range:selectedRange];
        [self.textStorage endEditing];
    }
}

- (void) clickedUnderlineButton {
    NSRange selectedRange = [self selectedRange];
    
    if (selectedRange.length > 0) {
        NSDictionary *currentAttributesDict = [self.textStorage attributesAtIndex:selectedRange.location effectiveRange:nil];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:currentAttributesDict];
        
        if ([dict objectForKey:NSUnderlineStyleAttributeName] == nil || [[dict objectForKey:NSUnderlineStyleAttributeName] intValue] == 0) {
            [dict setObject:[NSNumber numberWithInt:1] forKey:NSUnderlineStyleAttributeName];
        } else {
            [dict setObject:[NSNumber numberWithInt:0] forKey:NSUnderlineStyleAttributeName];
        }
        
        [self.textStorage beginEditing];
        [self.textStorage setAttributes:dict range:selectedRange];
        [self.textStorage endEditing];
    }
}

- (void) clickedBulletButton {
    
    NSMutableAttributedString *mutAttribStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:AppFont(thisFontSize) forKey:NSFontAttributeName];
    [mutAttribStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:dict]];
    [mutAttribStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"   \u2022 " attributes:dict]];
    self.attributedText = mutAttribStr;
    
    [self updateTextViewHeights:self];
}

- (void) updateTextViewHeights:(UITextView *)textView {
    if (self.thisDelegate) {
        [self.thisDelegate updateTextViewHeights:textView];
    }
}

- (void) bulletsReturn {
    
}

- (NSString *) encodeToHTML:(NSAttributedString *) attributedString {
    NSAttributedString *rtfFileAttributedString = attributedString;
    NSString *rtfFileString = [rtfFileAttributedString string];
    NSString *importSeparator = @" \n";
    NSCharacterSet *characters = [NSCharacterSet characterSetWithCharactersInString:importSeparator];
    NSArray *separatedArray = [rtfFileString componentsSeparatedByCharactersInSet:characters];
    NSInteger start = 0;
    
    NSMutableString *mutString = [NSMutableString new];
    
    for (NSString *sub in separatedArray) {
        NSRange range = NSMakeRange(start, sub.length);
        NSAttributedString *str = [rtfFileAttributedString attributedSubstringFromRange:range];
        NSDictionary *dict = [NSDictionary new];
        if (str.length > 0) dict = [str attributesAtIndex:0 effectiveRange:nil];
        UIFont *currentFont = [dict objectForKey:NSFontAttributeName];
        BOOL isBold = false;
        if (currentFont == [UIFont systemFontOfSize:thisFontSize] || str.string.length < 1) {
        } else {
            isBold = true;
        }
        
        BOOL isUnderline = false;
        if ([dict objectForKey:NSUnderlineStyleAttributeName] == nil || [[dict objectForKey:NSUnderlineStyleAttributeName] intValue] == 0) {
        } else {
            isUnderline = true;
        }
        
        if (isUnderline || isBold) {
            if (isBold) [mutString appendString:@"<b>"];
            if (isUnderline) [mutString appendString:@"<u>"];
            [mutString appendString:str.string];
            [mutString appendString:@" "];
            if (isUnderline) [mutString appendString:@"</u>"];
            if (isBold) [mutString appendString:@"</b>"];
        } else if (str.string.length < 1) {
            [mutString appendString:@"<br>"];
            [mutString appendString:@"</br>"];
        } else {
            [mutString appendString:str.string];
            [mutString appendString:@" "];
        }
        
        start += range.length + 1;
    }
    
    LogRed(@"mutstr = %@", mutString);
    
    return mutString;
}

- (NSAttributedString *) decodeFromHTMLWithString:(NSString *) string {
    NSString *rtfFileString = string;
    NSArray *separatedArray = [rtfFileString componentsSeparatedByString:@"<"];
    NSInteger start = 0;
    
    NSMutableAttributedString *mutString = [NSMutableAttributedString new];
    
    BOOL isBold = false;
    BOOL isUnderline = false;
    
    for (NSString *str in separatedArray) {
        if (start == 0 && str.length < 1) continue;
        NSString *newStr = nil;
        if ([str containsString:@">"]) {
            newStr = [NSString stringWithFormat:@"<%@", str];
        } else {
            newStr = str;
        }
        
        if ([newStr containsString:@"<"] && [newStr containsString:@">"]) {
            if ([newStr containsString:@"<b>"]) {
                isBold = true;
            }
            if ([newStr containsString:@"<u>"]) {
                isUnderline = true;
            }
        }
        if ([newStr containsString:@"<br>"]) [mutString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        
        int lenght = 0;
        if ([newStr containsString:@"/"]) lenght = 4;
        else lenght = 3;
        if (newStr.length > lenght) {
            if (isUnderline) {
                [dict setObject:[NSNumber numberWithInt:1] forKey:NSUnderlineStyleAttributeName];
                isUnderline = false;
            }
            if (isBold) {
                UIFont *font = BoldAppFont(thisFontSize);
                [dict setObject:font forKey:NSFontAttributeName];
                isBold = false;
            } else {
                UIFont *font = AppFont(thisFontSize);
                [dict setObject:font forKey:NSFontAttributeName];
            }
            if ([newStr containsString:@"<br>"] || [newStr containsString:@"</br>"] || [newStr containsString:@"<b>"] || [newStr containsString:@"</b>"] || [newStr containsString:@"<u>"] || [newStr containsString:@"</u>"]) {
                NSString *removeStr = [newStr stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
                newStr = removeStr;
                removeStr = [newStr stringByReplacingOccurrencesOfString:@"</br>" withString:@""];
                newStr = removeStr;
                removeStr = [newStr stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
                newStr = removeStr;
                removeStr = [newStr stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
                newStr = removeStr;
                removeStr = [newStr stringByReplacingOccurrencesOfString:@"<u>" withString:@""];
                newStr = removeStr;
                removeStr = [newStr stringByReplacingOccurrencesOfString:@"</u>" withString:@""];
                newStr = removeStr;
            }
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:newStr attributes:dict];
            [mutString appendAttributedString:attrStr];
        }
    }
    return mutString;
}

@end