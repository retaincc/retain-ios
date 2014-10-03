//
//  RCCRequest.m
//  retaincc
//
//  Created by b123400 on 3/10/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import "RCCRequest.h"
#import "RetainCC.h"

@interface RCCRequest ()

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *appID;

@end

@implementation RCCRequest

- (id)initWithApiKey:(NSString*)apiKey appID:(NSString*)appID{
    self = [super init];
    
    self.apiKey = apiKey;
    self.appID = appID;
    
    return self;
}

- (void)send:(void(^)(BOOL success, NSError *error))callback{
    
}

- (AFHTTPRequestOperationManager*)prepareManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:self.appID password:self.apiKey];
    [manager setResponseSerializer: [AFHTTPResponseSerializer serializer]];
    
    return manager;
}

# pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    self.apiKey = [aDecoder decodeObjectForKey:@"apiKey"];
    self.appID = [aDecoder decodeObjectForKey:@"appID"];
    self.userID = [aDecoder decodeObjectForKey:@"userID"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.apiKey forKey:@"apiKey"];
    [aCoder encodeObject:self.appID forKey:@"appID"];
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.email forKey:@"email"];
}

@end
