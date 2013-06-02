//
//  BeanstalkCocoaClient.h
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/18/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "AFHTTPClient.h"
#import "BSUser.h"
#import "BSRepository.h"
#import "BSServerEnvironment.h"
#import "BSRelease.h"

typedef void (^fetchBlock)(NSArray*, NSError*);
typedef void (^fetchSingleEntityBlock)(id, NSError*);

@interface BeanstalkCocoaClient : AFHTTPClient

+ (BeanstalkCocoaClient*)sharedClient:(NSString*)subdomain;

- (void)fetchUser:(NSUInteger)userId withBlock:(fetchSingleEntityBlock)block;
- (void)fetchUsersAtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;
- (void)fetchRepositoriesAtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;
- (void)fetchServerEnvironmentsForRepository:(BSRepository*)repo page:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;
- (void)fetchReleasesAtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;
- (void)fetchReleasesForRepisotry:(BSRepository*)repo AtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;

@end
