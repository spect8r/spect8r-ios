//
//  IQDropDownTextField+SelectRow.m
//  Vouchify
//
//  Created by Mike Timashov on 7/26/16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "IQDropDownTextField+SelectRow.h"

@implementation IQDropDownTextField (SelectRow)

- (void) selectRow:(NSInteger)row {
    if (row < [self.itemList count]+1) {
        UIPickerView *pickerView;

        SEL aSelector = NSSelectorFromString(@"pickerView");
        if ([self respondsToSelector:aSelector]){
            pickerView = (UIPickerView *) [self performSelector:aSelector];
        }
        
        super.text = [self.itemList objectAtIndex:row];
        if (pickerView){
            [pickerView selectRow:row inComponent:0 animated:false];
        }
    }
}

@end
