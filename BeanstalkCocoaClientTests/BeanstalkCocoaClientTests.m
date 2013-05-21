//
//  BeanstalkCocoaClientTests.m
//  BeanstalkCocoaClientTests
//
//  Created by Chris on 5/18/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BeanstalkCocoaClientTests.h"
#import "TestSemaphor.h"
#import "AFNetworking.h"
#import "BSAuth.h"

@implementation BeanstalkCocoaClientTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testUsers
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    BeanstalkCocoaClient *client = [BeanstalkCocoaClient sharedClient:kBeanstalkUsername];
    [client setAuthorizationHeaderWithUsername:@"chrisledet" password:kBeanstalkPassword];

    [client users:^(NSArray *users, NSError *error) {
        STAssertNotNil(users, @"Returned users array is nil");
        STAssertTrue(([users count] > 0), @"Users array contains entries");
        dispatch_semaphore_signal(sema);
    }];

    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
}

@end
