//
//  LXTools.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#define INTODETAILCOUNT @"INTODETAILCOUNT"//进入详情的次数

#import "LXTools.h"



@implementation LXTools


+(BOOL)isFirstOpenApp{
    BOOL isFirst = NO;
    NSString * versionNumber=[[NSUserDefaults standardUserDefaults] stringForKey:USER_GUIDE_KEY];
    if (!versionNumber) {
        isFirst = NO;
    }else{
        isFirst = YES;
    }
    return isFirst;
}

+(void)saveAppVersion{
    [[NSUserDefaults standardUserDefaults] setObject:AppVersion forKey:USER_GUIDE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)showLoginModule:(UIViewController *)viewController{
    LoginViewController *vc=[[LoginViewController alloc] init];
    vc.pushType=isModel;
    JTNavigationController * navi1 = [[JTNavigationController  alloc]initWithRootViewController:vc];
    navi1.fullScreenPopGestureEnabled=YES;
    [viewController presentViewController:navi1 animated:YES completion:^{
        
    }];
    
}

/**
 *  获取工程中的plist文件数据
 *
 *  @return
 */
+(NSMutableArray *)getBundleFileData{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"DataList.plist" ofType:nil];
    NSMutableArray *temparray=[NSMutableArray arrayWithArray:[[NSArray arrayWithContentsOfFile:path] mutableCopy]];
    
    return temparray;
}

/**
 *  获取沙盒中文件数据
 *
 *  @return 
 */
+(NSMutableArray *)getDocumentFileData{
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:@"DataList.plist"];
    NSMutableArray *temparray=[NSMutableArray arrayWithArray:[[NSArray arrayWithContentsOfFile:path] mutableCopy]];
    DLog(@"path=%@",path);
    return temparray;
}



/**
 *  获取沙盒文件路径
 *
 *  @return
 */
+(NSString *)getDocumentFilePath{
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:@"DataList.plist"];
    
    return path;
}

/**
 *  收藏属性写入
 *
 *  @param listIndex
 */
+(void)writeDataWithIndex:(NSInteger)listIndex{
    NSString *filePath = [self getDocumentFilePath];
    
    //获取数据
    NSMutableArray *temparray=[NSMutableArray arrayWithArray:[[NSArray arrayWithContentsOfFile:filePath] mutableCopy]];
    
    //写
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:temparray[listIndex]];
    [dic setValue:@(YES) forKey:@"isCollect"];
    
    [temparray removeObjectAtIndex:listIndex];
    [temparray insertObject:dic atIndex:listIndex];
    [temparray writeToFile:filePath atomically:YES];
}

/**
 *  把工程中plist数据转移到document的plist中
 */
+(void)bundleFileWriteDocument{
    NSMutableArray *array=[self getBundleFileData];
    NSString *filePath = [self getDocumentFilePath];
    
    [array writeToFile:filePath atomically:YES];
}

+(void)addBannerView:(UIViewController *)viewController{
    // Replace this ad unit ID with your own ad unit ID.
    GADBannerView *bannerView=[[GADBannerView alloc] init];
    [viewController.view addSubview:bannerView];
    bannerView.sd_layout.leftSpaceToView(viewController.view,0).bottomSpaceToView(viewController.view,0).widthIs(windowContentWidth).heightIs(50);
    
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

+(void)addVideoAd:(UIViewController *)vc{

    GADRequest *request = [GADRequest request];
    request.testDevices = @[
                            TestDeviceUDID  // Eric's iPod Touch
                            ];
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request
                                           withAdUnitID:ADUnitID_video];

}

//+(void)addIntersitialAd:(UIViewController *)vc inter:(GADInterstitial *)interstitial{
//    
////    GADInterstitial *interstitial =[[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
//    
//    GADRequest *request = [GADRequest request];
//    // Request test ads on devices you specify. Your test device ID is printed to the console when
//    // an ad request is made. GADInterstitial automatically returns test ads when running on a
//    // simulator.
//    request.testDevices = @[
//                            TestDeviceUDID  // Eric's iPod Touch
//                            ];
//    [interstitial loadRequest:request];
//    
//    [interstitial presentFromRootViewController:vc];
//}

/**
 *  记录进入详情的次数
 */
+(void)saveIntoDetailVcCount{
    NSString *currentCount = [self getIntoDetailVcCount];
    if (currentCount) {
        currentCount = [NSString stringWithFormat:@"%ld",[currentCount integerValue]+1];
        [[NSUserDefaults standardUserDefaults] setObject:currentCount forKey:INTODETAILCOUNT];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:INTODETAILCOUNT];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}

+(NSString *)getIntoDetailVcCount{
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:INTODETAILCOUNT];
}

/**
 *  每进三次播放一次视频广告
 *
 *  @return
 */
+(BOOL)isShowVideoAD{
    
    if(![self getIntoDetailVcCount]){
        [self saveIntoDetailVcCount];
    }
    
    BOOL isShow = NO;
    NSInteger count = [[self getIntoDetailVcCount] integerValue]%3;
    isShow = count==0?YES:NO;
    DLog(@"%@,count = %ld",[self getIntoDetailVcCount],count);
    
    [self saveIntoDetailVcCount];
    
    return isShow;
}

@end
