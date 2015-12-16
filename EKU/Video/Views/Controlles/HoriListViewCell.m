//
//  HoriListViewCell.m
//  CustomControl
//
//  Created by Qianshanzhicheng on 15/12/15.
//  Copyright © 2015年 Qianshanzhicheng. All rights reserved.
//

#import "HoriListViewCell.h"

@implementation HoriListViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, frame.size.width, 30)];
        _titleLabel.font = NORMOLEFONT;
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        
        _subLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, frame.size.width, 30)];
        _subLable.font = SMALLFONT;
        _subLable.textColor = [UIColor lightGrayColor];
        
        _sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
        _sepLabel.backgroundColor = DAYBACKCOLOR;
        [self.contentView addSubview:_sepLabel];
        self.backgroundColor = DAYBOTTOMColor;
        [self.contentView addSubview:_subLable];
    }
    return self;
}
@end
