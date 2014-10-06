//
//  RCCEventRequest.h
//  retaincc
//
//  Created by b123400 on 3/10/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import "RCCRequest.h"

/**
 * A class for the event request.
 * Please set the properties before calling send.
 */
@interface RCCEventRequest : RCCRequest

/**
 * Name of the event
 */

@property (strong, nonatomic) NSString *name;
/**
 * Detail of the event.
 */
@property (strong, nonatomic) NSDictionary *properties;

@end
