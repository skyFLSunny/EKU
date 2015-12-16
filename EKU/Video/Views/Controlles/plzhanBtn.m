//
//  plzhanBtn.m
//  LYrecite
//
//  Created by tanyuehong on 15/9/24.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import "plzhanBtn.h"
#import "NSString+LW.h"

@implementation plzhanBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSString  *title = self.currentTitle;

    CGSize titleSzie = [title sizeWithFont:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect  frame = self.frame;
    self.titleLabel.frame = CGRectMake(0, 0, titleSzie.width, frame.size.height);
    self.imageView.frame = CGRectMake(titleSzie.width+2, 2,frame.size.height/1.5,frame.size.height/1.5);
}

@end
