//
//  infoBtn.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "infoBtn.h"

@implementation infoBtn
{
    UILabel *subjectTitle;       // 科目名称
    UILabel *sortTitle;          // 分类Title
    UILabel *infoLabel;          // 知识详情
    UIImageView *infoimage;      // 详情箭头
    
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
    subjectTitle = [[UILabel alloc] initWithFrame:CGRectMake(6,( self.frame.size.height-25)/2.0, 40, 25)];
    sortTitle = [[UILabel alloc] initWithFrame:CGRectMake(55, 3, 200, self.frame.size.height-6)];
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-100, 3, 80, self.frame.size.height-6)];
    infoLabel.textAlignment = NSTextAlignmentRight;
    infoimage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH-15, (self.frame.size.height-10)/2.0, 10, 10)];
    infoimage.image = [UIImage imageNamed:@"更多"];
    infoLabel.text = @"知识详情";
    [self addTarget:self  action:@selector(showEssayView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:subjectTitle];
    [self addSubview:sortTitle];

    [self addSubview:infoimage];

    [self addSubview:infoLabel];
    [self setInfo:@""];

}

// 设置样式
- (void)setStyle
{
    subjectTitle.backgroundColor = DAYTOPBACKCOLOR;
    subjectTitle.textColor = DAYTOPTEXTCOLOR;
    sortTitle.textColor = DAYTEXTCOLOR;
    infoLabel.textColor = DAYTEXTCOLOR;
    subjectTitle.textAlignment = NSTextAlignmentCenter;
    subjectTitle.font = SMALLFONT;
    sortTitle.font = NORMOLEFONT;
    infoLabel.font = NORMOLEFONT;
    [subjectTitle.layer setCornerRadius:subjectTitle.frame.size.height/4.0];
   [subjectTitle.layer setMasksToBounds:YES];
}
-(void)setInfo:(NSString*)setr
{
    subjectTitle.text = @"数学";
    sortTitle.text = @"不等式";
}
// 点击事件处理
- (void)showEssayView:(id)sender
{
    [self.delegate showEssayDelegate];
}

- (void)dealloc
{
    NSLog(@"shifangle ");
}
@end
