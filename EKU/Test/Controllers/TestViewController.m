//
//  TestViewController.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController
-(void) viewDidLoad
{
    self.title = @"练习";
    [super viewDidLoad];
    [self setStyle];
}

// 设置样式
-(void) setStyle
{
    self.view.backgroundColor = [UIColor  yellowColor];
}
@end
