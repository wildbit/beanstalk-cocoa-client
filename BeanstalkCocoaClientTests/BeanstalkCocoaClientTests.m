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
    
    [self.client fetchRepositoriesAtPage:1 perPage:1 withBlock:^(NSArray *repos, NSError *error) {
        STAssertNil(error, @"Error occurred: %@", error);

        for (BSRepository *repo in repos) {
            STAssertNotNil(repo.name,      @"name was nil");
            STAssertNotNil(repo.title,     @"title was nil");
            STAssertNotNil(repo.url,       @"url was nil");
            STAssertTrue(repo.type > 0, @"type wasn't sety");
            STAssertNotNil(repo.createdAt, @"createdAt was nil");
            STAssertNotNil(repo.updatedAt, @"updatedAt was nil");
            STAssertNotNil(repo.colorLabel, @"Color label was nil");
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
    
    [self.client fetchUsersAtPage:1 perPage:1 withBlock:^(NSArray *users, NSError *error) {
        STAssertNil(error, @"Error occurred: %@", error);
        
        for (BSUser *user in users) {
            STAssertNotNil(user.login,     @"login was nil");
            STAssertNotNil(user.firstName, @"firstName was nil");
            STAssertNotNil(user.lastName,  @"lastName was nil");
            STAssertNotNil(user.email,     @"email was nil");
            STAssertTrue(user.accountID > 0, @"accountID wasn't set");
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

- (void)testFetchServerEnvironmentsForRepository
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    BSRepository *repo = [[BSRepository alloc] init];
    repo.objectID = 27;
    
    [self.client fetchServerEnvironmentsForRepository:repo page:1 perPage:1 withBlock:^(NSArray *environments, NSError *error) {
        STAssertNil(error, @"Error occurred: %@", error);

        for (BSServerEnvironment *environment in environments) {
            STAssertNotNil(environment.name, @"Name was nil");
            STAssertNotNil(environment.branchName, @"Branch was nil");
            STAssertNotNil(environment.currentVersion, @"Current version was nil");
            STAssertNotNil(environment.colorLabel, @"Color label was nil");
            STAssertEquals(environment.repositoryID, repo.objectID, @"Repository IDs didn't match");
            STAssertTrue(environment.accountID > 0, @"accountID wasn't set");
            STAssertNotNil(environment.createdAt, @"createdAt was nil");
            STAssertNotNil(environment.updatedAt, @"updatedAt was nil");
        }

        STAssertNotNil(environments, @"Returned environments array is nil");
        STAssertTrue(([environments count] > 0), @"Environments array contains entries");
        dispatch_semaphore_signal(sema);
    }];
    
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
}

- (void)testFetchReleases
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    [self.client fetchReleasesAtPage:1 perPage:1 withBlock:^(NSArray *releases, NSError *error) {
        STAssertNil(error, @"Error occurred: %@", error);
        
        for (BSRelease *release in releases) {
            STAssertNotNil(release.revision, @"Revision was nil");
            STAssertTrue(release.accountID > 0, @"accountID wasn't set");
            STAssertNotNil(release.createdAt, @"createdAt was nil");
            STAssertNotNil(release.updatedAt, @"updatedAt was nil");
        }
        
        STAssertNotNil(releases, @"Returned releases array is nil");
        STAssertTrue(([releases count] > 0), @"Releases array contains entries");
        dispatch_semaphore_signal(sema);
    }];
    
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
}

- (void)testFetchReleasesForRepository
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    BSRepository *repo = [[BSRepository alloc] init];
    repo.objectID = 27;
    
    [self.client fetchReleasesForRepisotry:repo AtPage:1 perPage:1 withBlock:^(NSArray *releases, NSError *error) {
        STAssertNil(error, @"Error occurred: %@", error);
        
        for (BSRelease *release in releases) {
            STAssertNotNil(release.revision, @"Revision was nil");
            STAssertTrue(release.accountID > 0, @"accountID wasn't set");
            STAssertEquals(release.repositoryID, repo.objectID, @"Repository ID didn't set");
            STAssertNotNil(release.createdAt, @"createdAt was nil");
            STAssertNotNil(release.updatedAt, @"updatedAt was nil");
        }
        
        STAssertNotNil(releases, @"Returned releases array is nil");
        STAssertTrue(([releases count] > 0), @"Releases array contains entries");
        dispatch_semaphore_signal(sema);
    }];
    
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
}

@end
