//
//  XZTestCell.m
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import "XZTestCell.h"

#import "XZTestModel.h"

NSString *const XZTestCellID = @"XZTestCell";

@interface XZTestCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end


@implementation XZTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTestModel:(XZTestModel *)testModel
{
    _testModel = testModel;
    
    self.titleLabel.text = testModel.title;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
