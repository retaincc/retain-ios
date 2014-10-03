//
//  RCCEventRequest.m
//  retaincc
//
//  Created by b123400 on 3/10/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import "RCCEventRequest.h"

@implementation RCCEventRequest

- (void)send:(void (^)(BOOL, NSError *))callback {
    
    AFHTTPRequestOperationManager *manager = [self prepareManager];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObject:@"text/plain"]];
    
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:self.name forKey:@"event"];
    if (self.userID) {
        [params setObject:self.userID forKey:@"user_id"];
    } else if (self.email) {
        [params setObject:self.email forKey:@"email"];
    }
    if (self.properties) {
        [params setObject:self.properties forKey:@"custom_data"];
    }
    
    [manager POST:@"https://app.retain.cc/api/v1/events" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"operation success: %@", operation);
        NSLog(@"response: %@", [responseObject description]);
        if (callback) {
            callback( YES, nil );
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"operation failed: %@", operation.description);
        NSLog(@"error: %@", error.localizedDescription);
        if (callback) {
            callback( NO, error );
        }
    }];
}

# pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    self.properties = [aDecoder decodeObjectForKey:@"properties"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.properties forKey:@"properties"];
}

@end
