//
//  RetainCC.m
//  retaincc
//
//  Created by b123400 on 22/9/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import "RetainCC.h"
#import <AFNetworking/AFNetworking.h>

@interface RetainCC ()

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *appID;

@end

@implementation RetainCC
static RetainCC *sharedInstance = nil;

+ (instancetype)sharedInstanceWithApiKey:(NSString*)apiKey appID:(NSString*)appID{
    if (sharedInstance) {
        // warn for calling twice?
    } else {
        sharedInstance = [[RetainCC alloc] initWithApiKey:apiKey appID:appID];
    }
    return sharedInstance;
}
+ (instancetype)sharedInstance{
    if (!sharedInstance) {
        NSLog(@"You have to call sharedInstanceWithApiKey:appID: before calling sharedInstance");
    }
    return sharedInstance;
}

- (instancetype)initWithApiKey:(NSString*)apiKey appID:(NSString*)appID{
    self = [super init];
    
    self.apiKey = apiKey;
    self.appID = appID;
    
    return self;
}

- (void)logEventWithName:(NSString*)name properties:(NSDictionary*)dict callback:(void(^)(BOOL success, NSError *error))callback {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:self.appID password:self.apiKey];
    [manager setResponseSerializer: [AFHTTPResponseSerializer serializer]];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObject:@"text/plain"]];
    
    [manager POST:@"https://app.retain.cc/api/v1/events" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

@end
