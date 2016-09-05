//
//  LXCommonTips.m
//  LXAppFrameworkDemo
//
//  Created by liuxin on 16/5/18.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "LXCommonTips.h"

@interface LXCommonTips ()
@property (nonatomic,strong)UILabel *tipsLab;
@end

@implementation LXCommonTips

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (LXCommonTips*)sharedLXCommonTips
{
    static LXCommonTips *sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    
    return sharedSVC;
}

-(void)showTips:(NSString *)message{
    
    if(!_tipsLab){
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.tipsLab];
        _tipsLab.text=message;
        
        CGSize size =[_tipsLab getLableSizeWithMaxWidth:200];
        _tipsLab.sd_layout.centerXEqualToView(window).centerYEqualToView(window).widthIs(size.width+30).heightIs(size.height+26);
        
        [self performSelector:@selector(cleanTipsView) withObject:_tipsLab afterDelay:3.0];
    }
    
}

-(UILabel *)tipsLab{
    if(!_tipsLab){
        _tipsLab = [[UILabel alloc] init];
        _tipsLab.textAlignment=NSTextAlignmentCenter;
        _tipsLab.font=[UIFont systemFontOfSize:14];
        _tipsLab.textColor=[UIColor whiteColor];
        _tipsLab.numberOfLines=0;
        _tipsLab.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.6];
        _tipsLab.layer.cornerRadius=4;
        _tipsLab.layer.shadowRadius=6;
        _tipsLab.layer.shadowOpacity=1.0;
        _tipsLab.layer.shadowOffset=CGSizeMake(6, 6);
        _tipsLab.layer.shadowColor=[UIColor blackColor].CGColor;
        _tipsLab.layer.masksToBounds=YES;
        _tipsLab.lineSpace=3.0;
        
        
    }
    return _tipsLab;
}



-(void)cleanTipsView{
    [UIView animateWithDuration:.5 animations:^{
        _tipsLab.alpha=0.0;
    } completion:^(BOOL finished) {
        [_tipsLab removeFromSuperview];
        _tipsLab=nil;
    }];
    
  
}



@end
