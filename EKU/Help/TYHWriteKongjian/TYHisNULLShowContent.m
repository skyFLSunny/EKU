//
//  TYHisNULLShowContent.m
//  LYrecite
//
//  Created by tanyuehong on 15/11/18.
//  Copyright © 2015年 liyao. All rights reserved.
//


#import "TYHisNULLShowContent.h"


@interface   TYHisNULLShowContent ()

@property  (nonatomic,weak) UIImageView  *imageView;

@end

@implementation TYHisNULLShowContent

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.backgroundColor    = DAYBOTTOMColor;
        UIImageView  *imageView = [[UIImageView alloc] init];
        self.imageView          = imageView;
        [self addSubview:imageView];
    }
    return  self;
}
- (void)setNullImage:(UIImage *)image
{
    if (image != nil)
    {
        self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        self.imageView.image = image;
    }
    
}
- (void)layoutSubviews
{
    CGSize  imageSize = self.imageView.image.size;
    CGRect   rect = self.frame;
    
    CGFloat  imageViewX ;
    CGFloat  imageViewY ;
    CGFloat  imageViewW ;
    CGFloat  imageViewH ;
    
    if (imageSize.width>rect.size.width)
    {
        imageViewX  = 0;
        imageViewW  = rect.size.width;
    
    }else
    {
        imageViewX = rect.size.width/2 - imageSize.width/2;
        imageViewW = imageSize.width;
    }
    if(imageSize.height >rect.size.height)
    {
        imageViewY = 0;
        imageViewH = rect.size.height;
        
    }else
    {
        imageViewY = rect.size.height/2 - imageSize.height/2;
        imageViewH = imageSize.height;
    }
    
    
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
}

- (UIImageView *)getSHowImageView
{
    return  _imageView;
}
@end
