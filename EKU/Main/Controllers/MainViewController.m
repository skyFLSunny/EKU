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
@end
@implementation MainViewController
-(void) viewDidLoad
{
    self.title =@"首页";
    [super viewDidLoad];
    [self setStyle];
}

// 设置样式
-(void) setStyle
{
    _topSearchBar = [[EKUMineTopSearchBar alloc]initWithFrame:CGRectMake(0, TOPHEIGHT, SCREENWIDTH, 45)];
    _topSearchBar.delegate = self;
    [self.view addSubview:_topSearchBar];
    
    _topVideoView = [[EKUMineTopVideosView alloc]initWithFrame:CGRectMake(0, TOPHEIGHT+45, SCREENWIDTH, SCREENHEIGHT*0.25)];
    [self.view addSubview:_topVideoView];
    
    _middleVideoView = [[EKUMineCompetitiveVideoView alloc]initWithFrame:CGRectMake(0, TOPHEIGHT+45+SCREENHEIGHT*0.25, SCREENWIDTH,  SCREENHEIGHT*0.3)];
    [self.view addSubview:_middleVideoView];
    
    _bottomTest = [[EKUBottomTestView alloc]initWithFrame:CGRectMake(0, _middleVideoView.frame.origin.y+SCREENHEIGHT*0.3, SCREENWIDTH, SCREENHEIGHT-(_middleVideoView.frame.origin.y+SCREENHEIGHT*0.3))];
    [self.view addSubview:_bottomTest];
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
