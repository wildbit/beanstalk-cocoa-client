//
//  BSServerEnvironment.h
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/25/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSObject.h"
#import <UIKit/UIKit.h>

@interface BSServerEnvironment : BSObject

@property (nonatomic, assign) NSUInteger repositoryID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isAutomatic;
@property (nonatomic, strong) UIColor  *colorLabel;
@property (nonatomic, copy) NSString *branchName;
@property (nonatomic, copy) NSString *currentVersion;

@end
