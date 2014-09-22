//
//  retainccTests.m
//  retainccTests
//
//  Created by b123400 on 22/9/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "RetainCC.h"

@interface retainccTests : XCTestCase

@end

@implementation retainccTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES; // Stub ALL requests without any condition
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub all those requests with "Hello World!" string
        NSData* stubData = [@"Hello World!" dataUsingEncoding:NSUTF8StringEncoding];
        return [OHHTTPStubsResponse responseWithData:stubData statusCode:200 headers:nil];
    }];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
    XCTAssert([result isEqualToString:@"Hello World!"],@"Stub request");
}

- (void)testSendEvent {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"https://app.retain.cc/api/v1/events"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub all those requests with "Hello World!" string
        NSData* stubData = [@"Hello World!" dataUsingEncoding:NSUTF8StringEncoding];
        return [OHHTTPStubsResponse responseWithData:stubData statusCode:200 headers:nil];
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"send event async"];
    
    RetainCC *library = [[RetainCC alloc] initWithApiKey:@"API_KEY" appID:@"APP_ID"];
    [library logEventWithName:@"EVENT_NAME" properties:@{
                                                         @"KEY1":@"VALUE1",
                                                         @"KEY2":@"VALUE2"
                                                         }
     callback:^(BOOL success, NSError *error) {
         XCTAssert(success,@"Request failed, %@", error);
         [expectation fulfill];
     }];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        NSLog(@"test error: %@", error.localizedDescription);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
