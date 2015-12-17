//
//  EKUMineTopSearchBar.m
//  EKU
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EKUMineTopSearchBar.h"
@interface EKUMineTopSearchBar()<UISearchBarDelegate>
@end
@implementation EKUMineTopSearchBar{
    UIButton *ykButton;
    UISearchBar *searchbar;
    UIButton *searchButton;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
        [ykButton addTarget:self action:@selector(touchYKButtonAction) forControlEvents:UIControlEventTouchUpInside];
        searchbar.delegate =self;
        [searchButton addTarget:self action:@selector(touchSearchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)touchYKButtonAction{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(ykButtonClickedWithSearchText:)]) {
        [self.delegate ykButtonClickedWithSearchText:searchbar.text];
    }
}
-(void)touchSearchButtonAction{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(ykButtonClickedWithSearchText:)]) {
        [self.delegate ykButtonClickedWithSearchText:searchbar.text];
    }
}
-(void)configureUI{
    self.backgroundColor = DAYTOPBACKCOLOR;
    ykButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchbar = [[UISearchBar alloc]initWithFrame:CGRectZero];
    searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:ykButton];
    [self addSubview:searchButton];
    [self addSubview:searchbar];
    WEAKSELF
    [ykButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(0);
        make.top.equalTo(weakSelf).offset(0);
        make.bottom.equalTo(weakSelf).offset(0);
        make.width.mas_equalTo(40);
    }];
    [searchbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ykButton.mas_right).offset(0);
        make.right.equalTo(searchButton.mas_left).offset(0);
        make.top.equalTo(weakSelf).offset(0);
        make.bottom.equalTo(weakSelf).offset(0);
    }];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(0);
        make.top.equalTo(weakSelf).offset(0);
        make.bottom.equalTo(weakSelf).offset(0);
        make.width.mas_equalTo(40);
    }];
    
    ykButton.backgroundColor = [UIColor blueColor];
    [ykButton setTitle:@"YK" forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
}
@end
