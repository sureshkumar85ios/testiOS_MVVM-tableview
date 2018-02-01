//
//  networkManager.h
//  Suresh_CodeTest
//
//  Created by SURESH on 2/1/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface networkManager : NSObject

// GET Method Declaration

+(void)getJsonResponse:(NSString *)urlStr success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure;

@end
