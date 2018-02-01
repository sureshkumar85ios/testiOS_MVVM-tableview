//
//  mainView.h
//  Suresh_CodeTest
//
//  Created by Suresh on 31/01/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewModel.h"

@interface mainView : UIView

@property (nonatomic, strong) UITableView *mainTableView;

- (instancetype)initWithViewModel:(mainViewModel *)viewModel;
- (void)tellClassName;

@end
