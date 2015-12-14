//
//  MainViewController.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MainViewController.h"

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
    self.view.backgroundColor = [UIColor  greenColor];
}
@end
