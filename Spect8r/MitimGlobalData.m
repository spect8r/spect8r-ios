//
//  MitimGlobalData.m
//  InAWord
//
//  Created by Misha Timashov on 5/8/13.
//  Copyright (c) 2013 Misha Timashov. All rights reserved.
//

#import "MitimGlobalData.h"
#import "MitimLoadingAlertView.h"
#import <CommonCrypto/CommonDigest.h>


@implementation MitimGlobalData 
+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+ (CGRect) getScreenRect
{
    return [[UIScreen mainScreen] bounds];
}

CGFloat currentKoef;
+ (CGFloat) getKoef{
    return currentKoef;
}
+ (void) setKoef: (CGFloat) value{
    currentKoef = value;
}

+ (NSString*)base64forString:(NSString*)str {
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [MitimGlobalData base64forData:data];
}

+ (NSData*)dataFromString:(NSString*)str {
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}


+ (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (NSString*)sha256HashFor:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+ (NSData *)sha256:(NSData *)data {
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    if ( CC_SHA256([data bytes], [data length], hash) ) {
        NSData *sha256 = [NSData dataWithBytes:hash length:CC_SHA256_DIGEST_LENGTH];
        return sha256;
    }
    return nil;
}

+ (bool)isIPad {
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return YES; /* Device is iPad */
    }
    return NO;
}

+ (NSMutableArray*)shuffleMutableArray:(NSMutableArray*)array
{
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger nElements = count - i;
        NSInteger n = arc4random_uniform(nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return array;
}

+ (int)getRandomIntFrom:(int)from to:(int)to
{
    return (from + arc4random_uniform(to-from+1));
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (void) setRoundedCornersToImageView:(UIImageView*)imageView{
    [imageView.layer setCornerRadius:CORNER_RADIUS];
    [imageView.layer setMasksToBounds:YES];
}

+ (void) setRoundedCornersToView:(UIView*)view radius:(int)radius{
    [view.layer setCornerRadius:radius];
    [view.layer setMasksToBounds:YES];
}

+ (void) setRoundedCornersToButton:(UIButton*)button{
    [button.layer setCornerRadius:CORNER_RADIUS];
    [button.layer setMasksToBounds:YES];
}

+ (void) setTimeout:(MitimComplete)callBack{
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.5);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        callBack();
    });
}

+ (void) setTimeout:(MitimComplete)callBack time:(int)time{
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * time / 1000);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        callBack();
    });
}

+ (void)shakeView:(UIView*)view{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:2];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint: CGPointMake([view center].x - 20.0f, [view center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint: CGPointMake([view center].x + 20.0f, [view center].y)]];
    [[view layer] addAnimation:animation forKey:@"position"];
}

+ (void)shakeVerticallyView:(UIView*)view{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:2];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint: CGPointMake([view center].x, [view center].y - 20.0f)]];
    [animation setToValue:[NSValue valueWithCGPoint: CGPointMake([view center].x, [view center].y + 20.0f)]];
    [[view layer] addAnimation:animation forKey:@"position"];
}

+ (NSString*) lingvoWithNumber:(int)number word1:(NSString*)word1 word2:(NSString*)word2 word3:(NSString*)word3
{
    if (number % 100 > 10 && number % 100 < 20) return word3;
    else if (number % 10 == 0) return word3;
    else if (number % 10 == 1) return word1;
    else if (number % 10 == 2) return word2;
    else if (number % 10 == 3) return word2;
    else if (number % 10 == 4) return word2;
    else if (number % 10 == 5) return word3;
    else if (number % 10 == 6) return word3;
    else if (number % 10 == 7) return word3;
    else if (number % 10 == 8) return word3;
    else if (number % 10 == 9) return word3;
    
    return word3;
}

MitimLoadingAlertView *loadingAlertView;
+ (void) initLoadingPopup:(CGRect)bounds {
    if (!loadingAlertView){
        loadingAlertView = [MitimLoadingAlertView alertViewWithAppFrame:bounds];
        loadingAlertView.isHidden = true;
    }
}

+ (NSString *) getInitialFromString:(NSString *)string {
    NSString *str = [[string componentsSeparatedByCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]]
                     componentsJoinedByString:@""];
    if (string.length > 0 && ![str isEqualToString:@""]) {
        NSRange range = [string rangeOfString:@" "];
        NSString *result;
        if (string && range.length > 0 && ![string isEqualToString:@""]){
            NSArray *initialsArray = [string componentsSeparatedByString:@" "];
            NSRange range = NSMakeRange(0, 1);
            NSMutableString *initialsString = [NSMutableString new];
            for (NSString *namePartString in initialsArray) {
                if (namePartString.length > 0) {
                    [initialsString appendString:[namePartString substringWithRange:range]];
                    if (initialsString.length >= 2) break;
                }
            }
            result = [initialsString uppercaseString];
        } else if (string && string.length > 0 && ![string isEqualToString:@""]){
            NSRange range = NSMakeRange(0, 1);
            NSString *firstChar = [string substringWithRange:range];
            result = firstChar;
        }
        return result;
    }
    return NULL;
}

+ (void) showLoadingPopup {
    if (loadingAlertView && loadingAlertView.isHidden) [loadingAlertView show];
}

+ (void) hideLoadingPopup {
    if (loadingAlertView && !loadingAlertView.isHidden) [loadingAlertView dismiss];
}

+(NSString*) shuffleString:(NSString*)str {
    int length = (int) str.length;
    
    if (!length) return @""; // nothing to shuffle
    
    unichar *buffer = calloc(length, sizeof (unichar));
    
    [str getCharacters:buffer range:NSMakeRange(0, length)];
    
    for(int i = length - 1; i >= 0; i--){
        int j = arc4random() % (i + 1);
        //NSLog(@"%d %d", i, j);
        //swap at positions i and j
        unichar c = buffer[i];
        buffer[i] = buffer[j];
        buffer[j] = c;
    }
    
    NSString *result = [NSString stringWithCharacters:buffer length:length];
    free(buffer);
    
    // caution, autoreleased. Allocate explicitly above or retain below to
    // keep the string.
    return result;
}

+ (NSString*) convertMobileAndEncrypt:(NSString*)number{
    number = [MitimGlobalData convertMobileToInternationalFormatAndValidate:number];
    if (number){
        NSLog(@"number = %@",number);
        number = [NSString stringWithFormat:@"VouchifySecureSalt08%@", number];
        NSData *data = [MitimGlobalData sha256:[MitimGlobalData dataFromString:number]];
        if (data) return [MitimGlobalData base64forData:data];
    }
    return number;
}

+ (NSString*) convertMobileToInternationalFormatAndValidate:(NSString*)number{
    number = [MitimGlobalData convertMobileToDomesticFormatAndValidate:number];
    if (number) {
        number = [number substringFromIndex:1];
        number = [NSString stringWithFormat:@"+61%@", number];
    }
    return number;
}

+ (NSString*) convertMobileToDomesticFormatAndValidate:(NSString*)number{
    // make sure not null
    if (number) {
        // make sure length is >= 10
        if (number.length >= 10) {
            // remove all non-numeric characters
            
            
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\d]" options:NSRegularExpressionCaseInsensitive error:&error];
            number = [regex stringByReplacingMatchesInString:number options:0 range:NSMakeRange(0, [number length]) withTemplate:@""];
            
            
            // if starts with 614 replace with 04
            if ([number hasPrefix:@"614"]) {
                number = [NSString stringWithFormat:@"04%@", [number substringFromIndex:3]];
            }
            else {
                // if starts with 6104 replace with 04
                if ([number hasPrefix:@"6104"]) {
                    number = [NSString stringWithFormat:@"04%@", [number substringFromIndex:4]];
                }
            }
        }
        
        // if not 10 characters long or doesn't start with 04 make it null
        if ((number.length!=10) || (!([number hasPrefix:@"04"]))) {
            number = NULL;
        }
    }
    return number;
}

+ (NSString *)urlEncodeString:(NSString*)str {
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString*) getAddressLinefromAddress:(NSDictionary*)address{
    if (address == NULL) return NULL;
    if (address[@"address_line"]) return address[@"address_line"];
    if (address[@"suburb"]) return [NSString stringWithFormat:@"%@, %@ %@, %@", address[@"suburb"][@"suburb_name"], address[@"suburb"][@"state"], address[@"suburb"][@"post_code"], address[@"suburb"][@"country"]];
    return NULL;
}

+ (NSString*) getAddressLineForBusinessFromAddress:(NSDictionary*)address{
    if (address == NULL) return NULL;
    NSMutableString *addressLine = [[NSMutableString alloc] init];
    if (address[@"address_line"]) {
        [addressLine appendString:address[@"address_line"]];
    }
    if (address[@"suburb"]){
        if (addressLine.length > 0) [addressLine appendString:@", "];
        [addressLine appendFormat:@"%@, %@ %@", address[@"suburb"][@"suburb_name"], address[@"suburb"][@"state"], address[@"suburb"][@"post_code"]];
    }
    
    return addressLine;
}

+ (NSString*) getAddressLineForBusinessProfilefromAddress:(NSDictionary*)address{
    if (address == NULL) return NULL;
    if (address[@"suburb"]) return [NSString stringWithFormat:@"%@, %@ %@, %@", address[@"suburb"][@"suburb_name"], address[@"suburb"][@"state"], address[@"suburb"][@"post_code"], address[@"suburb"][@"country"]];
    return NULL;
}

@end
