//
//  TYHGetContentImage.m
//  LYrecite
//
//  Created by tanyuehong on 15/10/30.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import "TYHGetContentImage.h"
#import "NSString+lyMD5.h"


@interface TYHContentImageModel : NSObject

@property (nonatomic,strong)  UIImage   *image;


//这个表示图片的位置，100000表示图片没有下载成功需要重新下载

@property (nonatomic,assign)  NSInteger  imageIndex;


@end

@implementation TYHContentImageModel


@end

@interface TYHWeiDownLoadModel : NSObject

@property (nonatomic,assign) NSInteger  index;

@property (nonatomic,strong) NSString   *dowloadPath;
@end

@implementation TYHWeiDownLoadModel
+ (instancetype)getWeiDownLoadModel:(NSInteger )index withPath:(NSString *)path
{
    TYHWeiDownLoadModel *model = [[TYHWeiDownLoadModel alloc] init];
    model.index = index;
    model.dowloadPath = path;
    return  model;
}

@end


@interface TYHGetContentImage  ()

@property (nonatomic,strong) NSMutableArray  *ContentImageArr;

@property (nonatomic,strong) NSMutableArray   *pathArr;


@property (nonatomic,strong) NSString  *baseUrl;

@end

@implementation TYHGetContentImage

+ (instancetype)getTYHContentImage:(NSMutableArray *)imagePath with:(NSString *)baseUrl
{
    return  [[self alloc] initWithImagePath:imagePath with:baseUrl];
}

- (id)initWithImagePath:(NSMutableArray *)imagePath  with:(NSString *)baseUrl
{
    self = [super init];
    
    if (self)
    {
        self.pathArr = imagePath;
        self.baseUrl = baseUrl;
    
    }
    
    return  self;
    
}

- (void)getUImageWithPathArr:(NSMutableArray *)patharr
{
    
    NSMutableArray   *tempImageArr = [NSMutableArray array];
    
    NSMutableArray   *weiDowndImage = [NSMutableArray array];
    NSMutableArray   *weiDownImageIndex = [NSMutableArray array];

    for (NSInteger i = 0; i<patharr.count; i++)
    {
        NSString  *path = patharr[i];
        if ([self.baseUrl isEqualToString:@"newsDown"])
        {
             NSArray  *patharr = [path componentsSeparatedByString:@"/"];
             path = [patharr lastObject];
             path= [NSString stringWithFormat:@"%@/Support/Download.aspx?NewsPicture=%@",DOCUMENTYM,path];
            
        }
        NSString* imagepath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@/%@",self.baseUrl,[path MD5]];
        UIImage  *image = [[UIImage alloc] initWithContentsOfFile:imagepath];
        if (image!=nil)
        {
            TYHContentImageModel  *imageModel = [[TYHContentImageModel alloc] init];
            imageModel.image = image;
            imageModel.imageIndex = i;
            [tempImageArr addObject:imageModel];
            
        }else
        {
            [weiDowndImage  addObject:path];
            [weiDownImageIndex addObject:[TYHWeiDownLoadModel getWeiDownLoadModel:i withPath:path]];
        }
       
    }
    
    __block NSInteger  imageCount = weiDowndImage.count;
    if (imageCount== 0)
    {
          self.ContentImageArr = tempImageArr;
          return ;
    }
    
    lyDownLoad* lydown = [[lyDownLoad alloc] init];
    
    
    __block NSInteger  imageIndex = 0;
    
    [lydown downLoadResourceQue:weiDowndImage withKeyArr:weiDownImageIndex];
    lydown.requestSuccesswithKey = ^(AFHTTPRequestOperation *operation,id key)
    {
        UIImage *image = [self getRequestImage:operation.responseData];
        
        TYHContentImageModel  *imageModel = [[TYHContentImageModel alloc] init];
        imageModel.image = image;
        TYHWeiDownLoadModel *mymodel = key;
        imageModel.imageIndex = mymodel.index;
        [tempImageArr addObject:imageModel];
        [self  writeImageCathWith:operation.responseData withpath:mymodel.dowloadPath];
        imageIndex++;
        if (imageIndex==imageCount)
        {
            self.ContentImageArr = tempImageArr;
        }
        
    };
    lydown.requestFailedWithKey = ^(AFHTTPRequestOperation *operation,id key)
    {
        
        UIImage  *imageFiale = [UIImage imageNamed:@"加载图片"];
        TYHContentImageModel  *imageModel = [[TYHContentImageModel alloc] init];
         imageModel.image = imageFiale;
        TYHWeiDownLoadModel  *mymodel = key;
         NSInteger  index = mymodel.index;
        imageModel.imageIndex = index;
        [tempImageArr addObject:imageModel];
        imageIndex++;
        if (imageIndex==imageCount)
        {
             self.ContentImageArr = tempImageArr;
        }
    };

}

- (void)writeImageCathWith:(NSData *)imageDat  withpath:(NSString *)path
{
    //如果没有文件缓存目录 创建文件缓存目录
    
    dispatch_queue_t myque = dispatch_queue_create("wodeState", nil);
    dispatch_async(myque,  ^{
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",self.baseUrl]])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",self.baseUrl] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString* imagepath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@/%@",self.baseUrl,[path MD5]];
        [imageDat writeToFile:imagepath atomically:NO];
    });
    
}
- (void)setContentImageArr:(NSMutableArray *)ContentImageArr
{
    _ContentImageArr = ContentImageArr;
   
    if ([_delegate respondsToSelector:@selector(contentImageDidGet)])
    {
         [_delegate contentImageDidGet];
    }
    
    
}

- (void)setDelegate:(id<TYHGetContentImageDelegate>)delegate
{
    _delegate = delegate;
    
     [self getUImageWithPathArr:self.pathArr];
    
}


-(UIImage*)getRequestImage:(NSData*)data
{
    UIImage* image;
    image = [UIImage imageWithData:data];
    
    return image;
}

- (UIImage  *)getImageWithImageIndex:(NSInteger )imageIndex
{
    for (NSInteger  i =0; i<self.ContentImageArr.count; i++)
    {
        TYHContentImageModel *imageModel = self.ContentImageArr[i];
        
        if (imageModel.imageIndex == imageIndex)
        {
            return  imageModel.image;
        }
    }
    NSLog(@"文章图片 超出索引");
    return  nil;
}
@end
