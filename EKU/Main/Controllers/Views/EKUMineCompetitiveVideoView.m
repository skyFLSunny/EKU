//
//  EKUMineCompetitiveVideoView.m
//  EKU
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EKUMineCompetitiveVideoView.h"
#import "VideoListViewController.h"
#import "videoInfoViewController.h"
#import "videoBtn.h"

@implementation EKUMineCompetitiveVideoView{
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}
-(void)clickedMoreVideos{
    VideoListViewController* con = [[VideoListViewController alloc] init];
    UIWindow* wi = [[UIApplication sharedApplication] keyWindow];
    UITabBarController* tab = (UITabBarController*)wi.rootViewController;
    UINavigationController*curcon= tab.selectedViewController;
    [curcon pushViewController:con animated:YES];
}
-(void)clickedVideoButton{
    videoInfoViewController* con = [[videoInfoViewController alloc] init];
    UIWindow* wi = [[UIApplication sharedApplication] keyWindow];
    UITabBarController* tab = (UITabBarController*)wi.rootViewController;
    UINavigationController*curcon= tab.selectedViewController;
    [curcon pushViewController:con animated:YES];
}
-(void)configureUI{
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    
    UIView *topContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.2)];
    UIView *middleContentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height*0.2, self.frame.size.width, self.frame.size.height*0.6)];
    UIView *bottomContentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height*0.8, self.frame.size.width, self.frame.size.height*0.2)];
    
    
    UILabel *topLelfLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, viewHeight*0.2)];
    topLelfLabel.text = @"精品视频";
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    moreButton.frame = CGRectMake(viewWidth-40, 0, 40, 30);
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(clickedMoreVideos) forControlEvents:UIControlEventTouchUpInside];
    
    videoBtn *middleRightButton = [videoBtn buttonWithType:UIButtonTypeSystem];
    videoBtn *middleLeftButton = [videoBtn buttonWithType:UIButtonTypeSystem];
    middleLeftButton.frame =CGRectMake(0, 0, viewWidth/2-1, middleContentView.frame.size.height);
    middleRightButton.frame =CGRectMake(viewWidth/2+2,0,viewWidth/2-1, middleContentView.frame.size.height);
    
    middleLeftButton.imageView.backgroundColor = [UIColor yellowColor];
    middleRightButton.imageView.backgroundColor = [UIColor yellowColor];
    [middleLeftButton setTitle:@"888" forState:UIControlStateNormal];
    [middleRightButton setTitle:@"888" forState:UIControlStateNormal];
    [middleLeftButton addTarget:self action:@selector(clickedVideoButton) forControlEvents:UIControlEventTouchUpInside];
    [middleRightButton addTarget:self action:@selector(clickedVideoButton) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i=0; i<3; i++) {
        UIButton *itemButtom = [UIButton buttonWithType:UIButtonTypeSystem];
        itemButtom.frame = CGRectMake(i*viewWidth/3, 0, viewWidth/3, viewHeight*0.2);
        [itemButtom setTitle:@"666666" forState:UIControlStateNormal];
        itemButtom.layer.borderWidth =1;
        itemButtom.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [itemButtom addTarget:self action:@selector(clickedMoreVideos) forControlEvents:UIControlEventTouchUpInside];
        [bottomContentView addSubview:itemButtom];
    }
    [topContentView addSubview:topLelfLabel];
    [topContentView addSubview:moreButton];
    
    [middleContentView addSubview:middleLeftButton];
    [middleContentView addSubview:middleRightButton];
    
    [self addSubview:topContentView];
    [self addSubview:middleContentView];
    [self addSubview:bottomContentView];
}
@end
