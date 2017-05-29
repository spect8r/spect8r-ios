//
//  MitimCompleteInterface.h
//  InAWord
//
//  Created by Misha Timashov on 8/14/13.
//  Copyright (c) 2013 Misha Timashov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MitimCompleteInterface : NSObject

typedef void (^MitimComplete)(void);
typedef void (^MitimCompleteWithError)(NSError *error);
typedef void (^MitimSuccessComplete)(BOOL result);
typedef void (^MitimCompleteWithInt)(int result);

@end
