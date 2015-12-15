//
//  GSImageModel.h
//  CoreTextDemo
//
//  Created by tanyuehong on 15/10/21.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GSImageModel : NSObject
+ (instancetype)gsImageModelWithImage:(UIImage *)GSimage withY:(CGFloat)drawY;
+ (instancetype)gsImageModelWithImage:(UIImage *)GSimage;
@end
