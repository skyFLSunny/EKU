//
//  TYHDrawText.h
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/22.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TYHDrawText : NSObject

@property (nonatomic,strong,readonly)NSString  *contextString;

@property (nonatomic,assign,readonly)CGSize contextSize;

- (CGSize)drawTextWith:(CGRect)rect withContentString:(NSString *)string withFont:(UIFont *)font withTextColor:(UIColor *)textColor;
- (CGSize)drawTextWith:(CGRect)rect withContentString:(NSString *)string withFont:(UIFont *)font;
- (CGSize)drawTextWith:(CGRect)rect withContentString:(NSString *)string;
- (CGSize)drawXietiTextWith:(CGRect)rect withContentString:(NSString *)string withFont:(UIFont *)font withTextColor:(UIColor *)textColor;

- (void)setContextString:(NSString *)contextString;

//绘制正常文字的方法
- (UIImage *)drawTextWithString:(NSString *)content;
@end
