//
//  BSUser.h
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/18/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSObject.h"

@interface BSUser : BSObject

@property (nonatomic, assign) NSInteger accountID;

@property (nonatomic, assign) BOOL isAdmin;
@property (nonatomic, assign) BOOL isOwner;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *timezone;

- (id)initWithDictionary:(NSDictionary*)dictionary;
- (BOOL)isInvited;

@end
