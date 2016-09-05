//
//  DetailViewController.m
//  LXAppFrameworkDemo
//
//  Created by liuxin on 16/7/30.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "DetailViewController.h"
#import "ListModel.h"

@interface DetailViewController ()<UIWebViewDelegate,GADRewardBasedVideoAdDelegate,GADInterstitialDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic, strong) GADInterstitial *interstitial;

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title=@"攻略";
    self.view.backgroundColor=SFQBackgroundColor;
    self.webView.backgroundColor=SFQBackgroundColor;
    self.webView.delegate=self;
    [self loadHtml];
    
    [self initNav];
   
    [LXTools addBannerView:self];
    
    if ([LXTools isShowVideoAD]) {
        [GADRewardBasedVideoAd sharedInstance].delegate = self;
        [LXTools addVideoAd:self];
    }
}

-(void)initNav{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 69, 50);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"收藏" forState:UIControlStateNormal];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

-(void)rightBtnClick{
    if (self.model.isCollect) {
        [[LXCommonTips sharedLXCommonTips] showTips:@"已收藏"];
    }else{
        //修改收藏属性，写入plist
        [[LXCommonTips sharedLXCommonTips] showTips:@"收藏成功！"];
        
        [LXTools writeDataWithIndex:_listIndex];
        
        self.model.isCollect=YES;
    }
}

-(void)loadHtml{
    
//    NSDictionary *dic =[LXTools getDocumentFileData][_listIndex];
//    ListModel *listModel = [ListModel yy_modelWithJSON:dic];
    NSString *filePath = @"";
    if (self.sourceType==HomdeListType ) {
        NSString *fileName = [NSString stringWithFormat:@"%@%ld",@"h",self.listIndex];
        filePath=[[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    }else{
        filePath=[[NSBundle mainBundle] pathForResource:self.model.htmlFileName ofType:@"html"];
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *titleStr=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title =titleStr;
    
    //设置背景色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#f2f3f5'"];
    
    //----点击图片放大方法----//
    //调整字号
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '95%'";
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    //js方法遍历图片添加点击事件 返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return objs.length;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    
    //注入自定义的js方法后别忘了调用 否则不会生效（不调用也一样生效了，，，不明白）
    NSString *resurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    //调用js方法
    //    NSLog(@"---调用js方法--%@  %s  jsMehtods_result = %@",self.class,__func__,resurlt);
    
}
#pragma mark ----点击web中图片放大----


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
    //    NSLog(@"requestString is %@",requestString);
    
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        //        NSLog(@"image url------%@", imageUrl);
        
        if (self.bgView) {
            //设置不隐藏，还原放大缩小，显示图片
            self.bgView.hidden = NO;
            self.imageView.hidden=NO;
            self.imageView.frame = CGRectMake(10, 10, windowContentWidth, 240);
            //            [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:LOAD_IMAGE(@"house_moren")];
            self.imageView.image= [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
        }
        else
            [self showBigImage:imageUrl];//创建视图并显示图片
        
        return NO;
    }
    return YES;
}


#pragma mark 显示大图片
-(void)showBigImage:(NSString *)imageUrl{
    //创建灰色透明背景，使其背后内容不可操作
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    [self.bgView setBackgroundColor:[UIColor colorWithRed:0.3
                                                    green:0.3
                                                     blue:0.3
                                                    alpha:0.7]];
    [self.view addSubview:self.bgView];
    
    //创建边框视图
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-20, 240)];
    //将图层的边框设置为圆脚
    borderView.layer.cornerRadius = 8;
    borderView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    borderView.layer.borderWidth = 8;
    borderView.layer.borderColor = [[UIColor colorWithRed:0.9
                                                    green:0.9
                                                     blue:0.9
                                                    alpha:0.7] CGColor];
    [borderView setCenter:self.bgView.center];
    [self.bgView addSubview:borderView];
    
    //创建关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"关闭.png"] forState:UIControlStateNormal];
    //    closeBtn.backgroundColor = [UIColor redColor];
    [closeBtn addTarget:self action:@selector(removeBigImage) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-15, borderView.frame.origin.y-15, 26, 27)];
    [self.bgView addSubview:closeBtn];
    
    //创建显示图像视图
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(borderView.frame)-20, CGRectGetHeight(borderView.frame)-20)];
    self.imageView.userInteractionEnabled = YES;
    //    [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:LOAD_IMAGE(@"house_moren")];
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    [borderView addSubview:self.imageView];
    
    //添加捏合手势
    [self.imageView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)]];
    
}

//关闭按钮
-(void)removeBigImage
{
    self.bgView.hidden=YES;
    self.imageView.hidden = YES;
}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    //缩放:设置缩放比例
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}
#pragma mark ----点击web中图片放大----



- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd{
    NSLog(@"Reward based video ad is received.=%d",[GADRewardBasedVideoAd sharedInstance].isReady);
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error{
    DLog(@"request video error = %@" ,error);
    
    self.interstitial =[[GADInterstitial alloc] initWithAdUnitID:ADUnitID_interstitial];
    self.interstitial.delegate=self;
    
    GADRequest *request = [GADRequest request];
    // Request test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADInterstitial automatically returns test ads when running on a
    // simulator.
    request.testDevices = @[
                            TestDeviceUDID  // Eric's iPod Touch
                            ];
    [self.interstitial loadRequest:request];
}



- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    
    [self.interstitial presentFromRootViewController:self];
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
