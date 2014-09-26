//
//  RetainCC.h
//  retaincc
//
//  Created by b123400 on 22/9/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetainCC : NSObject

+ (instancetype)sharedInstanceWithApiKey:(NSString*)apiKey appID:(NSString*)appID;
+ (instancetype)shared;

- (instancetype)initWithApiKey:(NSString*)apiKey appID:(NSString*)appID;

- (void)logEventWithName:(NSString*)name properties:(NSDictionary*)dict;
- (void)identifyWithEmail:(NSString*)email userID:(NSString*)userID;
- (void)changeUserAttributes:(NSDictionary*)dictionary;

@end
