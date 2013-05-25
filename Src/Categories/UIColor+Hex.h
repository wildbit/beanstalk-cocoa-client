//
//  UIColor+Hex.h
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/25/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString*)stringToConvert;
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
@end
