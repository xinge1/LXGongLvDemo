//
//  LXCommonTips.h
//  LXAppFrameworkDemo
//
//  Created by liuxin on 16/5/18.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXCommonTips : NSObject

+ (LXCommonTips*)sharedLXCommonTips;

-(void)showTips:(NSString *)message;

@end
