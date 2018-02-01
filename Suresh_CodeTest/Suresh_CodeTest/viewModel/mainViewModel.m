//
//  mainViewModel.m
//  Suresh_CodeTest
//
//  Created by Suresh on 31/01/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "mainViewModel.h"
#import "rowModel.h"
#import <UIKit/UIKit.h>
#import "networkManager.h"
#import "alertUtil.h"
#import "NSString+SK.h"

#define GET_METHOD_URL @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
//https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json


@interface mainViewModel ()

@property (nonatomic, strong) NSMutableArray *listArr;//model array
@property (nonatomic, strong) NSArray *arrVal;
@property (nonatomic, strong) rowModel *oldRowModel;

@end

@implementation mainViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self configModelArr];
        
    }
    return self;
}

- (void)configModelArr {
    
    self.listArr = [NSMutableArray array];
    
    [networkManager getJsonResponse:GET_METHOD_URL success:^(NSDictionary *responseDict) {
        NSLog(@"%@",responseDict);
        NSArray *arr= (NSArray *)responseDict;
        NSLog(@"%@",arr);
        _arrVal = [arr valueForKey:@"rows"];
        if([_arrVal count] > 0)
        {
            for (int i = 0; i < [_arrVal count]; i++) {
                NSMutableArray *mutArr = [NSMutableArray array];
                rowModel * row = [rowModel new];
                
                NSString *title=[NSString stringWithFormat:@"%@",[[_arrVal objectAtIndex:i]valueForKey:@"title"]] ;
                NSString *desc= [NSString stringWithFormat:@"%@",[[_arrVal objectAtIndex:i]valueForKey:@"description"]];
                NSString *imgurl= [NSString stringWithFormat:@"%@",[[_arrVal objectAtIndex:i]valueForKey:@"imageHref"]];

                if (title.isValid) {
                    row.title = [[_arrVal objectAtIndex:i]valueForKey:@"title"];
                }
                if (desc.isValid) {
                    row.tdescription = [[_arrVal objectAtIndex:i]valueForKey:@"description"];
                }
                if (imgurl.isValid) {
                    
                    row.timgURL = [[_arrVal objectAtIndex:i]valueForKey:@"imageHref"];
                }
                if (title.isBlank && desc.isBlank && imgurl.isBlank)
                {
                    
                }
                    else
                [self.listArr addObject:row];
                
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"refresh"
                 object:self];
                
            }
        }
        else
            [alertUtil showAlertViewWithTitle:@"EMPTY! " andMessage:@"Response array is empty" FromVc:nil];
        
    } failure:^(NSError *error) {
        // error handling here ...
        NSLog(@"%@",error);
        
    }];
    
}

#pragma mark - change Cell Model
- (void)changeCellModelWithIndexPath:(NSIndexPath *)indexPath {
    
    if (self.updateCellBlock) {
        self.updateCellBlock(indexPath);
    }
    
}

#pragma mark - get CellModel
- (rowModel *)getRowModelWithIndexPath:(NSIndexPath *)indexPath {

    rowModel *rModel = [self.listArr objectAtIndex:indexPath.row];
    return rModel;
}

#pragma mark - cell/section Count
- (NSInteger)getSectionCount {
    return self.listArr.count;
}

- (NSInteger)getCellCountWithIndexPath:(NSInteger)section {
    
    return self.listArr.count;
}

- (NSInteger)getCellheightWithIndexPath:(NSInteger)row {
    
//  /
    
    if([_arrVal count] > 0 )
    {
    NSString *str =[NSString stringWithFormat:@"%@",[[_arrVal objectAtIndex:row]valueForKey:@"description"]] ;
    
    if (str.isValid) {
            
    CGSize constraint = CGSizeMake(300, 20000.0f);
    CGSize size;
    
    CGSize boundingBox = [str boundingRectWithSize:constraint
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                            context:nil].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height+120;
        }
    else
        return 80;
    }
    
    return 30;
}


@end
