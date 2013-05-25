//
//  BSRepository.h
//  BeanstalkCocoaClient
//
//  Created by Chris on 5/24/13.
//  Copyright (c) 2013 Wildbit. All rights reserved.
//

#import "BSObject.h"
#import <UIKit/UIColor.h>

typedef enum BSRepositoryType : NSUInteger {
    GitRepository = 1,
    MercurialRepository = 2,
    SubversionRepository = 3
} BSRepositoryType;

@interface BSRepository : BSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSUInteger storageUsedInBytes;
@property (nonatomic, assign) BSRepositoryType type;
@property (nonatomic, copy) UIColor *colorLabel;
@property (nonatomic, copy) NSString *defaultBranch;
@property (nonatomic, copy) NSDate *lastCommitAt;
@property (nonatomic, copy) NSURL *url;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
