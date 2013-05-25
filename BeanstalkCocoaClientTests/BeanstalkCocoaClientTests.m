//
//  BeanstalkCocoaClientTests.m
//  BeanstalkCocoaClientTests
//
//  Created by Chris on 5/18/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BeanstalkCocoaClientTests.h"
#import "AFNetworking.h"
#import "BSAuth.h"

@implementation BeanstalkCocoaClientTests

- (void)setUp
{
    [super setUp];
    self.client = [BeanstalkCocoaClient sharedClient:kBeanstalkHost];
    [self.client setAuthorizationHeaderWithUsername:kBeanstalkUsername password:kBeanstalkPassword];
}

- (void)tearDown
{
    [super tearDown];
    self.client = nil;
}

- (void)testFetchRepositories
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    [self.client fetchRepositories:^(NSArray *repos, NSError *error) {

        for (BSRepository *repo in repos) {
            STAssertNotNil(repo.name,      @"name was nil");
            STAssertNotNil(repo.title,     @"title was nil");
            STAssertNotNil(repo.url,       @"url was nil");
            STAssertNotNil(repo.createdAt, @"createdAt was nil");
            STAssertNotNil(repo.updatedAt, @"updatedAt was nil");
        }

        STAssertNotNil(repos, @"Returned repositories array is nil");
        STAssertTrue(([repos count] > 0), @"Repositories array contains entries");
        dispatch_semaphore_signal(sema);
    }];
    
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
}

- (void)testFetchUsers
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    [self.client fetchUsers:^(NSArray *users, NSError *error) {

        for (BSUser *user in users) {
            STAssertNotNil(user.login,     @"login was nil");
            STAssertNotNil(user.firstName, @"firstName was nil");
            STAssertNotNil(user.lastName,  @"lastName was nil");
            STAssertNotNil(user.email,     @"email was nil");
            STAssertTrue(user.accountID > 0, @"accountID was nil");
            STAssertNotNil(user.createdAt, @"createdAt was nil");
            STAssertNotNil(user.updatedAt, @"updatedAt was nil");
        }
        
        STAssertNotNil(users, @"Returned users array is nil");
        STAssertTrue(([users count] > 0), @"Users array contains entries");
        dispatch_semaphore_signal(sema);
    }];
    
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
}

@end
