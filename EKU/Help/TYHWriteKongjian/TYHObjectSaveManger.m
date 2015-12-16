//
//  TYHObjectSaveManger.m
//  LYrecite
//
//  Created by tanyuehong on 15/11/16.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import "TYHObjectSaveManger.h"
#import "DownLoadManger.h"



@implementation TYHObjectSaveManger

static  TYHObjectSaveManger  *sharInstence = nil;

+ (instancetype)GetObjectSaveManger
{
     static dispatch_once_t preDicate;
      dispatch_once(&preDicate, ^{
            sharInstence = [[self alloc] init];
             });
       return  sharInstence;
}

//这个方法是  保存 需要  保存 的 方法
- (void)saveNeedObject
{
    //保存文章下载 内容
    [self  saveEssasyContTent];
    
    
    //这里最好是停止下载
    [self  saveAudioDownloadList];
    
    
}


//这个方法是保存 文章 列表的持久 化

- (void)saveEssasyContTent
{
    NSString  *path = [self filePath:ContentFilePath];
    DownLoadManger  *downManger = [DownLoadManger sharedDownLoadManger];
    [downManger stopDownload];
    NSMutableArray  *essayContentArr = downManger.downloArr;
    if (essayContentArr.count>0)
    {
         [NSKeyedArchiver archiveRootObject:essayContentArr toFile:path];
    }
  

}

-(void)saveAudioDownloadList
{
   
//    NSString  *path = [self filePath:AudioFilePath];
//    NSMutableArray  *audioListArr = DEL.downArray;
//    if (audioListArr.count >0)
//    {
//        [NSKeyedArchiver archiveRootObject:audioListArr toFile:path];
//        
//    }

}

                       


//这个 是 获取 文章内容下载的保存 路径 
- (NSString *)filePath:(NSString *)path
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:path];
}
@end
