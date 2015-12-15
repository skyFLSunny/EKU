//
//  TYHDrawMathFactor.h
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/22.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TYHDrawMathManger : NSObject

//绘制正常文字大小
@property (nonatomic,strong) UIFont *textFont;


@property (nonatomic,assign)int fontSize;


//绘制小一号文字的大小
@property (nonatomic,strong) UIFont *smallTextFont;

//公式类型
@property (nonatomic,assign)NSInteger  mathFlag;

//公式的背景颜色
@property (nonatomic,strong) UIColor *backGroundClolor;

//公式的文字颜色
@property (nonatomic,strong) UIColor  *textColor;

//返回一个公式管理的实列的一个对象
+ (TYHDrawMathManger *)shareTYHDrawMathManger;

//绘制所有的公式对象，自动支持多线程的绘制
- (NSMutableArray *)drawAllMathExpresswithArr:(NSMutableArray *)arr;

//绘制所整个公式对象
- (UIImage *)drawMathExpresswithArr:(NSMutableArray *)arr;

//绘制的基础 高度
@property (nonatomic,assign)CGFloat baseHeigt;

@property (nonatomic,assign)CGFloat baseWidth;

@end
