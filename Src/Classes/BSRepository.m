//
//  BSRepository.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/24/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSRepository.h"
#import "BSColorDetector.h"

@implementation BSRepository

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];

    if (self) {
        self.objectID = [dict[@"id"] integerValue];
        self.accountID = [dict[@"account_id"] integerValue];
        self.name     = dict[@"name"];
        self.title    = dict[@"title"];

        self.storageUsedInBytes = [dict[@"storage_used_bytes"] integerValue];

        self.url = [[NSURL alloc] initWithString:dict[@"repository_url"]];
        
        NSString *vcs = dict[@"vcs"];

        if ([@"mercurial" isEqualToString:vcs]) {
            self.type = MercurialRepository;
        } else if ([@"subversion" isEqualToString:vcs]) {
            self.type = SubversionRepository;
        } else if ([@"git" isEqualToString:vcs]) {
            self.type = GitRepository;
        }

        BSColorDetector *colorDetector = [[BSColorDetector alloc] init];
        self.colorLabel = [colorDetector colorFromLabel:dict[@"color_label"]];
        
        if (dict[@"created_at"] != [NSNull null]) {
            self.createdAt = [[self railsDateFormat] dateFromString:dict[@"created_at"]];
        }
        
        if (dict[@"updated_at"] != [NSNull null]) {
            self.updatedAt = [[self railsDateFormat] dateFromString:dict[@"updated_at"]];
        }

        if (dict[@"last_commit_at"] != [NSNull null]) {
            self.lastCommitAt = [[self railsDateFormat] dateFromString:dict[@"last_commit_at"]];
        }
    }

    return self;
}

- (NSString*)description
{
    return [[NSString alloc] initWithFormat:@"<%@#%d, name: '%@', created_at: '%@', updated_at: '%@'",
            [self class], self.objectID, self.name, self.createdAt, self.updatedAt];
}

+ (NSString*)toString
{
    return @"repository";
}

@end
