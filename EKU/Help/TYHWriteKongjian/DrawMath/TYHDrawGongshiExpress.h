//
//  TYHDrawGongshiExpress.h
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/22.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TYHDrawGongshiExpress : NSObject

@property (nonatomic,assign,readonly)CGRect gonshiExpressRect;

//这是绘制分线的函数
- (void)drawFenxian:(CGContextRef)ctx withRect:(CGRect)rect;

//这是绘制求和公式的函数
- (void)drawsumExepress:(CGContextRef)ctx withRect:(CGRect)rect;
//这是绘制根式的函数
- (void)drawGenshi:(CGContextRef )ctx  withRect:(CGRect)rect;
//这个是绘制方程式的表示
- (void)drawFancheng:(CGContextRef )ctx  withRect:(CGRect)rect;

//这是绘制箭头的函数
- (void)drawJiantou:(CGContextRef )ctx withRect:(CGRect)rect withString:(NSString *)content;
//这是绘制删除线的函数
- (void)drawShanchuXian:(CGContextRef )ctx withRect:(CGRect)rect;
//这是绘制斜线的函数
- (void)drawXieXian:(CGContextRef )ctx withRect:(CGRect)rect;
//这是绘制下划线的函数
-(void)drawXiaHuaxian:(CGContextRef )ctx withRect:(CGRect)rect;

- (void)drawBaoHanYu1:(CGContextRef )ctx withRect:(CGRect)rect;

- (void)drawBeiBaoHanYu1:(CGContextRef )ctx withRect:(CGRect)rect;

- (void)drawbuBaoHanYu1:(CGContextRef )ctx withRect:(CGRect)rect;

- (void)drawbuBeiBaoHanYu1:(CGContextRef )ctx withRect:(CGRect)rect;

//绘制表格的函数
- (void)drawBiaoge:(CGContextRef )ctx withRect:(CGRect)rect withHeigtArr:(NSMutableArray *)heigtArr withWindthArr:(NSMutableArray *)widthArr;
@end
