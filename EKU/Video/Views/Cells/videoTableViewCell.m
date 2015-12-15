//
//  videoTableViewCell.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "videoTableViewCell.h"
#import "videoBtn.h"
#import "videoInfoViewController.h"
@implementation videoTableViewCell
{
    NSMutableArray *dataArray;  // 视频信息
    NSInteger *num;             //按钮个数
    UILabel *subjectLabel;      // 科目标题
    UIView* sepView;            // 左侧蓝色View；
    NSString* subjectName;
}

- (void)awakeFromNib {
    // Initialization code
}
+ (instancetype)cellWithTableViewCell:(UITableView *)tableView withArray:(NSArray*)aArray withName:(NSString*)aName
{
   
    videoTableViewCell *cell =[[videoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"" withArray:aArray withName:aName];
   
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray*)aArray withName:(NSString*)aName
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
   
    num=(int)aArray.count;
    dataArray = aArray;
    subjectName = aName;
    [self setControl:dataArray];

    return self;
}
-(void)setControl:(NSMutableArray*)aArray
{
    float width = (SCREENWIDTH - 15)/2.0;
    float height = width*2/3.0;
    subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH-10, 25)];
    subjectLabel.text = subjectName;
    sepView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 3,20 )];
    for(int i = 0;i<aArray.count;i++)
    {
        videoBtn* btn = [[videoBtn alloc] initWithFrame:CGRectMake(5+5*(i%2)+width*(i%2), 30+height*(i/2)+5+5*(i/2), width, height)];
        btn.imageView.backgroundColor = [UIColor redColor];
        [btn setTitle:@"rewr" forState:UIControlStateNormal];
        [btn setTitleColor:DAYTEXTCOLOR forState:UIControlStateNormal];
        btn.tag = 1000+i;
        [btn addTarget:self  action:@selector(pressVideo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    [self addSubview:subjectLabel];
    [self addSubview:sepView];
    [self setStyle];
  
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)pressVideo:(id)sender
{
    UIWindow* wi = [[UIApplication sharedApplication] keyWindow];
    UITabBarController* tab = (UITabBarController*)wi.rootViewController;
    UINavigationController*curcon= tab.selectedViewController;
    videoInfoViewController* con = [[videoInfoViewController alloc] init];
    [curcon pushViewController:con animated:YES];
}
-(void) setStyle
{
    self.backgroundColor = DAYBOTTOMColor;
    subjectLabel.textColor = DAYTEXTCOLOR;
    
}
-(void)setSepColor:(NSInteger)aNum
{
    sepView.backgroundColor = SUBJECTCOLOR[aNum];
}
@end
