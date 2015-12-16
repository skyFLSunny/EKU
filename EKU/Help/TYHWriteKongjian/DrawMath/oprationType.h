//
//  oprationType.h
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/16.
//  Copyright (c) 2015年 tanyuehong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface oprationType : NSObject

+ (oprationType *)sharedOprationType;

- (NSMutableArray  *)getoprationType;

- (NSMutableArray  *)getzhuanyizifu;

- (NSMutableArray  *)getxieTieArr;

- (NSMutableArray *)getZhuanYIResult;

- (NSMutableArray *)getfanXietiArr;

@end
