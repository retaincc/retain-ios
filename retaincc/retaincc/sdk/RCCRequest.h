//
//  RCCRequest.h
//  retaincc
//
//  Created by b123400 on 3/10/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface RCCRequest : NSObject<NSCoding>

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *email;

- (id)initWithApiKey:(NSString*)apiKey appID:(NSString*)appID;

- (void)send:(void(^)(BOOL success, NSError *error))callback;
- (AFHTTPRequestOperationManager*)prepareManager;

@end
