//
//  videoInfoViewController.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "videoInfoViewController.h"
#import "infoBtn.h"
@interface videoInfoViewController ()

@end

@implementation videoInfoViewController
{
    infoBtn* info;
    UIScrollView* scroll;
    UIView*bgview;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initScroll];
    [self initInfoControll];
    [self setStyle];
    // Do any additional setup after loading the view.
}
-(void)initScroll
{
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, SCREENWIDTH, SCREENHEIGHT-TOPHEIGHT-FOOTHIGHT)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [scroll addSubview:bgview];
    scroll.contentSize = CGSizeMake(SCREENWIDTH,  SCREENWIDTH-TOPHEIGHT-FOOTHIGHT);
    [self.view addSubview:scroll];
}
-(void) initInfoControll
{
    info = [[infoBtn alloc] initWithFrame:CGRectMake(0, 150, SCREENWIDTH, 50)];
    [bgview addSubview:info];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setStyle
{
    scroll.backgroundColor = DAYBACKCOLOR;
    bgview.backgroundColor = DAYBACKCOLOR;
    info.backgroundColor=DAYBOTTOMColor;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
