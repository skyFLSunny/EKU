//
//  UIImage.h
//  LYrecite
//
//  Created by tanyuehong on 15/8/5.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LY)
+ (UIImage *)clipImageSize:(UIImage *)img rect:(CGRect )rect;
/*
   函数功能： 缩放图片
   参数描述：img需要缩放的图片
           size 缩放的尺寸
           isHeightorWidth 保持高不变还是宽不变
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size isHeightorWidth:(int )isheightorwidth;
/*
 函数功能： 裁剪图片
 参数描述：img需要裁剪的图片
          size 裁剪的尺寸
          isHeightorWidth 是裁剪高还是宽度
 */
+ (UIImage *)clipImageSize:(UIImage *)img size:(CGSize)size isHeightorWidth:(int )isheightorwidth;
@end
