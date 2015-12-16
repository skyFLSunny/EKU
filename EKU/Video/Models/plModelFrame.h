//
//  plModelFrame.h
//  LYrecite
//
//  Created by tanyuehong on 15/8/18.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "plModel.h"

@interface plModelFrame : NSObject

@property (nonatomic,strong)plModel *model;

@property (nonatomic,assign)CGRect imageFrame;

@property (nonatomic, assign) CGRect UserIDFrame;
@property (nonatomic, assign) CGRect FlowersFrame;
@property (nonatomic, assign) CGRect  NewsReplayIDFrame;

@property (nonatomic, assign) CGRect FlowersCountFrame;


@property (nonatomic, assign) CGRect PubTimeFrame;

@property (nonatomic, assign) CGRect ContentFrame;

@property (nonatomic, assign) CGFloat  cellHeigt;

@property (nonatomic, assign) CGRect  wzBtn;

@property  (nonatomic,strong) UIFont  *textFont;

@property (nonatomic,assign) CGRect  zhanbtnFrame;

+ (NSMutableArray  *)plModelFramewitdData:(NSData *)data;
@end
