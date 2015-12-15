//
//  TYHScrollView.m
//  LYrecite
//
//  Created by tanyuehong on 15/10/27.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import "TYHScrollView.h"

@interface  TYHScrollView ()  <UIScrollViewDelegate>

//这是在里面滑动的控件

@property (nonatomic,weak)UIImageView *imageView;

@property (nonatomic,assign)CGRect  firitFrame;

@end
@implementation TYHScrollView

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    self.delegate = self;
    self.minimumZoomScale = 0.5;
    self.maximumZoomScale = 2.0;
    
    if (view.tag==1) {
        self.imageView = (UIImageView *)view;
        self.firitFrame = view.frame;
    }
}
  

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (UIView *view in [self subviews]) {
        
        if (view.tag == 1) {
            return view;
        }
    }
    return  nil;
}





- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.contentSize = self.imageView.frame.size;
    CGPoint  center  = self.center;
    
    CGSize  imageSize = self.imageView.frame.size;
    if (self.contentSize.width<SCREENWIDTH)
    {
        self.imageView.center = CGPointMake(SCREENWIDTH/2, center.y);
        return ;
    }
    
    CGFloat  rectX =  self.contentSize.width/2 - imageSize.width/2;
    CGFloat  rectY =  self.frame.size.height/2 - imageSize.height/2;
    self.imageView.frame = CGRectMake(rectX,rectY, imageSize.width, imageSize.height);
    
}

- (void)imageViewRecover
{
    [UIView animateWithDuration:0.3 animations:^{
         self.imageView.frame = self.firitFrame;
        self.contentSize = CGSizeMake(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}




@end
