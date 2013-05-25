//
//  BSColorDetector.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/25/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSColorDetector.h"
#import "UIColor+Hex.h"

@implementation BSColorDetector

+ (UIColor*)colorFromLabel:(NSString*)colorLabelName
{   
    if ([@"label-pink" isEqualToString:colorLabelName]) {
        return [UIColor colorWithHexString:@"FDA7CC"];
    }
    else if ([@"label-red" isEqualToString:colorLabelName]) {
        return [UIColor redColor];
    }
    else if ([@"label-red-orange" isEqualToString:colorLabelName]) {
        return [UIColor colorWithHexString:@"ff7733"];
    }
    else if ([@"label-orange" isEqualToString:colorLabelName]) {
        return [UIColor orangeColor];
    }
    else if ([@"label-yellow" isEqualToString:colorLabelName]) {
        return [UIColor yellowColor];
    }
    else if ([@"label-yellow-green" isEqualToString:colorLabelName]) {
        return [UIColor colorWithHexString:@"57D200"];
    }
    else if ([@"label-aqua-green" isEqualToString:colorLabelName]) {
        return [UIColor colorWithHexString:@"73E5AC"];
    }
    else if ([@"label-green" isEqualToString:colorLabelName]) {
        return [UIColor greenColor];
    }
    else if ([@"label-green-blue" isEqualToString:colorLabelName]) {
        return [UIColor colorWithHexString:@"7fbfbf"];
    }
    else if ([@"label-sky-blue" isEqualToString:colorLabelName]) {
        return [UIColor colorWithHexString:@"66e6ff"];
    }
    else if ([@"label-light-blue" isEqualToString:colorLabelName]) {
        return [UIColor colorWithHexString:@"99d5ff"];
    }
    else if ([@"label-blue" isEqualToString:colorLabelName]) {
        return [UIColor blueColor];
    }
    else if ([@"label-orchid" isEqualToString:colorLabelName]) {
        return [UIColor colorWithHexString:@"e493fd"];
    }
    else if ([@"label-violet" isEqualToString:colorLabelName]) {
        return [UIColor colorWithHexString:@"bf87be"];
    }
    else if ([@"label-brown" isEqualToString:colorLabelName]) {
        return [UIColor brownColor];
    }
    else if ([@"label-black" isEqualToString:colorLabelName]) {
        return [UIColor blueColor];
    }
    else if ([@"label-grey" isEqualToString:colorLabelName]) {
        return [UIColor grayColor];
    }
    else {
        return [UIColor whiteColor];   
    }
}

@end
