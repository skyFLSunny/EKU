//
//  EKUPrecticeSectionView.m
//  EKU
//
//  Created by ruoyi on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EKUPrecticeSectionView.h"

@implementation EKUPrecticeSectionView

- (void)awakeFromNib{
	CALayer *border = [CALayer layer];
	border.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10);
	border.backgroundColor = [UIColor redColor].CGColor;
	[self.layer addSublayer:border];
}

@end
