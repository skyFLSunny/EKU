//
//  plModel.h
//  LYrecite
//
//  Created by liyao on 15/7/1.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface plModel : NSObject
@property (nonatomic, assign) int UserID;
@property (nonatomic, assign) int Flowers;
@property (nonatomic, assign) int  NewsReplayID;
@property (nonatomic, assign) int  subjectId;
@property (nonatomic, assign) int  contentId;
@property (nonatomic, strong) NSString*  title;
@property (nonatomic, strong) NSString* PubTime;
@property (nonatomic, strong) NSString* Content;
@property (nonatomic, strong) NSString* petName;
@property (nonatomic, strong) NSString* urlImage;
@end
