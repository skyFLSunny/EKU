//
//  subjectSortView.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "subjectSortView.h"

@implementation subjectSortView

-(id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
    }
   
    return  self;
}

// 初始化控件
-(void) initControlls
{
    // 科目名称
    NSArray *subjectArray = @[@"语文",@"数学",@"英语",@"物理",@"化学",@"生物",@"政治",@"历史",@"地理"];
    
    // 科目颜色
    NSArray *subjectColor =  @[UIColorFromRGB(0x234fff),UIColorFromRGB(0x234fff),UIColorFromRGB(0x234fff),UIColorFromRGB(0x234fff),UIColorFromRGB(0x234fff),UIColorFromRGB(0x234fff),UIColorFromRGB(0x234fff),UIColorFromRGB(0x234fff),UIColorFromRGB(0x234fff)];
    
}
@end
