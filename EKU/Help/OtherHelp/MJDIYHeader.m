//
//  MJDIYHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYHeader.h"
#import "NSString+LW.h"
#import "UIImage+Tint.h"
@interface MJDIYHeader()
@property (weak, nonatomic) UILabel *mylabel;

@property (weak, nonatomic) UIImageView *botm;
@property (weak, nonatomic) UIImageView *cover;

@property (assign,nonatomic)CGSize  lableSize;

@property (assign,nonatomic)BOOL istate;

@property (assign,nonatomic)int   first;


@end

@implementation MJDIYHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    [super prepare];
    for (int  i = 1; i<=20; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh1"]];
        UIImage* im = [image imageWithTintColor:DAYTOPBACKCOLOR];
        [idleImages addObject:im];
        
    }
    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
//    self.stateLabel.hidden = YES;
    for (int  i = 1; i<=30; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]];
        UIImage* im = [image imageWithTintColor:DAYTOPBACKCOLOR];
        [idleImages addObject:im];
       
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int  i = 31; i<=36; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]];
        UIImage* im = [image imageWithTintColor:DAYTOPBACKCOLOR];
   
        [refreshingImages addObject:im];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
     
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];

    self.mj_h=90;


    


}
- (void)setTyRefreshLable:(NSString *)titile titilesSate:(int) state
{
    if (state ==1) {
        [self setTitle:titile forState:MJRefreshStateIdle];
    }else if (state == 2)
    {
        [self setTitle:titile forState:MJRefreshStatePulling];
        
    }else if (state == 3)
    {
        [self setTitle:titile forState:MJRefreshStateRefreshing];
    }
}

@end
