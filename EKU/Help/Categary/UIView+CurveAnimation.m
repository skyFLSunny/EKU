//
//  UIView+CurveAnimation.m
//  CurveAnimationDemo
//
//  Created by Qianshanzhicheng on 15/10/27.
//  Copyright © 2015年 Qianshanzhicheng. All rights reserved.
//

#import "UIView+CurveAnimation.h"

@implementation UIView (CurveAnimation)
- (void)animationByStartPoint:(CGPoint)startP endPoint:(CGPoint)endP scale:(float)scale time:(NSTimeInterval)timeinterval moveView:(UIView *)moveView{
    /*  // 使用y=ax*x+b*x这种抛物线,如过点(x1,y1)、(x2,y2)
     *   当x1==0 || x2==0时，为能求的曲线，取b=0,则 a = y1/(x1*x1),b=0
     *   当x1==x2 ,为能求的曲线，取b=0,则 a = y1/(x1*x1),b=0
     *   否则 a = (x2*y1 - x1*y2)/(x1*x2*(x1-x2)),b = (x1*x1*y2 - x2*x2*y1)/(x1*x2*(x1-x2)).
     *
     */
    UIBezierPath * movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:startP];
    [movePath addQuadCurveToPoint:endP controlPoint:CGPointMake((startP.x + endP.x)/2.0,startP.y)];
    
    [UIView animateWithDuration:timeinterval animations:^{
        // 关键帧
        CAKeyframeAnimation * moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnim.path = movePath.CGPath;
        moveAnim.duration = timeinterval;
        moveAnim.removedOnCompletion = YES;
        
        [moveView.layer addAnimation:moveAnim forKey:nil];
       
        moveView.alpha= 0;
    } completion:^(BOOL finished) {
        moveView.alpha = 0;
        moveView.hidden = YES;
        [moveView removeFromSuperview];
        //
    }];
    
    
    
}
@end
