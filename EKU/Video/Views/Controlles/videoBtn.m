//
//  videoBtn.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "videoBtn.h"

@implementation videoBtn

- (void)layoutSubviews
{
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-25);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
    self.titleLabel.textAlignment  = NSTextAlignmentCenter;
    self.titleLabel.font = NORMOLEFONT;

    [self.layer setMasksToBounds:YES];
    
}
- (void)dealloc
{
    NSLog(@"shifangle ");
}
@end
