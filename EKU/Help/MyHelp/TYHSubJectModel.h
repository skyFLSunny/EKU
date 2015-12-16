//
//  TYHSubJectModel.h
//  LYrecite
//
//  Created by tanyuehong on 15/11/11.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TYHSubJectModel : NSObject <NSCoding>

//这个事保存文章的下载信息
@property  (nonatomic,strong) NSMutableArray  *downLoadArr;

@property  (nonatomic,strong) NSMutableArray *downLoadImageArr;


@property  (nonatomic,strong) NSString  *title;

@property  (nonatomic,assign) int  subjectId;

@property  (nonatomic,assign) NSInteger   ContentCount;

@property  (nonatomic,assign) NSInteger   ImageCount;

@property  (nonatomic,assign) NSInteger   Finshed;

@property  (nonatomic,assign) NSInteger   downLoadPerSent;



/**
 *  标志位   0表示暂停    1 下载已经完成   2表示等待下载   3表示正在下载
 */
@property  (nonatomic,assign) NSInteger  stata;


@end
