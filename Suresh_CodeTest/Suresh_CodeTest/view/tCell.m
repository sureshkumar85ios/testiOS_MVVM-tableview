//
//  tCell.m
//  Suresh_CodeTest
//
//  Created by Suresh on 31/01/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "tCell.h"
#import "asyncImageView.h"
#import "Masonry.h"

#define SHEIGHT [UIScreen mainScreen].bounds.size.height
#define SWIDTH [UIScreen mainScreen].bounds.size.width

@interface tCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, readwrite, weak) asyncImageView *remoteImageView;

@end
@implementation tCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {

    UILabel *nameLabel = [UILabel new];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.frame = CGRectMake(10, 10, 80, 30);
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.frame = CGRectMake(120, 10, SWIDTH - 130, 30);
    detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailLabel.numberOfLines = 0;
   [detailLabel sizeToFit];
    [self.contentView addSubview:detailLabel];
    self.detailLabel = detailLabel;
    
    asyncImageView *img = [[asyncImageView alloc]initWithFrame:CGRectMake(10, 10,150, 150)];
    [img setContentMode:UIViewContentModeScaleAspectFit];
    self.remoteImageView = img;
    [self.contentView addSubview:img];


    //Setting Constraints
    [self.remoteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.width.equalTo(@100);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remoteImageView.mas_right).with.offset(20);
        make.top.equalTo(self.contentView).with.offset(20);
        make.height.equalTo(@20);
        make.width.equalTo(self.contentView).with.offset(-140);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel).with.offset(-20);
        make.height.equalTo(@220);
        make.width.equalTo(self.contentView).with.offset(-140);
    }];
}

- (void)setCellModel:(rowModel *)cellModel {
    _cellModel = cellModel;
    self.nameLabel.text = cellModel.title;
    self.detailLabel.text = cellModel.tdescription;
    [self.remoteImageView displayImageFromURL:cellModel.timgURL
                        completionHandler:^(NSError *error) {
                            
                            if (error) {
                                NSLog(@"Error while loading image %@",[error description]);
                           }
//
                       }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
