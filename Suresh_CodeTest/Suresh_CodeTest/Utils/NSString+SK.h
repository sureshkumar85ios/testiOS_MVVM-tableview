//
//  NSString+SK.h
//  Suresh_CodeTest
//
//  Created by SURESH on 2/1/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SK)

-(BOOL)isBlank;
-(BOOL)isValid;
- (NSString *)removeWhiteSpacesFromString;
- (BOOL)isValidUrl;


@end
