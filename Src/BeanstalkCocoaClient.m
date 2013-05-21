//
//  BeanstalkCocoaClient.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/18/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BeanstalkCocoaClient.h"
#import "AFNetworking.h"

#define WB_HOST     @"http://%@.beanstalkapp.com/api"
#define WB_FORMAT   @"json"

@implementation BeanstalkCocoaClient

#pragma mark - Initializers

- (id)initWithBaseURL:(NSURL*)url
{
    self = [super initWithBaseURL:url];

    if (self) {
        [self setDefaultHeader:@"User-Agent:"   value:@"Beanstalk Cocoa Client"];
        [self setDefaultHeader:@"Content-Type:" value:@"application/json"];
        [self setParameterEncoding:AFJSONParameterEncoding];
    }

    return self;
}

#pragma mark - Class

+ (BeanstalkCocoaClient*)sharedClient:(NSString*)subdomain
{
    static BeanstalkCocoaClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *apiHost = [[NSString alloc] initWithFormat:WB_HOST, subdomain];
        sharedClient = [[BeanstalkCocoaClient alloc] initWithBaseURL:[NSURL URLWithString:apiHost]];
        sharedClient.parameterEncoding = AFJSONParameterEncoding;
        [sharedClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    });

    return sharedClient;
}

#pragma mark - API

- (void)users:(void (^)(NSArray *users, NSError *error))block
{
    [self getPath:@"users.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutableUsers = [NSMutableArray arrayWithCapacity:[JSON count]];

        for (NSDictionary *rawUser in JSON) {
            NSDictionary *userAttrs = rawUser[@"user"];
            BSUser *user = [[BSUser alloc] initWithDictionary:userAttrs];
            [mutableUsers addObject:user];
        }

        if (block) {
            block([NSArray arrayWithArray:mutableUsers], nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

@end
