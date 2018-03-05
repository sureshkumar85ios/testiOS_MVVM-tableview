//
//  Suresh_CodeTestTests.m
//  Suresh_CodeTestTests
//
//  Created by Suresh on 31/01/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "networkManager.h"
#import "mainView.h"
#import "mainViewModel.h"


@interface Suresh_CodeTestTests : XCTestCase

@property (nonatomic, strong) mainViewModel *viewModel;

@end

@implementation Suresh_CodeTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCheckClassCall {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    mainView *m = [[mainView alloc] initWithViewModel:self.viewModel];
    [m tellClassName];
    
    XCTAssertTrue([[m mainTableView] isMemberOfClass:[UITableView class]]);
    NSBundle *bundle = [NSBundle bundleForClass:[mainView class]];
    NSBundle *main = [NSBundle mainBundle];
    NSLog(@"%@ ============ %@", bundle, main);
}

- (void)testServiceCall{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [networkManager getJsonResponse:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json" success:^(NSDictionary *responseDict) {
        if ([responseDict isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *) responseDict statusCode];
            XCTAssertEqual(statusCode, 200, @"status code was not 200; was %ld", statusCode);
        }
        XCTAssert(responseDict, @"data nil");
        
        // do additional tests on the contents of the `data` object here, if you want
        
        // when all done, signal the semaphore
        
        dispatch_semaphore_signal(semaphore);
  
        
    } failure:^(NSError *error) {
        // error handling here ...
        NSLog(@"%@",error);
        XCTAssertNil(error, @"dataTaskWithURL error %@", error);

        
    }];
        

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
