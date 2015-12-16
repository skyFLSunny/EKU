//
//  EKUMineTopVideosView.m
//  EKU
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EKUMineTopVideosView.h"

@implementation EKUMineTopVideosView{
    UIButton *leftButton;
    UIButton *rightTopButtonL;
    UIButton *rightTopButtonR;
    UIButton *rightBottomButtonL;
    UIButton *rightBottomBurronR;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}
-(void)configureUI{
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightTopButtonL =[UIButton buttonWithType:UIButtonTypeSystem];
    rightTopButtonR =[UIButton buttonWithType:UIButtonTypeSystem];
    rightBottomButtonL =[UIButton buttonWithType:UIButtonTypeSystem];
    rightBottomBurronR =[UIButton buttonWithType:UIButtonTypeSystem];
    UIView *rightContentView = [[UIView alloc]init];
    
    [self addSubview:leftButton];
    [self addSubview:rightContentView];
    [rightContentView addSubview:rightTopButtonL];
    [rightContentView addSubview:rightTopButtonR];
    [rightContentView addSubview:rightBottomButtonL];
    [rightContentView addSubview:rightBottomBurronR];
    WEAKSELF
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(0);
        make.top.equalTo(weakSelf).offset(0);
        make.bottom.equalTo(weakSelf).offset(0);
        make.width.mas_equalTo(SCREENWIDTH/2-2);
    }];
    [rightContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(0);
        make.top.equalTo(weakSelf).offset(0);
        make.bottom.equalTo(weakSelf).offset(0);
        make.left.equalTo(leftButton.mas_right).offset(5);
    }];
    [rightTopButtonL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightContentView).offset(0);
        make.top.equalTo(rightContentView).offset(0);
        make.width.mas_equalTo((SCREENWIDTH/2-5)/2-2);
        make.height.mas_equalTo(weakSelf.frame.size.height/2-2);
        make.width.equalTo(rightTopButtonR.mas_width);
        make.height.equalTo(rightBottomButtonL.mas_height);
    }];
    [rightTopButtonR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightContentView).offset(0);
        make.top.equalTo(rightContentView).offset(0);
        make.width.equalTo(rightTopButtonL.mas_width);
        make.height.equalTo(rightTopButtonL.mas_height);
    }];
    [rightBottomButtonL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightContentView).offset(0);
        make.bottom.equalTo(rightContentView).offset(0);
        make.width.equalTo(rightTopButtonR.mas_width);
        make.height.equalTo(rightTopButtonL.mas_height);
    }];
    [rightBottomBurronR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightContentView).offset(0);
        make.bottom.equalTo(rightContentView).offset(0);
        make.width.equalTo(rightTopButtonR.mas_width);
        make.height.equalTo(rightTopButtonR.mas_height);
    }];
    [rightContentView setBackgroundColor:[UIColor yellowColor]];
    [leftButton setBackgroundColor:[UIColor orangeColor]];
    [rightTopButtonL setBackgroundColor:[UIColor redColor]];
    [rightTopButtonR setBackgroundColor:[UIColor blueColor]];
    [rightBottomButtonL setBackgroundColor:[UIColor blueColor]];
    [rightBottomBurronR setBackgroundColor:[UIColor redColor]];
}
@end
