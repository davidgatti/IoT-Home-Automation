//
//  NSData+GarageData.m
//  GarageOpener
//
//  Created by David Gatti on 6/25/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

#import "NSData+GarageData.h"

@implementation NSData (GarageData)

+ (NSData *) PF_dataFromBase64String: (NSString *) base64 {
    return [NSData.alloc initWithBase64EncodedString: base64 options: 0];
} // +PF_dataFromBase64String:

- (NSString *) PF_base64EncodedString {
    return [self base64EncodedStringWithOptions: 0];
} // -PF_base64EncodedString

@end
