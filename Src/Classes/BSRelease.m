//
//  BSRelease.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/30/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSRelease.h"

@implementation BSRelease

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    if (self) {
        self.objectID = [dict[@"id"] integerValue];
        self.accountID = [dict[@"account_id"] integerValue];
        self.repositoryID = [dict[@"repository_id"] integerValue];
        self.userID = [dict[@"user_id"] integerValue];
        self.serverEnvironmentID = [dict[@"environment_id"] integerValue];
        self.revision = dict[@"revision"];
        self.comment = dict[@"comment"];
        self.author = dict[@"author"];
        self.numberOfRetried = [dict[@"retries"] integerValue];
        self.deployedFromScratch = [dict[@"deployed_from_scratch"] boolValue];
        self.doNotNotify = [dict[@"do_not_notify"] boolValue];
        self.environmentName = dict[@"environment_name"];
        self.environmentRevision = dict[@"environment_revision"];
        self.environmentBranchName = dict[@"environment_branch_name"];
        
        NSString *rawState = dict[@"state"];
        if ([@"pending" isEqualToString:rawState]) {
            self.state = Pending;
        } else if ([@"waiting" isEqualToString:rawState]) {
            self.state = Waiting;
        } else if ([@"failed" isEqualToString:rawState]) {
            self.state = Failed;
        } else if ([@"success" isEqualToString:rawState]) {
            self.state = Success;
        } else if ([@"skipped" isEqualToString:rawState]) {
            self.state = Skipped;
        }
        
        if (dict[@"created_at"] != [NSNull null]) {
            self.createdAt = [[self railsDateFormat] dateFromString:dict[@"created_at"]];
        }

        if (dict[@"updated_at"] != [NSNull null]) {
            self.updatedAt = [[self railsDateFormat] dateFromString:dict[@"updated_at"]];
        }
        
        if (dict[@"retried_at"] != [NSNull null]) {
            self.retriedAt = [[self railsDateFormat] dateFromString:dict[@"retried_at"]];
        }
        
        if (dict[@"deployed_at"] != [NSNull null]) {
            self.deplayedAt = [[self railsDateFormat] dateFromString:dict[@"deployed_at"]];
        }
    }
    
    return self;
}

+ (NSString*)toString
{
    return @"release";
}

@end
