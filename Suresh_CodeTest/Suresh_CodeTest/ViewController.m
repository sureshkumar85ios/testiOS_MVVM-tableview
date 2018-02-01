//
//  ViewController.m
//  Suresh_CodeTest
//
//  Created by Suresh on 31/01/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "ViewController.h"
#import "mainView.h"
#import "mainViewModel.h"
#import "Masonry.h"

@interface ViewController ()

@property(nonatomic, strong) mainView *mainView;
@property (nonatomic, strong) mainViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewModel = [mainViewModel new];
    [self configMainView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tableViewRefreshNotification:)
                                                 name:@"refresh"
                                               object:nil];
    
}

- (void) tableViewRefreshNotification:(NSNotification *) notification
{

    if ([[notification name] isEqualToString:@"refresh"])
        NSLog (@"reload table notification!");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainView.mainTableView reloadData];
    });
    
}


#pragma mark - configView
- (void)configMainView {
    
    self.mainView = [[mainView alloc] initWithViewModel:self.viewModel];
    self.mainView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.mainView];

    [self.mainView.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(self.view.mas_width);
        make.top.equalTo(self.view).with.offset(44);
        make.bottom.equalTo(self.view);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
