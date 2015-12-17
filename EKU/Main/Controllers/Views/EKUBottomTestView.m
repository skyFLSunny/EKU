//
//  EKUBottomTestView.m
//  EKU
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EKUBottomTestView.h"

@implementation EKUBottomTestView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}
-(void)clickedNewTestButton:(UIButton *)sender{
    NSString *log = [NSString stringWithFormat:@"试题%ld",sender.tag];
    NSLog(@"%@",log);
}
-(void)clickedMoreTestButton{
    NSLog(@"更多试题");
}
-(void)configureUI{
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    
    UIView *topContentView = [[UIView alloc]initWithFrame:CGRectMake(0,0,viewWidth,viewHeight*0.25)];
    topContentView.backgroundColor = [UIColor redColor];
    UIView *bottomContentView =[[UIView alloc]initWithFrame:CGRectMake(0 ,viewHeight*0.2, viewWidth, viewHeight*0.75)];
    bottomContentView.backgroundColor =[UIColor purpleColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80,viewHeight*0.2)];
    titleLabel.text = @"最新试题";
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    moreButton.frame = CGRectMake(viewWidth-40, 0, 40, 30);
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(clickedMoreTestButton) forControlEvents:UIControlEventTouchUpInside];
    [topContentView addSubview:titleLabel];
    [topContentView addSubview:moreButton];
    
    for (int i = 0; i<4; i++) {
        UIButton *testItem = [UIButton buttonWithType:UIButtonTypeSystem];
        testItem.frame = CGRectMake(2+viewWidth/4*i, 0, viewWidth/4-5, viewHeight*0.75-5);
        testItem.backgroundColor = [UIColor yellowColor];
        testItem.tag = 666+i;
        [testItem addTarget:self action:@selector(clickedNewTestButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomContentView addSubview:testItem];
    }
    [self addSubview:topContentView];
    [self addSubview:bottomContentView];
}
@end
