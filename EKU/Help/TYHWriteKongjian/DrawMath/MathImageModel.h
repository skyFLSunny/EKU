//
//  MathImageModel.h
//  CoreTextDemo
//
//  Created by tanyuehong on 15/11/3.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//


//这是用来保存 合并图片时候的坐标信息 的
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MathImageModel : NSObject

+ (instancetype)MathImageModelWith:(UIImage *)MathImage  WithDarwY:(CGFloat)drawY;
- (UIImage *)getMathImage;

- (CGFloat) getDrawY;
@end
