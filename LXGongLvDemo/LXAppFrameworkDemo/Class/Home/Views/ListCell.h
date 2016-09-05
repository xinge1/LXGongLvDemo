//
//  ListCell.h
//  LXAppFrameworkDemo
//
//  Created by liuxin on 16/7/30.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;
@interface ListCell : UITableViewCell

@property (nonatomic,strong)ListModel *listModel;
@end
