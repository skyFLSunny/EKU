//
//  PersonalViewController.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PersonalViewController.h"

@implementation PersonalViewController
-(void) viewDidLoad
{
    self.title = @"个人中心";
    [super viewDidLoad];
    [self setStyle];
}

// 设置样式
-(void) setStyle
{
    self.view.backgroundColor = [UIColor redColor];
}
@end
