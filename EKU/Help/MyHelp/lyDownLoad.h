//
//  lyDownLoad.h
//  recite - ly
//
//  Created by liyao on 15/3/4.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Reachability.h"
@interface lyDownLoad : NSObject
typedef void(^successBlock)(AFHTTPRequestOperation *operation);
typedef void(^successBlockWithID)(AFHTTPRequestOperation *operation,id key);
typedef void(^failureBlock)(AFHTTPRequestOperation *operation);
typedef void(^failureBlockWithID)(AFHTTPRequestOperation *operation,id key);
typedef void(^downLoadProgress)(float progress);
@property (nonatomic, strong) NSString* urlStr;
@property (nonatomic, strong) successBlock requestSuccess;    // 请求成功
@property (nonatomic, strong) successBlockWithID requestSuccesswithKey;    // 请求成功,加上队列
@property (nonatomic, strong) failureBlock requestFailed;     // 请求失败
@property (nonatomic, strong) failureBlockWithID requestFailedWithKey;     // 请求失败，加上队列
@property (nonatomic, strong) downLoadProgress setProgress;   // 进度显示
@property (nonatomic, assign) int tag;
+ (NetworkStatus)networkingCanAceess;
// 下载资源并显示进度
- (void)downLoadResource:(NSString*)aUrlStr;
- (void)downLoadResourcePost:(NSString*)aUrlStr dict:(NSDictionary*)dic;
// 终止所有下载
- (void)cancelALLDownLoad;
//新建具有下载队列的下载
- (void)downLoadResourceQue:(NSMutableArray *)downloadArr withKeyArr:(NSMutableArray *)keyArr;
@property (nonatomic,strong) NSOperationQueue *operationQueue;

-(void)supband;
-(void)addDownRequest:(NSString*)aUrl;
-(void)resume;


@end
