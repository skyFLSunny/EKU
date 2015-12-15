//
//  DownLoadManger.m
//  LYrecite
//
//  Created by tanyuehong on 15/11/13.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import "DownLoadManger.h"
#import "NSString+lyMD5.h"

@interface  DownLoadManger ()

@property (nonatomic,strong)TYHSubJectModel *model;

@property (nonatomic,strong)TYHSubJectModel *qianyiModel;

@property (nonatomic,weak)lyDownLoad   *dowload;

@property (nonatomic,assign)CGFloat downPrecnt;


@end

@implementation DownLoadManger
{
    NSInteger  MissCont;
}
+ (instancetype)sharedDownLoadManger
{
    static  DownLoadManger  *sharInstence = nil;
    static dispatch_once_t preDicate;
    dispatch_once(&preDicate, ^{
        sharInstence = [[self alloc] init];
    });
    return  sharInstence;

}

- (void)starDoloadWihtModel:(TYHSubJectModel *)model
{
    
    if (model.stata == 1 || model.stata == 3 ||[self isDownloading:self.downloArr])
    {
        return  ;
    }
    self.model = model;
    model.stata = 3;
    [self downLoadContentArr];
    
}


-  (BOOL)isDownloading:(NSMutableArray *)dowloadArr
{
    for (NSInteger  i =0; i<dowloadArr.count; i++)
    {
        TYHSubJectModel *model = dowloadArr[i];
        if (model.stata == 3)
        {
            return  true;
        }
    }
    return false;
}

- (void)downLoadContentArr
{
    
    
    NSMutableArray  *downNews = self.model.downLoadArr;
    if (downNews == nil) {
        return ;
    }
    if (downNews.count == 0)
    {
        [self starDownlodImage];
        return;
    }
    NSMutableArray  *downloadInfo = [NSMutableArray array];
    NSMutableArray  *downLoadArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i<downNews.count; i++)
    {
        TYHDowLoadMole  *model = downNews[i];
        [downLoadArr addObject:model.downLoadString];
        [downloadInfo addObject:model];
        
    }
    lyDownLoad *lydown = [[lyDownLoad alloc] init];
    self.dowload = lydown;
    
    [lydown downLoadResourceQue:downLoadArr withKeyArr:downloadInfo];
    __block  NSInteger  donloadSucellCount  = 0;
    __block  NSInteger  downLoadCount = downLoadArr.count;
    MissCont = downLoadCount;
    lydown.requestSuccesswithKey = ^(AFHTTPRequestOperation *operation,id key)
    {
        TYHDowLoadMole  *model = key;
        [self requestSuccess:operation.responseData  withSortId:model.sortID];
        [self getImageDownloadPath:operation.responseData ID:model.sortID];
        [self.model.downLoadArr removeObject:model];
        donloadSucellCount ++;
        self.downPrecnt = donloadSucellCount;
        if (downLoadCount == donloadSucellCount)
        {
            self.model.ImageCount = self.model.downLoadImageArr.count;
            [self starDownlodImage];
        }
        
    };
    lydown.requestFailedWithKey = ^(AFHTTPRequestOperation *operation,id key)
    {
        if (![lyDownLoad networkingCanAceess])
        {
            self.downPrecnt = -5;
        }
    };

    

}

-(void)requestSuccess:(NSData  *)data withSortId:(NSInteger )sortId
{
    

    dispatch_queue_t myque = dispatch_queue_create("getShouchangState", nil);
    dispatch_async(myque,  ^{
//        lyDataBase* db = [lyDataBase share];
//        [db insertInfoToNewsTable:(int)sortId JsonString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] isFaver:false NewssortId:self.model.subjectId];
    });
    
}


-(void)getImageDownloadPath:(NSData *)data ID:(NSInteger )NewSID
{
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([json isKindOfClass:[NSDictionary class]])
    {
        
        NSString  *content = [json objectForKey:@"Remark"];
        NSString  *iconPath = [json objectForKey:@"IconPath"];
        NSString* NewIdIcon = [NSString stringWithFormat:@"%@/Support/Download.aspx?NewsIcon=%@",DOCUMENTYM,iconPath];
        TYHDowLoadMole  *model = [[TYHDowLoadMole alloc] init];
        model.downLoadString = NewIdIcon;
        model.sortID =   -1;
        model.flage  = 1;
        [self.model.downLoadImageArr addObject:model];
        
        NSMutableArray* metchers1= [self setTextStyle:content];
        int  count = (int)metchers1.count;
        for (int i = 0; i< count; i++)
        {
            NSString*  picID= metchers1[i];
            picID=  [picID stringByReplacingOccurrencesOfString:@"{img," withString:@""];
            picID=[picID stringByReplacingOccurrencesOfString:@"}" withString:@""];
            NSString* contImage = [NSString stringWithFormat:@"%@/Support/Download.aspx?NewsPicture=%@",DOCUMENTYM,picID];
            TYHDowLoadMole  *model1 = [[TYHDowLoadMole alloc] init];
            model1.downLoadString = contImage;
            model1.sortID =   -1;
            model1.flage  = i+2;
            [self.model.downLoadImageArr addObject:model1];
            
        }
        
    }
    
}

- (void)starDownlodImage
{
    
    NSMutableArray  *downLoadArr = self.model.downLoadImageArr;
    NSMutableArray  *MydownLoadArr = [NSMutableArray array];
    NSMutableArray  *downLoadInfo = [NSMutableArray array];
    NSInteger  conunt = downLoadArr.count;

    for (NSInteger  i = 0; i<conunt; i++)
    {
        TYHDowLoadMole  *model = downLoadArr[i];
        NSString  *downLoadString = model.downLoadString;
        [MydownLoadArr addObject:downLoadString];
        [downLoadInfo addObject:model];
    }
    
    
    lyDownLoad *lydown = [[lyDownLoad alloc] init];
    self.dowload = lydown;
    [lydown downLoadResourceQue:MydownLoadArr withKeyArr:downLoadInfo];
    
    __block  NSInteger  donloadSucellCount  = 0;
    __block  NSInteger  downLoadCont = MydownLoadArr.count;
    lydown.requestSuccesswithKey = ^(AFHTTPRequestOperation *operation,id key)
    {
        TYHDowLoadMole  *mymodel = key;
        [self imageSuccess:operation.responseData tag:mymodel.downLoadString];
        [self.model.downLoadImageArr  removeObject:mymodel];
        donloadSucellCount++;
        self.downPrecnt = donloadSucellCount;
        if (downLoadCont == donloadSucellCount)
        {
            
            self.model.stata = 1;
            
            //这里调用下一个任务，或者保存下载信息
            [self FindNeedDownLoad];
        
        }
    };
    lydown.requestFailedWithKey = ^(AFHTTPRequestOperation *operation,id key)
    {
        if (![lyDownLoad networkingCanAceess])
        {
            self.downPrecnt = -5;
        }
    };
    
    
}



- (void)FindNeedDownLoad
{
    for (NSInteger i =0; i<self.downloArr.count; i++)
    {
        TYHSubJectModel  *model = self.downloArr[i];
        if (model.stata== 2)
        {
            [self starDoloadWihtModel:model];
             break ;
        }
    }
}
- (void)setModel:(TYHSubJectModel *)model
{
    
    if (_model != nil)
    {
        [_model removeObserver:self forKeyPath:@"stata"];
        [_model removeObserver:self forKeyPath:@"downLoadPerSent"];
    }
    _model = model ;
    [_model addObserver:self forKeyPath:@"stata" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [_model addObserver:self forKeyPath:@"downLoadPerSent" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"stata"])
    {
        if (self.model.stata ==0)
        {
            [self.dowload cancelALLDownLoad];
            [self FindNeedDownLoad];
        }

    }
}

- (void)stopDownload
{
    if (self.model.stata==3)
    {
        self.model.stata = 0;
    }
  
    [self.dowload cancelALLDownLoad];
}


- (void)setDownPrecnt:(CGFloat )downPrecnt
{
    if (downPrecnt == -5)
    {
        self.model.downLoadPerSent = -5;
        return ;
        
    }
    
    NSInteger  DownPersent;
    self.model.Finshed += 1;
    NSInteger  finshed = self.model.Finshed;
    NSInteger  essayCont = self.model.ContentCount;
    if (self.model.downLoadArr.count==0)
    {
        NSInteger  imagecont = self.model.ImageCount;
        if (imagecont == 0)
        {
            DownPersent = 40;
        }else
        {
           DownPersent = 40 +((finshed-essayCont)/(CGFloat)imagecont)*60;
        }
        
    }else
    {
        DownPersent = ((CGFloat)finshed/essayCont)*40;
   
    }
  
    self.model.downLoadPerSent = DownPersent;
}

- (void)dealloc
{

    [_model removeObserver:self forKeyPath:@"stata"];
    
}


#pragma mark 请求数据处理显示
- (NSMutableArray*)setTextStyle:(NSString*)str
{
    NSMutableArray *metchers=[[NSMutableArray alloc]init];
    if (str.length>0)
    {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[{]img,\\d{1,4}/\\d{1,2}/\\d{1,6}-\\d{1,6}-\\d{1,6}.png[}]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"[{]img,\\d{1,4}/\\d{1,2}/\\d{1,6}-\\d{1,6}-\\d{1,6}.jpg[}]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[regex matchesInString:str options:0 range:NSMakeRange(0, [str length])]];
        [array addObjectsFromArray:[regex1 matchesInString:str options:0 range:NSMakeRange(0, [str length])]];
        
        for (NSTextCheckingResult* b in array)
        {
            [metchers addObject:[str substringWithRange:b.range]];
        }
        
    }
    //
    
    return metchers;
}

-(void)imageSuccess:(NSData  *)data tag:(NSString*)aTag
{
    dispatch_queue_t qu=dispatch_queue_create("downLoagImages", nil);
    dispatch_async(qu, ^{
        
        NSString* path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/pic/%@",[aTag MD5]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/pic"]]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/pic"] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        [data writeToFile:path atomically:YES];
    });
}
@end
