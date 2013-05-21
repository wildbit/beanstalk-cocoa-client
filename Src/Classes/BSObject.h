//
//  BSObject.h
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/21/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSObject : NSObject

@property (nonatomic, assign) NSInteger objectID;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

- (NSDateFormatter*)railsDateFormat;

@end
