//
//  testView.m
//  EKU
//
//  Created by 李瑶 on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "testView.h"

@implementation testView
{
    UIView *sepView;        // 分割view
    UILabel *titleLable;    // 分类名称
    UIButton *recommendBtn; // 推荐试题
    UIButton *errorBtn;     // 易错题
    UIButton *difficultBtn; // 难题
    UIButton *classicBtn;   // 经典试题
    
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initControl];
        [self setStyle];
        
    }
    
    return self;
}

// 初始化控件
- (void)initControl
{
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10,0, 200, 30)];
    titleLable.text = @"精选试题";
    sepView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, 3, 20)];
    
    // 推荐试题
    recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recommendBtn.frame = CGRectMake(15, 40, SCREENWIDTH-30,(self.frame.size.height-60)*2/3.0);
    recommendBtn.tag = 1000;
    [recommendBtn setTitle:@"推荐试题 "forState:UIControlStateNormal];
    [recommendBtn addTarget:self  action:@selector(pressTest:) forControlEvents:UIControlEventTouchUpInside];
    
    float width = (SCREENWIDTH - 40)/3.0;
    float py = recommendBtn.frame.size.height+recommendBtn.frame.origin.y+5;
    
    // 易错题
    errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    errorBtn.frame = CGRectMake(15, py, width, (self.frame.size.height-60)/3.0);
     errorBtn.tag = 1001;
    [errorBtn setTitle:@"易错试题 "forState:UIControlStateNormal];
    [errorBtn addTarget:self  action:@selector(pressTest:) forControlEvents:UIControlEventTouchUpInside];
    
    // 难题
    difficultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      difficultBtn.tag = 1002;
    [difficultBtn setTitle:@"难题"forState:UIControlStateNormal];
    difficultBtn.frame = CGRectMake(15+width+5, py, width, (self.frame.size.height-60)/3.0);
    [difficultBtn addTarget:self  action:@selector(pressTest:) forControlEvents:UIControlEventTouchUpInside];
    
    // 经典试题
    classicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    classicBtn.frame = CGRectMake(15+width*2+10, py, width, (self.frame.size.height-60)/3.0);
      [classicBtn setTitle:@"经典试题"forState:UIControlStateNormal];
    classicBtn.tag = 1003;
    [classicBtn addTarget:self  action:@selector(pressTest:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:titleLable];
    [self addSubview:sepView];
    [self addSubview:recommendBtn];
    [self addSubview:errorBtn];
    [self addSubview:difficultBtn];
    [self addSubview:classicBtn];
}

// 设置空间样式
- (void)setStyle
{
    sepView.backgroundColor = SUBJECTCOLOR[_sortID];
    titleLable.textColor = DAYTEXTCOLOR;
    titleLable.font = BIGFONT;
    
    recommendBtn.backgroundColor = UIColorFromRGB(0X2ba1d4);
     errorBtn.backgroundColor = UIColorFromRGB(0Xff8956);
     difficultBtn.backgroundColor = UIColorFromRGB(0X26c9bb);
     classicBtn.backgroundColor = UIColorFromRGB(0Xe08099);
    
    [recommendBtn setTitleColor:DAYTOPTEXTCOLOR forState:UIControlStateNormal];
    [errorBtn setTitleColor:DAYTOPTEXTCOLOR forState:UIControlStateNormal];
    [difficultBtn setTitleColor:DAYTOPTEXTCOLOR forState:UIControlStateNormal];
    [classicBtn setTitleColor:DAYTOPTEXTCOLOR forState:UIControlStateNormal];
    
    // 切圆角
    [recommendBtn.layer setCornerRadius:5.0];
    [difficultBtn.layer setCornerRadius:5.0];
    [errorBtn.layer setCornerRadius:5.0];
    [classicBtn.layer setCornerRadius:5.0];
    [recommendBtn.layer setMasksToBounds:YES];
    [difficultBtn.layer setMasksToBounds:YES];
    [errorBtn.layer setMasksToBounds:YES];
    [classicBtn.layer setMasksToBounds:YES];
}

- (void)pressTest:(id)sender
{
    
}
- (void)dealloc
{
    NSLog(@"shifangle ");
}
@end
