//
//  OthersViewController.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "OthersViewController.h"

@interface OthersViewController ()
@property (nonatomic,strong)UITextView *aboutView;
@end

@implementation OthersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=Title3;
    self.view.backgroundColor=SFQBackgroundColor;
    self.aboutView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(15, 15, 50, 15));
    
    [self addBannerView:self];
}

-(void)addBannerView:(UIViewController *)viewController{
    // Replace this ad unit ID with your own ad unit ID.
    GADBannerView *bannerView=[[GADBannerView alloc] init];
    [viewController.view addSubview:bannerView];
    bannerView.sd_layout.leftSpaceToView(viewController.view,0).bottomSpaceToView(viewController.view,50).widthIs(windowContentWidth).heightIs(50);
    
    bannerView.adUnitID = ADUnitID_banner;
    bannerView.rootViewController = viewController;
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.automatically
    request.testDevices = @[
                            TestDeviceUDID  // Eric's iPod Touch
                            ];
    [bannerView loadRequest:request];
}

-(UITextView *)aboutView{
    if (!_aboutView) {
        _aboutView = [[UITextView alloc] init];
        _aboutView.editable=NO;
        _aboutView.backgroundColor=SFQBackgroundColor;
        _aboutView.text=@"      \n《球球大作战》       是一款超好玩萌酷且具有挑战性的以打球吃小球为游戏方式的实时对战休闲游戏，本游戏操作简单，只要理解一个”戳“的真谛就能变成高大上的玩家。\n\n\n\n        柚子游戏攻略专为广大玩家提供最全的手机游戏攻略,努力让玩家能够更轻松的玩手机游戏,突破极限。\n找手机游戏秘籍和攻略,就找柚子游戏攻略!\n【最全的游戏攻略】\n柚子游戏攻略囊括了各大网站、贴吧论坛的精品攻略。为您提供全方位的游戏攻略。\n【最新的游戏攻略】\n柚子游戏攻略为您提供最新的各种手机游戏攻略，高分不是梦。\n【最用心的游戏攻略】\n柚子游戏攻略会给您提供您最想要，最实用的游戏攻略。各路游戏大神带你飞！\n";
        _aboutView.font=[UIFont systemFontOfSize:16];
        [self.view addSubview:_aboutView];
    }
    return _aboutView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
