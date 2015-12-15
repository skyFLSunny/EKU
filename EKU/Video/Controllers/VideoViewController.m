//
//  VideoViewController.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "VideoViewController.h"
#import "subjectSortView.h"
#import "videoTableViewCell.h"
#import "videoModel.h"
@implementation VideoViewController
{
    subjectSortView *sortView;
    UITableView *table;
    NSMutableArray* dataArray;
}
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"推荐视频";
   
    [self initArrays];
    [self initSortView];
    [self initTableView];
    [self setStyle];
}
-(void)viewWillAppear:(BOOL)animated
{
    [table reloadData];
}
#pragma mark 初始化
-(void)initArrays
{
    dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<9; i++)
    {
        videoModel*model;
        if (i/3==0)
        {
           model = [[videoModel alloc] init];
            model.videoArray = @[@"",@"",@"",@""];
        }
        else if (i/3==1)
        {
            model  = [[videoModel alloc] init];
            model.videoArray = @[@"",@"",@""];
        }
        else
        {
            model  = [[videoModel alloc] init];
            model.videoArray = @[@"",@"",@""];

        }
        model.height = 30+((SCREENWIDTH-15)/2.0*2/3.0+10)*(model.videoArray.count/2)+ ((model.videoArray.count)%2>0?1:0)*((SCREENWIDTH-30)/2.0*2/3.0+20);
        model.subjectTitle = [NSString stringWithFormat:@"%d",i];
        [dataArray addObject:model];
    }
}
-(void)initTableView
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, SCREENWIDTH,SCREENHEIGHT-TOPHEIGHT-FOOTHIGHT )];
    self.automaticallyAdjustsScrollViewInsets = NO;
    table.allowsSelection=NO;
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = DAYBACKCOLOR;
    table.tableHeaderView = sortView;
    table.tableFooterView = [[UIView alloc] init];
    table.sectionHeaderHeight = 45;
    [self.view addSubview:table];
   
   
 
}
// 初始化科目控件
-(void)initSortView
{
    float height = ((SCREENWIDTH-90)/5.0+30)*2;
    sortView = [[subjectSortView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,height )];
  
}

#pragma mark 代理
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    videoModel* model = dataArray[indexPath.row];
    
    return model.height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* segView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 45)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 40)];
    segView.backgroundColor = DAYBACKCOLOR;
    label.backgroundColor = DAYBOTTOMColor;
    label.text  = @"小编推荐";
    label.textAlignment = NSTextAlignmentCenter;
    [segView addSubview:label];
    return segView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   videoModel* model= dataArray[indexPath.row];
    videoTableViewCell* cell = [videoTableViewCell cellWithTableViewCell:table withArray:model.videoArray withName:model.subjectTitle];
    [cell setSepColor:indexPath.row];
        return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
#pragma mark 其他
// 设置样式
-(void) setStyle
{
    self.view.backgroundColor =DAYBACKCOLOR ;
  
    sortView.backgroundColor = DAYBOTTOMColor;
}
-(void)dealloc
{
    NSLog(@"shifangle ");
}
@end
