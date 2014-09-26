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

@interface RetainCC ()

- (void)logEventWithName:(NSString*)name properties:(NSDictionary*)dict callback:(void(^)(BOOL success, NSError *error))callback;
- (void)identifyWithEmail:(NSString*)email userID:(NSString*)userID callback:(void(^)(BOOL success, NSError *error))callback;
- (void)changeUserAttributes:(NSDictionary*)dictionary callback:(void(^)(BOOL success, NSError *error))callback;

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
        
        BOOL shouldApply = [request.URL.absoluteString isEqualToString:@"https://app.retain.cc/api/v1/events"];
        if (!shouldApply) return NO;
        
        NSDictionary *allHeaders = request.allHTTPHeaderFields;
        // check auth
        NSString *authString = [allHeaders objectForKey:@"Authorization"];
        XCTAssert(authString, @"No auth string found");
        authString = [authString substringFromIndex:[authString rangeOfString:@"Basic "].length];
        NSData *authData = [[NSData alloc]initWithBase64EncodedString:authString options:0];
        XCTAssert(authData, @"Auth data is not base63 encoded");
        NSString *decodedData = [[NSString alloc] initWithData:authData encoding:NSUTF8StringEncoding];
        XCTAssert([decodedData isEqualToString:@"APP_ID:API_KEY"]);
        
        // content type check
        XCTAssert([[allHeaders objectForKey:@"Content-type"] rangeOfString:@"application/json"].location != NSNotFound,@"Request Content-type should be json");
        
        
        NSLog(@"%@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
        NSError *error = nil;
        NSDictionary *bodyData = [NSJSONSerialization JSONObjectWithData:request.HTTPBody options:kNilOptions error:&error];
        XCTAssert(!error);
//        XCTAssert([[bodyData objectForKey:@"KEY1"] isEqualToString:@"VALUE1"]);
//        XCTAssert([[bodyData objectForKey:@"KEY2"] isEqualToString:@"VALUE2"]);
        
        return YES;
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
