//
//  videoInfoViewController.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "videoInfoViewController.h"
#import "PLLIst.h"
#import "infoBtn.h"
#import "KxMovieViewController.h"
#import "testView.h"
#import "showEssayView.h"
#import "InfoDelegate.h"
#import "TYHShowView.h"
#import "FunctionView.h"
#import "CusHoriListView.h"
#import "videoListView.h"
#import "plView.h"
@interface videoInfoViewController ()<InfoDelegate>

@end

@implementation videoInfoViewController
{
    infoBtn *info;
    UIScrollView *scroll;
    UIView *bgview;
    testView *test;
    showEssayView* show;
    FunctionView*Funview;
    CusHoriListView* xjList;
    videoListView* videoList;
    plView* pllist;
    KxMovieViewController* playViewcon;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollCan:) name:@"CANSCROLL" object:nil];
    self.tabBarController.tabBar.hidden = YES;
    [self initScroll];
    [self initPlayView];
    [self initFunctionView];
    [self initXJView];
    [self initTestControl];
    [self initInfoControll];
  
    [self setStyle];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
#pragma mark 初始化
// 初始化滑动view
-(void)initScroll
{
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 250, SCREENWIDTH, SCREENHEIGHT-250)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [scroll addSubview:bgview];
    scroll.contentSize = CGSizeMake(SCREENWIDTH,  SCREENWIDTH-250 );
    [self.view addSubview:scroll];
}
-(void)initPlayView
{
    NSString *path  =@"http://www.qeebu.com/newe/Public/Attachment/99/52958fdb45565.mp4";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // increase buffering for .wmv, it solves problem with delaying audio frames
    if ([path.pathExtension isEqualToString:@"wmv"])
        parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    
    // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    
    // disable buffering
    //parameters[KxMovieParameterMinBufferedDuration] = @(0.0f);
    //parameters[KxMovieParameterMaxBufferedDuration] = @(0.0f);
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                               parameters:parameters];
  

    playViewcon = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                 parameters:parameters];
    [self.view addSubview:playViewcon.view];
}
// 初始化知识详情控件
-(void) initInfoControll
{
    info = [[infoBtn alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    info.delegate = self;
    show = [[showEssayView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-250)];
   
    [bgview addSubview:info];
    [self.view addSubview:show];
}

// 初始化下载列表
-(void)initVideoList
{
    videoList = [[videoListView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-250)];
    videoList.hidden = YES;
    [self.view addSubview:videoList];
}
// 初始化咱下载view
-(void) initFunctionView
{
    Funview = [[FunctionView alloc] initWithFrame:CGRectMake(0, 50+3, SCREENWIDTH, 50) title:@"10万次播放" titleImage:@"播放-1.png" titleSeImg:@"语文-1.png" otherFuncImgs:@[@"btn_audio_ratting.png",@"btn_article_share.png",@"btn_audio_download.png",@"btn_article_favor.png"] otherFuncSeImgs:@[@"btn_audio_ratting.png",@"btn_article_share.png",@"btn_audio_download.png",@"btn_article_favor.png"] ];
    [bgview addSubview:Funview];
    __weak videoInfoViewController* con = self;
    Funview.block = ^(NSInteger tag)
    {
        switch (tag)
        {
          
            case 1:
                [con showPlList];
                break;
            case 2:
                  NSLog(@"%ld",(long)tag);
                break;
            case 3:
                [con showDownList];                break;
            case 4:
                NSLog(@"%ld",(long)tag);
                break;
            default:
                break;
        }
    };
    Funview.backgroundColor = DAYBOTTOMColor;
    
}

-(void)initXJView
{
    xjList = [[CusHoriListView alloc] initWithFrame:CGRectMake(0, Funview.frame.size.height+Funview.frame.origin.y+3, SCREENWIDTH, 120)];
    xjList.dataArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    xjList.titleLabel.text = @"选集";
    [xjList.listView reloadData];
    [bgview addSubview:xjList];
}
// 初始化出题控件
-(void) initTestControl
{
   test  = [[testView alloc] initWithFrame:CGRectMake(0, xjList.frame.origin.y+xjList.frame.size.height+3, SCREENWIDTH, 230)];
    bgview.frame = CGRectMake(0,0, SCREENWIDTH,  test.frame.origin.y+test.frame.size.height+20);
    scroll.contentSize = CGSizeMake(0, bgview.frame.size.height);
    [bgview addSubview:test];
}

// 初始化评论View
-(void)initPlListView
{
    pllist = [[plView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-250)];
    pllist.hidden = YES;
    pllist.plView.contentID = 1617;
    pllist.plView.dataArray = [[NSMutableArray alloc] init];
    [pllist.plView reloadDataInfo];
    pllist.backgroundColor = DAYBOTTOMColor;
    pllist.plView.backgroundColor = DAYBOTTOMColor;
    [self.view addSubview:pllist];
}
#pragma mark delegate
-(void)showEssayDelegate
{
    
    show.hidden = NO;
    scroll.scrollEnabled = NO;
    [ UIView animateWithDuration:0.3 animations:^{
        show.frame =  CGRectMake(0, (250), SCREENWIDTH, SCREENHEIGHT-250+10);
        [show showContent:@"　　飞机起飞前，一位乘客请求空姐给他倒一杯水吃药。空姐很有礼貌地喻：”先生，为了您的安全，请稍等片刻，等飞机进入平稳飞行后，我会立刻把水给您送过来，好吗？” 　　15分钟后，飞机早已进入了平稳飞行状态。突然，乘客服务铃急促地响了起来，空姐猛然意识到：糟了，由于太忙，她忘记给那位乘客倒水了！当空姐来到客舱，看见按响服务铃的果然是刚才那位乘客。她小心翼翼地把水送到那位乘客跟前，面带微笑地说：”先生，实在对不起，由于我的疏忽，延误了您吃药的时间，我感到非常抱歉。”这侠乘客抬起左手，指着手表说道：“怎么回事，有你这样服务的吗？”空姐手里端着水，心里感到很委屈，但是，无论她怎么解释，这位挑剔的乘客都不肯原谅她的疏忽。 　　{img,2015/12/5934-367-266.jpg} 　　接下来的飞行途中，为了补偿自己的过失，每次去客舱给乘客服务时，空姐都会特意走到那位乘客面前，面带微笑地询问他是否需要水，或者别的什么帮助。然面，那位乘客余怒未消，摆出一副不合作的样子，并不理会空姐。 　　临到目的地前，那位乘客要求空姐把留言本给他送过去，很显然，他要投诉这名空姐。此时空姐心里虽然很委屈，但是仍然不失职业道德，显得非常有礼貌，而且面带微笑地说道：”先生，请允许我再次向您表示真诚的歉意，无论你提出什么意见，我都将欣然接受您的批评！”那位乘客脸色一紧，嘴巴准备说什么，可是却没有开口，他接过留言本，开始在本子上写了起来。 　　等到飞机安全降落，所有的乘客陆续离开后，空姐本以为这下完了，没想到，等她打开留言本，却惊奇地发现，那位乘客在本子上写下的并不是投诉信，相反，这是一封热情洋溢的表扬信。 "];   
    }];
   
}
#pragma mark 事件处理
// 下载按钮事件处理
- (void)showDownList
{
    if(videoList==nil)
    {
        [self initVideoList];
    }
    videoList.hidden = NO;
    scroll.scrollEnabled = NO;
    [videoList reloadDataWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    [UIView animateWithDuration:0.3 animations:^{
        videoList.frame =  CGRectMake(0, (250), SCREENWIDTH, SCREENHEIGHT-250+10);
    }];
}

// 下载按钮事件处理
- (void)showPlList
{
    if(pllist==nil)
    {
        [self initPlListView];
    }
    pllist.hidden = NO;
    scroll.scrollEnabled = NO;
     [pllist.plView reloadDataInfo];
    [UIView animateWithDuration:0.3 animations:^{
        pllist.frame =  CGRectMake(0, (playViewcon.view.frame.size.height), SCREENWIDTH, SCREENHEIGHT-250+10);
         [pllist.plView reloadDataInfo];
    }];
}

#pragma  mark 其他
-(void)setStyle
{
    scroll.backgroundColor = DAYBACKCOLOR;
    bgview.backgroundColor = DAYBACKCOLOR;
    info.backgroundColor=DAYBOTTOMColor;
    test.backgroundColor = DAYBOTTOMColor;
    xjList.backgroundColor = DAYBOTTOMColor;
    Funview.backgroundColor = DAYBOTTOMColor;
    self.view.backgroundColor = DAYBACKCOLOR;
    pllist.backgroundColor = DAYBOTTOMColor;
    xjList.listView.backgroundColor = DAYBOTTOMColor;
    
}
-(void)scrollCan:(NSNotification*)no
{
    scroll.scrollEnabled = YES;
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CANSCROLL" object:nil];
}
@end
