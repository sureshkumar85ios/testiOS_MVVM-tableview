//
//  mainView.m
//  Suresh_CodeTest
//
//  Created by Suresh on 31/01/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "mainView.h"
#import "rowModel.h"
#import "tCell.h"
#import "Masonry.h"


#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface mainView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) mainViewModel *viewModel;

@end

@implementation mainView

- (instancetype)initWithViewModel:(mainViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
        [self configView];
    }
    return self;
}

- (void)tellClassName { //testing XCtest case
    NSLog(@"this is Main_design_view");
}

- (void)configView {

    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    self.mainTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self addSubview:self.mainTableView];
}

-(void)reloadTable
{
    [self.mainTableView reloadData];
}

#pragma mark - tableView delegate&dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel getCellCountWithIndexPath:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idStr = @"tCell";
    tCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[tCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idStr];
    }
    cell.cellModel = [self.viewModel getRowModelWithIndexPath:indexPath];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.viewModel getCellheightWithIndexPath:indexPath.row];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark - coustom tableViewHeader
- (UILabel *)configHeader {
    UILabel *headerLabel = [UILabel new];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.textColor = [UIColor redColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    return headerLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
