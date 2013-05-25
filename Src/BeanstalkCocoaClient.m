//
//  BeanstalkCocoaClient.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/18/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BeanstalkCocoaClient.h"
#import "AFNetworking.h"

#define WB_HOST      @"https://%@.beanstalkapp.com/api"
#define WB_FORMAT    @"json"

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

- (void)fetchUsers:(void (^)(NSArray *users, NSError *error))block
{
    NSString *endpoint = [[NSString alloc] initWithFormat:@"%@.%@", @"users", WB_FORMAT];
    [self fetch:[BSUser class] atResource:@"user" atEndpoint:endpoint withBlock:block];
}

- (void)fetchRepositories:(void (^)(NSArray *repositories, NSError *error))block
{
    NSString *endpoint = [[NSString alloc] initWithFormat:@"%@.%@", @"repositories", WB_FORMAT];
    [self fetch:[BSRepository class] atResource:@"repository" atEndpoint:endpoint withBlock:block];
}

#pragma mark - Private

- (void)fetch:(Class)bsKlass atResource:(NSString*)resource atEndpoint:(NSString*)endpoint withBlock:(void (^)(NSArray *, NSError *))block
{
    [self getPath:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
    
        NSMutableArray *mutableResources = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *rawResource in JSON) {
            NSDictionary *rawAttrs = rawResource[resource];
            id resourceInstance = [[bsKlass alloc] initWithDictionary:rawAttrs];
            [mutableResources addObject:resourceInstance];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableResources], nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

@end
