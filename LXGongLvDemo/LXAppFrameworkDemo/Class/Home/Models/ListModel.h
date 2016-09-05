//
//  ListModel.h
//  LXAppFrameworkDemo
//
//  Created by liuxin on 16/7/30.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *list_id;
@property (nonatomic,copy)NSString *htmlFileName;
@property (nonatomic,assign)BOOL isCollect;


@end
