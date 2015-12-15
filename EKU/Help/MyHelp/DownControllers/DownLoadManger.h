//
//  DownLoadManger.h
//  LYrecite
//
//  Created by tanyuehong on 15/11/13.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYHSubJectModel.h"
#import "TYHDowLoadMole.h"


@interface DownLoadManger : NSObject

@property(nonatomic,strong)NSMutableArray  *downloArr;
+ (instancetype)sharedDownLoadManger;
- (void)starDoloadWihtModel:(TYHSubJectModel *)model;

- (void)stopDownload;

@end
