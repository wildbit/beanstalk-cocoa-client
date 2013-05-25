//
//  BSObject.h
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/21/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSObject : NSObject

@property (nonatomic, assign) NSUInteger objectID;
@property (nonatomic, assign) NSUInteger accountID;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

+ (NSString*)toString;
- (NSDateFormatter*)railsDateFormat;

@end
