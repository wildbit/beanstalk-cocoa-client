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

typedef void (^fetchBlock)(NSArray*, NSError*);

@interface BeanstalkCocoaClient : AFHTTPClient

+ (BeanstalkCocoaClient*)sharedClient:(NSString*)subdomain;

- (void)fetchUsers:(fetchBlock)block;
- (void)fetchRepositories:(fetchBlock)block;
- (void)fetchServerEnvironmentsForRepository:(BSRepository*)repo withBlock:(fetchBlock)block;

@end
