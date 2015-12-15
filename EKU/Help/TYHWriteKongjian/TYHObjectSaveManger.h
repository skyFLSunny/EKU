//
//  TYHObjectSaveManger.h
//  LYrecite
//
//  Created by tanyuehong on 15/11/16.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYHObjectSaveManger : NSObject

+ (instancetype)GetObjectSaveManger;

- (void)saveNeedObject;


//保存
-(void)saveAudioDownloadList;

- (void)saveEssasyContTent;
@end
