//
//  mainViewModel.h
//  Suresh_CodeTest
//
//  Created by Suresh on 31/01/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "rowModel.h"

typedef void(^UpdateCellBlock)(NSIndexPath *indexPath);

@interface mainViewModel : NSObject

@property (nonatomic, copy) UpdateCellBlock updateCellBlock;

- (void)changeCellModelWithIndexPath:(NSIndexPath *)indexPath;
- (rowModel *)getRowModelWithIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)getCellCountWithIndexPath:(NSInteger)section;
- (NSInteger)getSectionCount;
- (NSInteger)getCellheightWithIndexPath:(NSInteger)row;

@end
