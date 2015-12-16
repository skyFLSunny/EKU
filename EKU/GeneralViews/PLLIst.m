//
//  PLLIst.m
//  LYrecite
//
//  Created by 李瑶 on 15/11/9.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import "PLLIst.h"
#import "PLTableViewCell.h"

#import "MJDIYHeader.h"
#import "LYDIYFooter.h"
#import "plModel.h"
#import "UIImageView+WebCache.h"
#import "plModelFrame.h"
static int pageNum = 1;

@implementation PLLIst{
    NSMutableArray*_dataArray;
 UITableView * _tableView;
    UIImageView* bgimage;
    int _lastPosition;

}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame ]) {
        //        self.backgroundColor = [UIColor redColor];
        
        _dataArray = [NSMutableArray array];
              _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, frame.size.height)];
        //        _tableView.bounces = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(reloadPL:)  name:@"CHANGEPL" object:nil];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.backgroundColor = [UIColor clearColor];
        
        
        _tableView.editing = NO;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = DAYBACKCOLOR;
        _tableView.backgroundColor =DAYBOTTOMColor;
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
        _tableView.footer = [LYDIYFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpRefreshDidFinish)];
        _tableView.header = [MJDIYHeader headerWithRefreshingTarget:self  refreshingAction:@selector(pullDownRefreshDidFinish)];
        _tableView.allowsSelection=NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chagePLlPF:) name:@"CHANGEPF" object:nil];
    }
    return self;
}
-(void)addNoInfoView
{
    if ([self.subviews containsObject:bgimage]) {
        [bgimage removeFromSuperview];
    }
    float width = 750/900.0*250;
    bgimage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH-width)/2.0, (_tableView.frame.size.height-250)/2.0, width,250)];
    
    
    
    
    [self addSubview:bgimage];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    plModelFrame *modeFrme= _dataArray[indexPath.row];
    return modeFrme.cellHeigt;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    plModelFrame* model1 = _dataArray[indexPath.row];
    PLTableViewCell* cell = [PLTableViewCell cellWithTableVieplCell:tableView];
    cell.isxp = _isXP;
    cell.model=model1;
    [cell.wzbtn.layer setCornerRadius:5];
    [cell.wzbtn.layer setMasksToBounds:YES];
    cell.backgroundColor = DAYTOPBACKCOLOR;
    [cell setStyle];
    cell.selected = NO;
   
    __weak PLTableViewCell* ce = cell;
    cell.plbtn=^(){
        
        [self zpRequestInfo:model1.model.NewsReplayID];
      
        ce.model=model1;
        [ce setStyle];
        
        
    };
    cell.con = _con;
    cell.delegate      = self;
    cell.userLabel.text =[NSString stringWithFormat:@"%@",model1.model.petName] ;
    NSURL *url = [NSURL URLWithString:model1.model.urlImage];
    if(_isMy)
    {
        cell.tximage.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"HEAD"]];
        
    }
    else
    {
        [cell.tximage  sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"加载图片"]];
    }
    cell.backgroundColor = DAYBOTTOMColor;
    return cell;
}
- (void)cellDeleteBtnClick:(plModelFrame *)model
{
    [_dataArray removeObject:model];
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(void) initPLRequest:(NSString*)urlStr
{
    
    lyDownLoad* lydown = [[lyDownLoad alloc] init];
    
    [lydown downLoadResource:urlStr];
    lydown.requestFailed = ^(AFHTTPRequestOperation* op){
        if ([lyDownLoad networkingCanAceess]==0) {
           
            [_tableView removeFromSuperview];
            [self addNoInfoView];
             bgimage.image = [UIImage imageNamed:@"无网络"];
        }
        else
        {
            if (_dataArray.count==0) {
                [self addNoInfoView];
                bgimage.image = [UIImage imageNamed:@"评论"];
                [_tableView removeFromSuperview];
                
                
            }
            else
            {
                [bgimage removeFromSuperview];
                if (![self.subviews containsObject:_tableView]) {
                    [self addSubview:_tableView];
                }
                
            }
        }

    };
    lydown.requestSuccess = ^(AFHTTPRequestOperation* op){
       
        [self plRequestSuccess:op];
        
        
    };
    
    
}

-(void)plRequestSuccess:(AFHTTPRequestOperation*)op
{
    
    
    NSData* data= op.responseData;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for(int i = 0 ;i<[json count];i++)
    {
        NSDictionary* dict= json[i];
        plModel* model1 = [[plModel alloc] init];
        if(_isMy)
        {
            model1.title = [dict objectForKey:@"Title"];
            model1.contentId = (int)[[dict  valueForKey:@"NewsID"] integerValue];
            model1.subjectId = (int)[[dict  valueForKey:@"NewsSortIDs"] integerValue];
        }
        model1.Content = [dict objectForKey:@"Content"];
        model1.Flowers = (int)[[dict  valueForKey:@"Flowers"] integerValue];
        if (_isXP) {
              model1.NewsReplayID = (int)[[dict valueForKey:@"AudioReplayID"] integerValue];
        }
        else
        {
        model1.NewsReplayID = (int)[[dict valueForKey:@"NewsReplayID"] integerValue];
        }
        model1.PubTime = [dict objectForKey:@"PubTime"];
        model1.UserID = (int)[[dict valueForKey:@"UserID"] integerValue];
        model1.urlImage= [NSString stringWithFormat:@"%@/Support/Download.aspx?UserIcon=%@",DOCUMENTYM,[dict objectForKey:@"IconPath"]];
        model1.petName = [dict objectForKey:@"PetName"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        NSArray* old = [model1.PubTime componentsSeparatedByString:@" "];
        NSArray* new = [currentDateStr componentsSeparatedByString:@" " ];
        if ([old[0] isEqualToString:new[0]] )
        {
            NSArray* old1=    [old[1] componentsSeparatedByString:@":"];
            NSArray* new1=    [new[1] componentsSeparatedByString:@":"];
            if ([(NSString*)new1[0] isEqualToString:old1[0]]) {
                model1.PubTime = @"刚刚";
                
            }
            else
            {
                model1.PubTime = [NSString stringWithFormat:@"%ld小时前",[new1[0] integerValue]-[old1[0] integerValue]];
            }
        }
        else if ([[new[0] componentsSeparatedByString:@"-"][1] integerValue]-[[old[0] componentsSeparatedByString:@"-"][1] integerValue]==0&&[[new[0] componentsSeparatedByString:@"-"][0] integerValue]-[[old[0] componentsSeparatedByString:@"-"][0] integerValue]==0)
        {
            model1.PubTime  = [NSString stringWithFormat:@"%ld天前",[[new[0] componentsSeparatedByString:@"-"][2] integerValue]-[[old[0] componentsSeparatedByString:@"-"][2] integerValue]];
        }
        else
        {
            
            model1.PubTime  = old[0];
        }
        plModelFrame *modelFrame = [[plModelFrame alloc] init];
        modelFrame.textFont = SMALLFONT;
        modelFrame.model = model1;
        
        [_dataArray addObject:modelFrame];
        
        
    }
    
    
        [_tableView.footer endRefreshing];
    [_tableView.header endRefreshing];
    
    [_tableView reloadData];
    if ([lyDownLoad networkingCanAceess]==0) {
       
        [_tableView removeFromSuperview];
        [self addNoInfoView];
         bgimage.image = [UIImage imageNamed:@"无网络"];
    }
    else
    {
        if (_dataArray.count==0) {
            [self addNoInfoView];
            bgimage.image = [UIImage imageNamed:@"评论"];
            [_tableView removeFromSuperview];
            
            
        }
        else
        {
            [bgimage removeFromSuperview];
            if (![self.subviews containsObject:_tableView]) {
                [self addSubview:_tableView];
            }
            
        }
    }
}
- (void)zpRequestInfo:(int)pID
{
    NSString* urlstr ;
    if (!_isXP) {
        urlstr = [NSString stringWithFormat:@"%@/Support/JsonNews.aspx?flowerRep=%d",DOCUMENTYM,pID];

    }
    else
    {
    
     urlstr = [NSString stringWithFormat:@"%@/Support/JsonAudioAPI.aspx?AudioReplay=flowerReplay&AudioReplayID=%d",DOCUMENTYM,pID];
    }
    lyDownLoad* lydown = [[lyDownLoad alloc] init];
    
    [lydown downLoadResource:urlstr];
    lydown.requestSuccess=^(AFHTTPRequestOperation* op){
        
        NSString* zstr = _isXP?[[NSUserDefaults standardUserDefaults] objectForKey:@"XPZPSTR"]:[[NSUserDefaults standardUserDefaults] objectForKey:@"ZSTR"];
        if (zstr.length==0)
        {
            zstr=@"";
        }
        zstr=[zstr stringByAppendingString:[NSString stringWithFormat:@",%d",pID]];
        [[NSUserDefaults standardUserDefaults] setObject:zstr forKey:_isXP? @"XPZPSTR":@"ZSTR"];
        
        [_tableView reloadData];
    };
    lydown.requestFailed=^(AFHTTPRequestOperation* op){
        //[MBProgressHUD showError:@"亲，需要联网才能使用哦！"];
    };
    
}
-(void)pullUpRefreshDidFinish
{
    pageNum++;
    if (_isXP) {
         [_dataArray removeAllObjects];
    }
    NSString* urlstr;
    if (_isMy)
    {
        urlstr = [NSString stringWithFormat:@"%@/Support/JsonNews.aspx?UserHandler=GetNewsReplay&UserID=%@&pageIndex=%d&pageSize=10",DOCUMENTYM,@"12323",pageNum];
        [self initPLRequest:urlstr];
    }
    else if(_isXP)
    {
        urlstr = [NSString stringWithFormat:@"%@/Support/JsonAudioAPI.aspx?AudioReplay=getReplay&AudioID=%d",DOCUMENTYM,self.contentID];
        [self initPLRequest:urlstr];
        
    }
    else
    {
        urlstr=[NSString stringWithFormat:@"%@/Support/JsonNews.aspx?NewsReplayShow=yes&NewsID=%d&pageSize=6&pageIndex=%d",DOCUMENTYM,self.contentID,pageNum];
        [self initPLRequest:urlstr];
    }
    
}
-(void)pullDownRefreshDidFinish
{
    pageNum = 1;
    [_dataArray removeAllObjects];
    NSString* urlstr;
    if (_isMy)
    {
        urlstr = [NSString stringWithFormat:@"%@/Support/JsonNews.aspx?UserHandler=GetNewsReplay&UserID=%@&pageIndex=%d&pageSize=6",DOCUMENTYM,@"12323",pageNum];
        [self initPLRequest:urlstr];
    }
    else if(_isXP)
    {
        urlstr = [NSString stringWithFormat:@"%@/Support/JsonAudioAPI.aspx?AudioReplay=getReplay&AudioID=%d",DOCUMENTYM,self.contentID];
        [_dataArray removeAllObjects];
        [self initPLRequest:urlstr];

    }
    else
    {
        urlstr=[NSString stringWithFormat:@"%@/Support/JsonNews.aspx?NewsReplayShow=yes&NewsID=%d&pageSize=6&pageIndex=%d",DOCUMENTYM,self.contentID,pageNum];
        [self initPLRequest:urlstr];
    }
    
}
-(void)reloadDataInfo
{
   
    if (_dataArray==nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    [_dataArray removeAllObjects];
    NSString* urlstr;
    if (_isMy)
    {
        
        urlstr = [NSString stringWithFormat:@"%@/Support/JsonNews.aspx?UserHandler=GetNewsReplay&UserID=%@&pageIndex=%d&pageSize=6",DOCUMENTYM,@"12323",pageNum];
        [self initPLRequest:urlstr];
    }
    else if(_isXP)
    {
        urlstr = [NSString stringWithFormat:@"%@/Support/JsonAudioAPI.aspx?AudioReplay=getReplay&AudioID=%d",DOCUMENTYM,self.contentID];
        [self initPLRequest:urlstr];
        
    }
    else
    {
        urlstr=[NSString stringWithFormat:@"%@/Support/JsonNews.aspx?NewsReplayShow=yes&NewsID=%d&pageSize=6&pageIndex=%d",DOCUMENTYM,self.contentID,pageNum];
        [self initPLRequest:urlstr];
    }
    
   
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isXP) {
        int currentPostion = scrollView.contentOffset.y;
        
        if (currentPostion - _lastPosition > 20  && currentPostion > 0) {        //这个地方加上 currentPostion > 0 即可）
            
            _lastPosition = currentPostion;
            
           
            
         
            
        }
        
        else if ((_lastPosition - currentPostion > 20) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height-20) ) //这个地方加上后边那个即可，也不知道为什么，再减20才行
            
        {
            
            _lastPosition = currentPostion;
            
                      
            
            
            
        }
    }
    
    
    
    
}
-(void)chagePLlPF:(NSNotification*)no
{
    self.backgroundColor = DAYBACKCOLOR;
    _tableView.backgroundColor = DAYBOTTOMColor;
    [_tableView reloadData];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CHANGEPF" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CHANGEPL" object:nil];
}
-(void)reloadPL:(NSNotification*)no
{
    [self reloadDataInfo];
}
@end
