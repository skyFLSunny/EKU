//
//  LYDIYFooter.m
//  LYrecite
//
//  Created by tanyuehong on 15/8/5.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import "LYDIYFooter.h"
#import "UIImage+Tint.h"
@implementation LYDIYFooter

- (void)prepare
{
    [super prepare];
   // self.backgroundColor=DEL.pf.topColor;
    self.mj_h = 110;
    
        // 设置普通状态的动画图片
        NSMutableArray *idleImages = [NSMutableArray array];
    for (int  i = 1; i<=30; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", 1]];
        UIImage* im = [image imageWithTintColor:DAYTOPBACKCOLOR];
        [idleImages addObject:im];
        
    }
    

    for (int  i = 1; i<=30; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]];
        UIImage* im = [image imageWithTintColor:DAYTOPBACKCOLOR];
        [idleImages addObject:im];
        
    }
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int  i = 31; i<=36; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]];
        UIImage* im = [image imageWithTintColor:DAYTOPBACKCOLOR];
        
        [refreshingImages addObject:im];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.mj_h=100;
    
    
}

- (void)setTyFooterRefreshLable:(NSString *)titile titilesSate:(int) state
{
     self.backgroundColor=DAYBOTTOMColor;
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
