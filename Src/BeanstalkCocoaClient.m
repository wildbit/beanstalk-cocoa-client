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

- (void)fetchUsers:(fetchBlock)block
{
    [self fetch:[BSUser class] atEndpoint:@"users.json" withParameters:nil withBlock:block];
}

- (void)fetchRepositories:(fetchBlock)block
{
    [self fetch:[BSRepository class] atEndpoint:@"repositories.json" withParameters:nil withBlock:block];
}

- (void)fetchServerEnvironmentsForRepository:(BSRepository*)repo withBlock:(fetchBlock)block
{
    NSString *endpoint = [[NSString alloc] initWithFormat:@"%d/server_environments.json", repo.objectID];
    [self fetch:[BSServerEnvironment class] atEndpoint:endpoint withParameters:nil withBlock:block];
}

#pragma mark - Private

- (void)fetch:(Class)bsKlass atEndpoint:(NSString*)endpoint withParameters:(NSDictionary*)params withBlock:(fetchBlock)block
{
    [self getPath:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
    
        NSMutableArray *mutableResources = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *rawResource in JSON) {
            NSDictionary *rawAttrs = rawResource[[bsKlass toString]];
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
