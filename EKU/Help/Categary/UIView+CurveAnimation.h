//
//  UIView+CurveAnimation.h
//  CurveAnimationDemo
//
//  Created by Qianshanzhicheng on 15/10/27.
//  Copyright © 2015年 Qianshanzhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CurveAnimation)
- (void)animationByStartPoint:(CGPoint)startP endPoint:(CGPoint)endP scale:(float)scale time:(NSTimeInterval)timeinterval moveView:(UIView *)moveView;
@end
