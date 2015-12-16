//
//  UIImage.m
//  LYrecite
//
//  Created by tanyuehong on 15/8/5.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import "UIImage+LY.h"

@implementation UIImage (LY)
+ (UIImage *)clipImageSize:(UIImage *)img rect:(CGRect )rect
{
    
    // CGImageCreateWithImageInRect只认像素
    CGImageRef clipImage = CGImageCreateWithImageInRect(img.CGImage, rect);
    
    return [UIImage imageWithCGImage:clipImage];
}
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size isHeightorWidth:(int )isheightorwidth{
   
    CGSize newSize ;
    if(isheightorwidth)
    {
        
        newSize.height = size.height;
        
        newSize.width  = img.size.width*(size.height/img.size.height);
        
    }
    else
    {
        newSize.width = size.width;
        newSize.height = img.size.height*(size.width/img.size.width);
    }
    UIGraphicsBeginImageContext(newSize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    NSLog(@"size%lf,%lf",scaledImage.size.width,scaledImage.size.height);
    return scaledImage;
}
+ (UIImage *)clipImageSize:(UIImage *)img size:(CGSize)size isHeightorWidth:(int )isheightorwidth
{
    float clipX ;
    float clipY ;
    float clipW ;
    float clipH ;
    if (isheightorwidth) {
       
        clipX = 0;
        clipY = ((img.size.height - size.height)/2)*CLIPSCANSHU;
        clipW = size.width*CLIPSCANSHU;
        clipH = size.height*CLIPSCANSHU;
 
    }
    else
    {
        clipX = ((img.size.width -  size.width)/2);
        clipY = 0;
        clipW = size.width*CLIPSCANSHU;
        clipH  = size.height*CLIPSCANSHU;
        NSLog(@"size width%lf ---- image width%lf ---- clipx %lf",size.width,img.size.width,clipX);
  
    }
    
    CGRect clipRect = CGRectMake(clipX, clipY, clipW, clipH);
    
    // CGImageCreateWithImageInRect只认像素
    CGImageRef clipImage = CGImageCreateWithImageInRect(img.CGImage, clipRect);
    
    return [UIImage imageWithCGImage:clipImage];
}

@end
