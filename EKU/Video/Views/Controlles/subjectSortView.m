//
//  subjectSortView.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "subjectSortView.h"
#import "subjectView.h"
#import "VideoListViewController.h"
#define  BTNTAG 100
@implementation subjectSortView
{
    NSArray *subjectArray;  // 科目名称
    NSArray *subjectColor;  // 科目颜色值
    NSArray *subjectImage;  // 科目图片
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initArrays];
        [self initControlls];
        [self setStyle];
        self.backgroundColor = [UIColor whiteColor];
    }
   
    return  self;
}

// 初始化控件
- (void)initControlls
{
    float jx = 30;
    float width = (SCREENWIDTH - jx*6)/5.0;
    float height = width+25;
    for (int i = 0; i < subjectArray.count; i++)
    {
        subjectView* btn;
        if (i < 5)
        {
            btn = [[subjectView alloc] initWithFrame:CGRectMake(jx*(i+1)+width*i, 10, width, height)];
         
        }
        else
        {
            btn = [[subjectView alloc] initWithFrame:CGRectMake(width/1.2+ jx*(i-4)+width*(i-5),15+height+5, width, height)];
        }
       
        
        btn.textLabel.textColor= DAYTEXTCOLOR ;
        btn.btn.backgroundColor = subjectColor[i];
     
        [btn.btn setImage:[UIImage imageNamed:subjectImage[i] ]forState:UIControlStateNormal];
        btn.selectedTag = i;
        [btn.btn addTarget:self  action:@selector(pressSubject:) forControlEvents:UIControlEventTouchUpInside];
        btn.textLabel.text = subjectArray[i];
        [self addSubview:btn];
    }
   
    
}

// 初始化变量
- (void)initArrays
{
    // 科目名称
   subjectArray = @[@"语文",@"数学",@"英语",@"物理",@"化学",@"生物",@"政治",@"历史",@"地理"];
    
    // 科目颜色
   subjectColor =  @[UIColorFromRGB(0xe88785),UIColorFromRGB(0x65abcf),UIColorFromRGB(0xf6e17c),UIColorFromRGB(0x97dad5),UIColorFromRGB(0xa571f9),UIColorFromRGB(0xcfe15b),UIColorFromRGB(0xf57d37),UIColorFromRGB(0x99c2ff),UIColorFromRGB(0xe35b99)];
    
    // 科目图片
    subjectImage  = @[@"语文.png",@"数学.png",@"英语.png",@"物理.png",@"化学.png",@"生物.png",@"政治.png",@"历史.png",@"地理.png"];

}

- (void)setStyle
{
        self.backgroundColor = DAYBOTTOMColor;
    
}
- (void)pressSubject:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    int tag;
  if([btn.superview isKindOfClass:[subjectView class]])
  {
      tag =(int) ((subjectView*)btn.superview).selectedTag;
      
  }
    VideoListViewController* con = [[VideoListViewController alloc] init];
    UIWindow* wi = [[UIApplication sharedApplication] keyWindow];
    UITabBarController* tab = (UITabBarController*)wi.rootViewController;
    UINavigationController*curcon= tab.selectedViewController;
    con.toptitle = subjectArray[tag];
    [curcon pushViewController:con animated:YES];
    
}
- (void)dealloc
{
    NSLog(@"shifangle ");
}
@end
