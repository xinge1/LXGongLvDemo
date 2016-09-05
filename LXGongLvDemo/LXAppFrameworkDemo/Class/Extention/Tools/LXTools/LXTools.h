//
//  LXTools.h
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GADInterstitial;
@interface LXTools : NSObject

/**
 *  是否第一次打开app，版本更新也会返回yes
 *
 *  @return 是，返回YES。
 */
+(BOOL)isFirstOpenApp;

/**
 *  存版本号到本地
 */
+(void)saveAppVersion;

/**
 *  弹出登录模块
 */
+(void)showLoginModule:(UIViewController *)viewController;

/**
 *  获取工程中的plist文件数据
 *
 *  @return
 */
+(NSMutableArray *)getBundleFileData;
/**
 *  获取沙盒中文件数据
 *
 *  @return
 */
+(NSMutableArray *)getDocumentFileData;
/**
 *  获取沙盒文件路径
 *
 *  @return
 */
+(NSString *)getDocumentFilePath;
/**
 *  收藏属性写入
 *
 *  @param listIndex
 */
+(void)writeDataWithIndex:(NSInteger)listIndex;
/**
 *  把工程中plist数据转移到document的plist中
 */
+(void)bundleFileWriteDocument;


+(void)addBannerView:(UIViewController *)viewController;

+(void)addVideoAd:(UIViewController *)vc;

//+(void)addIntersitialAd:(UIViewController *)vc inter:(GADInterstitial *)interstitial;

/**
 *  每进三次播放一次视频广告
 *
 *  @return
 */
+(BOOL)isShowVideoAD;

@end
