//
//  DetailViewController.h
//  LXAppFrameworkDemo
//
//  Created by liuxin on 16/7/30.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SourceType) {
    HomdeListType   = 0,
    CollectListType
    
};

@class ListModel;
@interface DetailViewController : LXSuperStyleViewController

@property (nonatomic,strong)ListModel *model;
@property (nonatomic,assign)NSInteger listIndex;

@property (nonatomic,assign)SourceType sourceType;

@end
