//
//  BeanstalkCocoaClient.h
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/18/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "AFHTTPClient.h"
#import "BSUser.h"

@interface BeanstalkCocoaClient : AFHTTPClient

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy, readonly) NSError *lastKnownError;

+ (BeanstalkCocoaClient*)sharedClient:(NSString*)subdomain;

- (void)users:(void (^)(NSArray *users, NSError *error))block;

@end
