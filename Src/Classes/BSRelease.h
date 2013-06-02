//
//  BSRelease.h
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/30/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSObject.h"
#import "BSUser.h"
#import "BSRepository.h"
#import "BSServerEnvironment.h"

typedef enum BSReleaseState : NSUInteger {
    Pending = 1,
    Waiting,
    Failed,
    Success,
    Skipped
} BSReleaseState;

@interface BSRelease : BSObject

@property (nonatomic, assign) BSReleaseState state;
@property (nonatomic, assign) BOOL isDeployed;
@property (nonatomic, assign) BOOL isAutomatic;
@property (nonatomic, assign) BOOL deployedFromScratch;
@property (nonatomic, assign) BOOL doNotNotify;
@property (nonatomic, assign) NSUInteger numberOfRetried;
@property (nonatomic, assign) NSUInteger repositoryID;
@property (nonatomic, assign) NSUInteger userID;
@property (nonatomic, assign) NSUInteger serverEnvironmentID;
@property (nonatomic, copy) NSString *revision;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *environmentName;
@property (nonatomic, copy) NSString *environmentBranchName;
@property (nonatomic, copy) NSString *environmentRevision;
@property (nonatomic, copy) NSDate  *deplayedAt;
@property (nonatomic, copy) NSDate  *retriedAt;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
