//
//  BSUser.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/18/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSUser.h"

@implementation BSUser

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    if (self)
    {
        self.objectID   = [dict[@"id"] integerValue];
        self.accountID  = [dict[@"account_id"] integerValue];
        self.login      = dict[@"login"];
        self.email      = dict[@"email"];
        self.firstName  = dict[@"first_name"];
        self.lastName   = dict[@"last_name"];
        self.name       = dict[@"name"];
        self.timezone   = dict[@"timezone"];

        if (dict[@"admin"] != [NSNull null]) {
            self.isAdmin    = [dict[@"admin"] boolValue];
        }

        if (dict[@"owner"] != [NSNull null]) {
            self.isAdmin    = [dict[@"owner"] boolValue];
        }

        if (dict[@"created_at"] != [NSNull null]) {
            self.createdAt = [[self railsDateFormat] dateFromString:dict[@"created_at"]];
        }

        if (dict[@"updated_at"] != [NSNull null]) {
            self.updatedAt = [[self railsDateFormat] dateFromString:dict[@"updated_at"]];
        }
    }

    return self;
}

- (BOOL)isInvited
{
    return (!self.login);
}

- (NSString*)description
{
    return [[NSString alloc] initWithFormat:@"<BSUser#%d, accountID: %d, login: '%@', name: '%@' email: '%@', isAdmin?: %@>",
            self.objectID, self.accountID, self.login, self.name, self.email, self.isAdmin ? @"Yes": @"No"];
}

+ (NSString*)toString
{
    return @"user";
}

@end
