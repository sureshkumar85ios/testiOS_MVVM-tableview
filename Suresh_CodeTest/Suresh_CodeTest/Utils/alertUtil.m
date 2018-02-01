//
//  alertUtil.m
//  Suresh_CodeTest
//
//  Created by SURESH on 2/1/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "alertUtil.h"

@implementation alertUtil

+(void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString *)message FromVc:(UIViewController*)vc
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                }];
    
    
    [alert addAction:yesButton];
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:alert animated:YES completion:nil];
    });
}

@end
