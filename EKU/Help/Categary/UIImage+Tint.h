//
//  UIImage+Tint.h
//  recite - ly
//
//  Created by wzrong on 15-4-30.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

@end
