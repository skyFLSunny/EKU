//
//  MainViewController.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MainViewController.h"
#import "EKUMineTopSearchBar.h"
#import "EKUMineTopVideosView.h"
#import "EKUMineCompetitiveVideoView.h"
#import "EKUBottomTestView.h"
@interface MainViewController()<EKUMineTopSearchBarDelegate>
@property (nonatomic,strong) EKUMineTopSearchBar *topSearchBar;
@property (nonatomic,strong) EKUMineTopVideosView *topVideoView;
@property (nonatomic,strong) EKUMineCompetitiveVideoView *middleVideoView;
@property (nonatomic,strong) EKUBottomTestView *bottomTest;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@end
@implementation MainViewController
-(void) viewDidLoad
{
    self.title =@"首页";
    self.automaticallyAdjustsScrollViewInsets =NO;
    [super viewDidLoad];
    UIDevice *d =[UIDevice currentDevice];
    [d description];
    [self setStyle];
}

// 设置样式
-(void) setStyle
{
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPHEIGHT, SCREENWIDTH, SCREENHEIGHT-FOOTHIGHT-TOPHEIGHT)];
    _bgScrollView.backgroundColor = [UIColor whiteColor];
    _bgScrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT-FOOTHIGHT);
    [self.view addSubview:_bgScrollView];
    _topSearchBar = [[EKUMineTopSearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 45)];
    _topSearchBar.delegate = self;
    [_bgScrollView addSubview:_topSearchBar];
    
    _topVideoView = [[EKUMineTopVideosView alloc]initWithFrame:CGRectMake(0, 45, SCREENWIDTH, SCREENHEIGHT*0.25)];
    [_bgScrollView addSubview:_topVideoView];
    
    _middleVideoView = [[EKUMineCompetitiveVideoView alloc]initWithFrame:CGRectMake(0, 45+SCREENHEIGHT*0.25, SCREENWIDTH,  SCREENHEIGHT*0.3)];
    [_bgScrollView addSubview:_middleVideoView];
    
    _bottomTest = [[EKUBottomTestView alloc]initWithFrame:CGRectMake(0, _middleVideoView.frame.origin.y+SCREENHEIGHT*0.3, SCREENWIDTH, SCREENHEIGHT-(_middleVideoView.frame.origin.y+SCREENHEIGHT*0.3)-FOOTHIGHT-TOPHEIGHT)];
    [_bgScrollView addSubview:_bottomTest];
    self.view.backgroundColor = [UIColor  greenColor];
}
//
-(void)ykButtonClickedWithSearchText:(NSString *)searchText{
    [self.view endEditing:YES];
}
//
-(void)searchButtonClickWithSearchText:(NSString *)searchText{
    [self.view endEditing:YES];
}
@end
