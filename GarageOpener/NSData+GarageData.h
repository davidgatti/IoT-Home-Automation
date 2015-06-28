//
//  NSData+GarageData.h
//  GarageOpener
//
//  Created by David Gatti on 6/25/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GarageData)

+ (NSData *) PF_dataFromBase64String: (NSString *) base64;
- (NSString *) PF_base64EncodedString;

@end
