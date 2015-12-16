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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollCan:) name:@"CANSCROLL" object:nil];
    [self initScroll];
    [self initFunctionView];
    [self initXJView];
    [self initTestControl];
    [self initInfoControll];
  
    [self setStyle];
    // Do any additional setup after loading the view.
}
#pragma mark 初始化
// 初始化滑动view
-(void)initScroll
{
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, SCREENWIDTH, SCREENHEIGHT-TOPHEIGHT-FOOTHIGHT)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [scroll addSubview:bgview];
    scroll.contentSize = CGSizeMake(SCREENWIDTH,  SCREENWIDTH-TOPHEIGHT-FOOTHIGHT);
    [self.view addSubview:scroll];
}

// 初始化知识详情控件
-(void) initInfoControll
{
    info = [[infoBtn alloc] initWithFrame:CGRectMake(0, 200, SCREENWIDTH, 50)];
    info.delegate = self;
    show = [[showEssayView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-info.frame.origin.y-FOOTHIGHT-TOPHEIGHT)];
   
    [bgview addSubview:info];
    [bgview addSubview:show];
}

// 初始化下载列表
-(void)initVideoList
{
    videoList = [[videoListView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-info.frame.origin.y-FOOTHIGHT-TOPHEIGHT+scroll.contentOffset.y)];
    videoList.hidden = YES;
    [bgview addSubview:videoList];
}
// 初始化咱下载view
-(void) initFunctionView
{
    Funview = [[FunctionView alloc] initWithFrame:CGRectMake(0, 250+3, SCREENWIDTH, 50) title:@"10万次播放" titleImage:@"播放-1.png" titleSeImg:@"语文-1.png" otherFuncImgs:@[@"btn_audio_ratting.png",@"btn_article_share.png",@"btn_audio_download.png",@"btn_article_favor.png"] otherFuncSeImgs:@[@"btn_audio_ratting.png",@"btn_article_share.png",@"btn_audio_download.png",@"btn_article_favor.png"] ];
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
    pllist = [[plView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-info.frame.origin.y-FOOTHIGHT-TOPHEIGHT+scroll.contentOffset.y)];
    pllist.hidden = YES;
    pllist.plView.contentID = 1617;
    pllist.plView.dataArray = [[NSMutableArray alloc] init];
    [pllist.plView reloadDataInfo];
    pllist.backgroundColor = DAYBOTTOMColor;
    pllist.plView.backgroundColor = DAYTOPBACKCOLOR;
    [bgview addSubview:pllist];
}
#pragma mark delegate
-(void)showEssayDelegate
{
    
    show.hidden = NO;
    scroll.scrollEnabled = NO;
    [ UIView animateWithDuration:0.3 animations:^{
        show.frame = CGRectMake(0, bgview.frame.size.height-(SCREENWIDTH, SCREENHEIGHT-info.frame.origin.y-FOOTHIGHT-TOPHEIGHT)-info.frame.size.height-10, SCREENWIDTH, SCREENHEIGHT-info.frame.origin.y-FOOTHIGHT-TOPHEIGHT+scroll.contentOffset.y+10);
        [show showContent:@"1.猫和猪是好朋友。一天猫掉进大坑，猪拿来绳子，猫叫猪把绳子扔下来，结果它整捆扔了下去。猫很郁闷的说：这样扔下来，怎么拉我上去？猪说：不然怎么做？猫说：你应该拉住一头绳子啊！猪就跳下去，拿了绳子的一头，说：现在可以了！猫哭了，哭得很幸福； <b>有的人不是很聪明，却值得你终生拥有。</b> 3. 工人向朋友抱怨：“活是我们干的，受到表扬的却是组长，最后的成果又都变成经理的了不公平”。朋友微笑说：“看看你的手表，是不是先看时针，再看分针，可是运转最多的秒针你却看都不看一眼”。 <b>日常生活，感到不公平就要付出努力做前者，抱怨是没有用的。</b> 　　 4. 老和尚问小和尚：“如果你前进一步是死后退一步则亡，你该怎么办”小和尚毫不犹豫地说：“我往旁边去”。 <b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b> <b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考<b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b>，也许就会明白：路的旁边还是路。 </b><b>天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。天无绝人之路，人生路上遭遇进退两难的境况时，换个角度思考，也许就会明白：路的旁边还是路。 </b>"];   
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
        videoList.frame =  CGRectMake(0, bgview.frame.size.height-(SCREENWIDTH, SCREENHEIGHT-info.frame.origin.y-FOOTHIGHT-TOPHEIGHT)-info.frame.size.height-10, SCREENWIDTH, SCREENHEIGHT-info.frame.origin.y-FOOTHIGHT-TOPHEIGHT+scroll.contentOffset.y+10);
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
   
    [UIView animateWithDuration:0.3 animations:^{
        pllist.frame =  CGRectMake(0, bgview.frame.size.height-(SCREENWIDTH, SCREENHEIGHT-info.frame.origin.y-FOOTHIGHT-TOPHEIGHT)-info.frame.size.height-10, SCREENWIDTH, SCREENHEIGHT-info.frame.origin.y-FOOTHIGHT-TOPHEIGHT+scroll.contentOffset.y+10);
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
    pllist.backgroundColor = DAYBOTTOMColor;
    xjList.listView.backgroundColor = DAYBOTTOMColor;
    
}
-(void)scrollCan:(NSNotification*)no
{
    scroll.scrollEnabled = YES;
}
-(void)dealloc
{
    NSLog(@"shifangle ");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CANSCROLL" object:nil];
}
@end
