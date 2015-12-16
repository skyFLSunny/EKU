//
//  GSImageModel.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/10/21.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import "GSImageModel.h"

@interface GSImageModel ()

@property (nonatomic,assign) CGFloat drawY;

@property (nonatomic,strong) UIImage  *GSImage;

@end
@implementation GSImageModel

+ (instancetype)gsImageModelWithImage:(UIImage *)GSimage withY:(CGFloat)drawY
{
    GSImageModel *myModel = [[GSImageModel alloc] init];
    myModel.drawY = drawY ;
    myModel.GSImage = GSimage;
    return myModel;
}

+ (instancetype)gsImageModelWithImage:(UIImage *)GSimage
{
    GSImageModel *myModel = [[GSImageModel alloc] init];
    myModel.drawY = 0 ;
    myModel.GSImage = GSimage;
    return myModel;
}

@end
