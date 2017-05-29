//
//  NSAttributedString+FontSize.m
//  Vouchify
//
//  Created by Kostya on 19.07.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "NSAttributedString+FontSize.h"
#import "MitimGlobalData.h"

@implementation NSAttributedString (FontSize)

- (NSAttributedString*) attributedStringWithFontSize:(CGFloat) fontSize
{
    NSMutableAttributedString* attributedString = [self mutableCopy];
    
    {
        [attributedString beginEditing];
        
        [attributedString enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedString.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
            
            UIFont* font = value;
            
            if ([font.fontName rangeOfString:@"bold" options:NSCaseInsensitiveSearch].location == NSNotFound) {
                font = AppFont(fontSize);
            } else {
                font = BoldAppFont(fontSize);
            }
            
            [attributedString removeAttribute:NSFontAttributeName range:range];
            [attributedString addAttribute:NSFontAttributeName value:font range:range];
        }];
        
        [attributedString endEditing];
    }
    
    return [attributedString copy];
}

@end
