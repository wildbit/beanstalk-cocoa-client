//
//  BSObject.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/21/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSObject.h"

@implementation BSObject

- (NSDateFormatter*)railsDateFormat
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-d HH:mm:ss Z"];
    return dateFormat;
}

@end
