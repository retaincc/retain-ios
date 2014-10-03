//
//  RCCEventRequest.h
//  retaincc
//
//  Created by b123400 on 3/10/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import "RCCRequest.h"

@interface RCCEventRequest : RCCRequest

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDictionary *properties;

@end
