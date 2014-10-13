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

- (NSMutableURLRequest*)authedRequest{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *authString = [NSString stringWithFormat:@"%@:%@", self.appID, self.apiKey];
    NSData *authData = [authString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    return request;
}
- (NSMutableURLRequest*)authedRequestWithBody:(NSData*)data{
    NSMutableURLRequest *request = [self authedRequest];
    [request setHTTPBody:data];
    return request;
}
- (NSMutableURLRequest*)authedRequestWithJSON:(NSDictionary*)json{
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    return [self authedRequestWithBody:data];
}

- (void)sendRequest:(NSURLRequest*)request callback:(void(^)(BOOL success, NSError *error))callback{
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (!callback) {
                                   return;
                               }
                               if (connectionError) {
                                   NSError *error = [NSError errorWithDomain:@"com.oursky.retaincc" code:((NSHTTPURLResponse*)response).statusCode userInfo:connectionError.userInfo];
                                   callback(NO, error);
                               } else {
                                   callback(YES, nil);
                               }
                           }];
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
