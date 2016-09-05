//
//  ListCell.m
//  LXAppFrameworkDemo
//
//  Created by liuxin on 16/7/30.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "ListCell.h"
#import "ListModel.h"

@interface ListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation ListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setListModel:(ListModel *)listModel{
    _titleLab.text=listModel.title;
    _timeLab.text=@"2016-08-31";
    NSInteger imageIndex = arc4random()%5;//0-4随机数
    _rightImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"image%ld",imageIndex]];
}

@end
