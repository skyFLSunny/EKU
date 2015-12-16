//
//  LeftBtn.m
//  EKU
//
//  Created by 李瑶 on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LeftBtn.h"

@implementation LeftBtn
- (void)layoutSubviews
{
    self.imageView.frame = CGRectMake(0, 12.5, self.frame.size.height-25, self.frame.size.height-25);
    self.titleLabel.frame = CGRectMake(self.frame.size.height-23, 0, self.frame.size.width-self.frame.size.height, self.frame.size.height);
  
    self.imageView.image = [UIImage imageNamed:@"播放-1.png"];
    
    
  
    
}

@end
