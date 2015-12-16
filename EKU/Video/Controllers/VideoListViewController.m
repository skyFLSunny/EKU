//
//  VideoListViewController.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "VideoListViewController.h"
#import "videoTableViewCell.h"
#import "videoModel.h"
@interface VideoListViewController ()

@end

@implementation VideoListViewController
{
UITableView *table;
NSMutableArray* dataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initArrays];
    [self initTableView];
     self.title = _toptitle;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setHidden:NO];
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
    table.tableFooterView = [[UIView alloc] init];

    [self.view addSubview:table];
    
    
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  是否支持旋转
 *
 *  @return 是否支持旋转
 */
- (BOOL)shouldAutorotate
{
    return NO;
}
-(void)dealloc
{
    NSLog(@"shifangle ");
}

@end
