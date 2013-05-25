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
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"];
    return dateFormat;
}

- (NSString*)description
{
    return [[NSString alloc] initWithFormat:@"<%@#%d, created_at: '%@', updated_at: '%@'",
            [self class], self.objectID, self.createdAt, self.updatedAt];
}

@end
