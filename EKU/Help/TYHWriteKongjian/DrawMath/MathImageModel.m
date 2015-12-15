//
//  MathImageModel.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/11/3.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import "MathImageModel.h"

@interface  MathImageModel ()

@property (nonatomic,strong)  UIImage *mathImage;

@property (nonatomic,assign)  CGFloat  drawY;

@end

@implementation MathImageModel

+ (instancetype)MathImageModelWith:(UIImage *)MathImage  WithDarwY:(CGFloat)drawY
{
    MathImageModel *model = [[MathImageModel alloc] init];
    model.mathImage       =  MathImage;
    model.drawY           =  drawY;
    
    return  model;
    
}
- (UIImage *)getMathImage
{
    return  self.mathImage;
}
- (CGFloat) getDrawY
{
    return  self.drawY;
}
@end
