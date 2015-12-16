//
//  lyDownLoad.m
//  recite - ly
//
//  Created by liyao on 15/3/4.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import "lyDownLoad.h"
#import "Reachability.h"
#import "NSString+lyMD5.h"
#import "Helper.h"

#define HOSTNAME @"www.baidu.com"

@interface lyDownLoad ()<UIAlertViewDelegate>

@end
@implementation lyDownLoad{
    BOOL isALLOW;
    BOOL isTouch;
}
+ (NetworkStatus)networkingCanAceess
{
    
    //Reachability *reacheNet = [Reachability reachabilityForInternetConnection];
    Reachability *reacheNet = [Reachability reachabilityWithHostName:HOSTNAME];
    return  [reacheNet currentReachabilityStatus];
}

- (void)downLoadResource:(NSString*)aUrlStr
{
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //下载请求
    AFHTTPRequestOperation *operation =[manager GET:aUrlStr parameters:nil success:^(AFHTTPRequestOperation *operations, id responseObject) {
        
        
        if (self.requestSuccess) {
            
            self.requestSuccess(operations);
        }
        
    } failure:^(AFHTTPRequestOperation *operations, NSError *error) {
        self.requestFailed(operations);
    }];
    
    //下载进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        float progress = ((float)totalBytesRead) / (totalBytesExpectedToRead);
        if (self.setProgress) {
            self.setProgress(progress);
        }
    }];
    
    
}
- (void)downLoadResourcePost:(NSString*)aUrlStr dict:(NSDictionary*)dic
{
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    
    //下载请求
    AFHTTPRequestOperation *operation =[manager POST:aUrlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        if (self.requestSuccess) {
            
            self.requestSuccess(operation);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.requestFailed(operation);
        
    }];
    
    //下载进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        float progress = ((float)totalBytesRead) / (totalBytesExpectedToRead);
        if (self.setProgress) {
            self.setProgress(progress);
        }
    }];
    
    
}
//新增加队列下载任务

- (void)downLoadResourceQue:(NSMutableArray *)downloadArr withKeyArr:(NSMutableArray *)keyArr;
{
    NSMutableArray *queArr = [NSMutableArray array];
    
    for (int  i = 0; i<downloadArr.count; i++)
    {
        NSURL   *url = [NSURL URLWithString:downloadArr[i]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             self.requestSuccesswithKey(operation,keyArr[i]);
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             
             self.requestFailedWithKey(operation,keyArr[i]);
             
         }];
        
        //下载进度回调
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            //下载进度
            float progress = ((float)totalBytesRead) / (totalBytesExpectedToRead);
            
            if (self.setProgress) {
                self.setProgress(progress);
            }
        }];
        [queArr addObject:operation];
    }
    
    
    
    [self.operationQueue addOperations:queArr waitUntilFinished:NO];
    
    
}

- (void)cancelALLDownLoad
{
    
    [_operationQueue cancelAllOperations];
}

- (NSOperationQueue *)operationQueue
{
    
    if (_operationQueue == nil) {
        _operationQueue  = [[NSOperationQueue alloc] init];
        [_operationQueue setMaxConcurrentOperationCount:3];
    }
    return _operationQueue;
}
-(void)addDownRequest:(NSString*)aUrl
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:aUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:100];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/audiosdown"]]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/audiosdown"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    
    AFHTTPRequestOperation*  operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
   
    NSString* filePath =  [NSHomeDirectory() stringByAppendingFormat:@"/Documents/audiosdown/%@",[NSString stringWithFormat:@"%@.mp3",[aUrl MD5]]];
 
    if([[NSFileManager defaultManager] contentsAtPath:filePath].length==0)
    {
        //    //添加下载请求（获取服务器的输出流）
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    }
    __weak lyDownLoad* dw = self;
    __block AFHTTPRequestOperation*op = operation;
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        float progress = ((float)totalBytesRead) / (totalBytesExpectedToRead);
        int index = (int)[dw.operationQueue.operations indexOfObject:op];
//        if (index>=0) {
//            if (index< DEL.downArray.count) {
//                FModel* model = DEL.downArray[index];
//                model.currentBytes = totalBytesRead;
//                model.progress = progress;
//                model.totalBytes  = totalBytesExpectedToRead;
//            }
        
       // }
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        if (DEL.downArray.count>0) {
//            lyDataBase* db = [lyDataBase share];
//            FModel* mo = DEL.downArray[0];
//                NSString* filePath =  [NSHomeDirectory() stringByAppendingFormat:@"/Documents/audiosdown/%@",[NSString stringWithFormat:@"%@.mp3",[aUrl MD5]]];
//            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]&&[[[NSFileManager defaultManager] contentsAtPath:filePath] length]>0) {
//                for(int o=0;o<DEL.tracks.count;o++)
//                {
//                    Track* tr = DEL.tracks[o];
//                    if ([mo.filepath isEqualToString:tr.filePath]) {
//                         [tr setAudioFileURL:[NSURL fileURLWithPath:filePath]];
//                        break;
//                    }
//                    
//                }
//               
//            }
//            [ db updateAudioFile:(int)mo.fileID isDown:1];
//            [DEL.downArray removeObjectAtIndex:0];
//            NSString* filePathc =  [NSHomeDirectory() stringByAppendingFormat:@"/Documents/audiosdownCathe/%@",[NSString stringWithFormat:@"%@.mp3",[aUrl MD5]]];
//            if([[NSFileManager defaultManager] fileExistsAtPath:filePathc])
//            {
//                [[NSFileManager defaultManager] removeItemAtPath:filePathc error:nil];
//            }
//           
//        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
       
      
    }];
    if (_operationQueue.operations.count>0) {
        [operation addDependency:_operationQueue.operations[ _operationQueue.operationCount-1]];
    }
    
    [self.operationQueue  addOperation:operation];
    
    
}
-(void)supband
{
}
-(void)resume
{
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   }

@end

