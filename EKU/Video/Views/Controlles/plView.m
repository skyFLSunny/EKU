//
//  plView.m
//  EKU
//
//  Created by 李瑶 on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "plView.h"
#import "TopView.h"
@implementation plView
{
    
    TopView* headerView;
    UIButton* cancelBtn;
    NSMutableArray* dataArray;
}
- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initHeader];
        [self initTable];
        //        [self setStyle];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return  self;
}
-(void)initTable
{
    PLLIst* pl  = [[PLLIst alloc] initWithFrame:CGRectMake(0, 45, SCREENWIDTH, self.frame.size.height-45)];
    
    _plView = pl;

    [self addSubview:_plView];
    
}
-(void)initHeader
{
    headerView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 45) withTitle:@"评论"];
   
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame  =CGRectMake(SCREENWIDTH-50, 0, 45, 45);
    [cancelBtn setImage:[UIImage imageNamed:@"btn_error2.png"] forState:UIControlStateNormal];
    [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [cancelBtn addTarget:self  action:@selector(pressCancel:) forControlEvents:UIControlEventTouchUpInside];
   
    [headerView addSubview:cancelBtn];
    
    [self addSubview:headerView];
}
-(void)pressCancel:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.hidden=YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CANSCROLL" object:self userInfo:nil];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
