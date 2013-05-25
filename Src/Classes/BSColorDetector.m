//
//  BSColorDetector.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/25/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSColorDetector.h"
#import "UIColor+Hex.h"

#define kBSDefaultColor [UIColor whiteColor]

@interface BSColorDetector()

@property (nonatomic, strong) NSDictionary* colorLabelLookup;

@end

@implementation BSColorDetector

- (id)init
{
    self = [super init];
    
    if (self) {
        self.colorLabelLookup = [self colorLabelLookup];
    }
    
    return self;
}

- (UIColor*)colorFromLabel:(NSString*)colorLabelName
{
    UIColor *matchingColor = self.colorLabelLookup[colorLabelName];
    
    if (!matchingColor) {
        matchingColor = kBSDefaultColor;
    }
    
    return matchingColor;
}

#pragma mark - Private

- (NSDictionary*)colorLabelLookup
{
    return @{
             @"label-pink":         [UIColor colorWithHexString:@"FDA7CC"],
             @"label-red":          [UIColor redColor],
             @"label-red-orange":   [UIColor colorWithHexString:@"ff7733"],
             @"label-orange":       [UIColor orangeColor],
             @"label-yellow":       [UIColor yellowColor],
             @"label-yellow-green": [UIColor colorWithHexString:@"57D200"],
             @"label-aqua-green":   [UIColor colorWithHexString:@"73E5AC"],
             @"label-green":        [UIColor greenColor],
             @"label-green-blue":   [UIColor colorWithHexString:@"7fbfbf"],
             @"label-sky-blue":     [UIColor colorWithHexString:@"66e6ff"],
             @"label-light-blue":   [UIColor colorWithHexString:@"99d5ff"],
             @"label-blue":         [UIColor blueColor],
             @"label-orchid":       [UIColor colorWithHexString:@"e493fd"],
             @"label-violet":       [UIColor colorWithHexString:@"bf87be"],
             @"label-brown":        [UIColor brownColor],
             @"label-black":        [UIColor blackColor],
             @"label-grey":         [UIColor grayColor],
             };
}

@end
