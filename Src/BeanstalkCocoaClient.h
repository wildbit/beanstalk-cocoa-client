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

@interface BeanstalkCocoaClient : AFHTTPClient

+ (BeanstalkCocoaClient*)sharedClient:(NSString*)subdomain;

- (void)fetchUsers:(void (^)(NSArray *users, NSError *error))block;
- (void)fetchRepositories:(void (^)(NSArray *repositories, NSError *error))block;

@end
