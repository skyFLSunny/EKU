//
//  showEssayView.m
//  EKU
//
//  Created by 李瑶 on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "showEssayView.h"
#import "TopView.h"
@implementation showEssayView
{
    UIScrollView* scroll;   // 滑动控件
    TopView * topView;        // 顶部view
    UILabel* titleLabel;    // 知识详情titile
    UIButton* cancelBtn;    // 取消按钮
    UIView* sepView;        // 分割线
    TYHShowView* showView;  // 文章内容显示控件
}

-(id) initWithFrame:(CGRect)frame
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
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH, self.frame.size.height-50)];
  
    topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 45) withTitle:@"知识详情"];
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame  =CGRectMake(SCREENWIDTH-50, 0, 45, 45);
    [cancelBtn setImage:[UIImage imageNamed:@"btn_error2.png"] forState:UIControlStateNormal];
    [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [cancelBtn addTarget:self  action:@selector(pressCancel:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtn];
    
    showView = [[TYHShowView alloc] init];
    showView.frame =CGRectMake(0, 0,SCREENWIDTH , self.frame.size.height-50);
    showView.delegete = self;
    self.hidden = YES;
    [scroll addSubview:showView];
    [self addSubview:topView];
    [self addSubview:scroll];
    scroll.contentSize = CGSizeMake(SCREENWIDTH, self.frame.size.height-50);
  
    
    
}

// 设置控件样式
- (void)setStyle
{
    titleLabel.textColor = DAYTEXTCOLOR;
    sepView.backgroundColor = DAYBACKCOLOR;
    self.backgroundColor = DAYBOTTOMColor;
    scroll.backgroundColor = DAYBOTTOMColor;
  
}

// 取消按钮事件处理
- (void)pressCancel:(id)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
         self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.hidden=YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CANSCROLL" object:self userInfo:nil];
    }];
   
}

// 展示文章内容
- (void)showContent:(NSString*)str
{
    TYHShowContenModel* model = [[TYHShowContenModel alloc] init];
    model.textFont =NORMOLEFONT;
    model.textColor =DAYTEXTCOLOR;
    model.backgroudColor =DAYBOTTOMColor;
    model.mathFlag= 1;
    model.lineSpace = 15*0.5;
    scroll.frame = CGRectMake(0, scroll.frame.origin.y, SCREENWIDTH, self.frame.size.height-50);
    showView.frame = CGRectMake(0, 0,SCREENWIDTH , self.frame.size.height-50);
    scroll.contentSize  = CGSizeMake(SCREENWIDTH, scroll.frame.size.height-50);
     [showView shengchengNeiRong:str withModel:model with:self];
    titleLabel.text = @"不等式";
   
}

// 文章显示空间代理
- (void)TYHShowViewWillShow:(CGSize )size   withFlag:(int) flag
{
  
    scroll.contentSize = CGSizeMake(SCREENWIDTH, size.height);
    
}


- (void)dealloc
{
    NSLog(@"shifangle ");
}
@end
