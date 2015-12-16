//
//  TYHGetSizeGonshi.h
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/23.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CanJIxianClass.h"

@interface TYHGetSizeGonshi : NSObject

@property(nonatomic,strong,readonly)NSMutableArray *contentArr;

//获取整个公式的大小
- (CGSize)getGongshiSize:(NSMutableArray *)contentArr  withFlag:(int)flag with:(CanJiXianClass *)JixianModel;

//获取公式参数的大小
- (CGSize)getCanshuSize:(NSMutableArray *)contentArr withFlag:(int)flag;

//获取表格一行参数的大小
- (CGSize)getbiaoGeCanshuSize:(NSMutableArray *)contentArr  withFlag:(int)flag;


//获取文字的大小

- (CGSize)getStringSize:(NSString *)conentString  withFlage:(int)flag;

@end
