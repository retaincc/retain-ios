//
//  RCCUserAttributeRequest.h
//  retaincc
//
//  Created by b123400 on 3/10/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import "RCCRequest.h"

/**
 * A class for the user attribute request.
 * Please set the properties before calling -send:
 */
@interface RCCUserAttributeRequest : RCCRequest

/**
 * User's detail.
 */
@property (strong, nonatomic) NSDictionary *attributes;

@end
