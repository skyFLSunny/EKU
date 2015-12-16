//
//  videoListView.m
//  EKU
//
//  Created by 李瑶 on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "videoListView.h"
#import "UIView+CurveAnimation.h"
#import "TopView.h"
@implementation videoListView{
    UITableView* table;
    UIView* headerView;
    UILabel* titileLabel;
    UIView* sepView;
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
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, SCREENWIDTH, self.frame.size.height-45) style:UITableViewStylePlain];
 
        table.autoresizesSubviews = NO;
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    [self addSubview:table];
    
}
-(void)initHeader
{
    headerView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 45) withTitle:@"下载"];
    
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame  =CGRectMake(SCREENWIDTH-50, 0, 45, 45);
    [cancelBtn setImage:[UIImage imageNamed:@"btn_error2.png"] forState:UIControlStateNormal];
    [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [cancelBtn addTarget:self  action:@selector(pressCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:cancelBtn];
    
    [self addSubview:headerView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [table dequeueReusableCellWithIdentifier:@"VIDEOCELL" ];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"VIDEOCELL"];
        cell.textLabel.textColor = DAYTEXTCOLOR;
        cell.detailTextLabel.textColor = DAYBACKCOLOR;
        cell.textLabel.font = NORMOLEFONT;
        cell.detailTextLabel.font = SMALLFONT;
    }
    cell.textLabel.text = @"不等式";
      cell.detailTextLabel.text = @"不等式vdsgdfgdfgdg";
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell* cell = [table cellForRowAtIndexPath:indexPath];
     UITableViewCell* ivcell = [[UITableViewCell alloc] initWithFrame:cell.frame];
     ivcell.frame = CGRectMake(ivcell.frame.origin.x,(indexPath.row+1)*ivcell.frame.size.height-tableView.contentOffset.y, ivcell.frame.size.width, ivcell.frame.size.height);
    [self addSubview:ivcell];
    [UIView animateWithDuration:0.1 animations:^{
           ivcell.transform = CGAffineTransformScale(cell.transform, 0.5*60/SCREENWIDTH, 0.5);
    } completion:^(BOOL finished) {
        ivcell.backgroundColor = DAYTOPBACKCOLOR;
        [(UIView *)cell  animationByStartPoint:ivcell.center endPoint:CGPointMake(-20, SCREENHEIGHT )scale:1 time:0.5 moveView:ivcell];
    }];
    
}
-(void)reloadDataWithArray:(NSMutableArray*)array
{
    dataArray = array;
    [table reloadData];
}
-(void)animate
{
    
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
@end
