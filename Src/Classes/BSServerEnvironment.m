//
//  BSServerEnvironment.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/25/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSServerEnvironment.h"
#import "BSColorDetector.h"

@implementation BSServerEnvironment

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    if (self) {
        self.objectID = [dict[@"id"] integerValue];
        self.accountID = [dict[@"account_id"] integerValue];
        self.repositoryID = [dict[@"repository_id"] integerValue];
        self.name     = dict[@"name"];
        self.isAutomatic = [dict[@"automatic"] boolValue];
        self.branchName = dict[@"branch_name"];
        self.currentVersion = dict[@"current_version"];

        BSColorDetector *colorDetector = [[BSColorDetector alloc] init];
        self.colorLabel = [colorDetector colorFromLabel:dict[@"color_label"]];

        if (dict[@"created_at"] != [NSNull null]) {
            self.createdAt = [[self railsDateFormat] dateFromString:dict[@"created_at"]];
        }
        
        if (dict[@"updated_at"] != [NSNull null]) {
            self.updatedAt = [[self railsDateFormat] dateFromString:dict[@"updated_at"]];
        }
    }
    
    return self;
}

#pragma mark - Class

+ (NSString*)toString
{
    return @"server_environment";
}

@end
