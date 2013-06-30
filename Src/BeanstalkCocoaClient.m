//
//  BeanstalkCocoaClient.m
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/18/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BeanstalkCocoaClient.h"
#import "AFNetworking.h"

#define WB_HOST             @"http://%@.beanstalkapp.com/api"
#define WB_FORMAT           @"json"
#define WB_DEFAULT_PAGE     1
#define WB_DEFAULT_PER_PAGE 20

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

- (void)createReleaseFor:(BSRepository*)repository withParams:(NSDictionary*)parameters withBlock:(createReleaseBlock)block
{
    NSString *urlEndpoint = [[NSString alloc] initWithFormat:@"%d/releases.json", repository.objectID];

    [self postPath:urlEndpoint parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *attributes = JSON[[BSRelease toString]];
        BSRelease *release = [[BSRelease alloc] initWithDictionary:attributes];
        block(release, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)fetchUser:(NSUInteger)userId withBlock:(fetchSingleEntityBlock)block
{
    NSString *endpoint = [[NSString alloc] initWithFormat:@"users/%d.json", userId];
    [self fetchResource:[BSUser class] atEndpoint:endpoint withParams:nil withBlock:block];
}


- (void)fetchUsersAtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block
{
    NSDictionary *params = [self generatePaginationParametersForPage:page andPerPage:perPage];
    [self fetchResources:[BSUser class] atEndpoint:@"users.json" withParameters:params withBlock:block];
}

- (void)fetchRepositoriesAtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block
{
    NSDictionary *params = [self generatePaginationParametersForPage:page andPerPage:perPage];
    [self fetchResources:[BSRepository class] atEndpoint:@"repositories.json" withParameters:params withBlock:block];
}

- (void)fetchServerEnvironmentsForRepository:(BSRepository*)repo page:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block
{
    NSDictionary *params = [self generatePaginationParametersForPage:page andPerPage:perPage];
    NSString *endpoint = [[NSString alloc] initWithFormat:@"%d/server_environments.json", repo.objectID];
    [self fetchResources:[BSServerEnvironment class] atEndpoint:endpoint withParameters:params withBlock:block];
}

- (void)fetchReleasesAtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block
{
    NSDictionary *params = [self generatePaginationParametersForPage:page andPerPage:perPage];
    [self fetchResources:[BSRelease class] atEndpoint:@"releases.json" withParameters:params withBlock:block];
}

- (void)fetchReleasesForRepisotry:(BSRepository*)repo AtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block
{
    NSDictionary *params = [self generatePaginationParametersForPage:page andPerPage:perPage];
    NSString *endpoint = [[NSString alloc] initWithFormat:@"%d/releases.json", repo.objectID];
    [self fetchResources:[BSRelease class] atEndpoint:endpoint withParameters:params withBlock:block];
}

#pragma mark - Private

- (void)fetchResource:(Class)bsKlass atEndpoint:(NSString*)endpoint withParams:(NSDictionary*)params withBlock:(fetchSingleEntityBlock)block
{
    [self getPath:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *attributes = JSON[[bsKlass toString]];
        BSObject *resource = [[bsKlass alloc] initWithDictionary:attributes];
        
        if (block) {
            block(resource, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)fetchResources:(Class)bsKlass atEndpoint:(NSString*)endpoint withParameters:(NSDictionary*)params withBlock:(fetchBlock)block
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

- (NSDictionary*)generatePaginationParametersForPage:(NSUInteger)page andPerPage:(NSUInteger)perPage
{
    if (page < 1)
        page = WB_DEFAULT_PAGE;
    
    if (perPage < 1)
        perPage = WB_DEFAULT_PER_PAGE;

    return @{@"page": [NSNumber numberWithUnsignedInteger:page], @"per_page": [NSNumber numberWithUnsignedInteger:perPage]};
}

@end
