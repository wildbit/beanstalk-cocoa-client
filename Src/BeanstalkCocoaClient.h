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
typedef void (^createReleaseBlock)(BSRelease*, NSError*);

@interface BeanstalkCocoaClient : AFHTTPClient

+ (BeanstalkCocoaClient*)sharedClient:(NSString*)subdomain;

/** Creates a release via Beanstalk API

 @param repository BSRepository for the release
 @param parameters A dictionary of strings associated with the release. Use the following keys:

 - comment:  text that will be displayed in the release notes
 - environment_id: environment you want to deploy to
 - revision: what revision of the server to deploy
 - deploy_from_scratch: deploy from the first revision rather then doing incremental deployment
 - do_not_notify: do not trigger email notification for this deployment

 @param block A block supplies a BSRelease object of the response and a NSError object, nil if the response was successful

 */
- (void)createReleaseFor:(BSRepository*)repository withParams:(NSDictionary*)parameters withBlock:(createReleaseBlock)block;

- (void)fetchUser:(NSUInteger)userId withBlock:(fetchSingleEntityBlock)block;
- (void)fetchUsersAtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;
- (void)fetchRepositoriesAtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;
- (void)fetchServerEnvironmentsForRepository:(BSRepository*)repo page:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;
- (void)fetchReleasesAtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;
- (void)fetchReleasesForRepisotry:(BSRepository*)repo AtPage:(NSUInteger)page perPage:(NSUInteger)perPage withBlock:(fetchBlock)block;

@end
