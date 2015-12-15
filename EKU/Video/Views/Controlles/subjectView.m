//
//  subjectView.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "subjectView.h"

@implementation subjectView
{
   
    
}
- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIButton *btn= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        _btn = btn;
        [_btn.layer setCornerRadius:self.frame.size.width/2.0];
        [_btn.layer setMasksToBounds:YES];
       UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width+5,self.frame.size.width, self.frame.size.height - self.frame.size.width-5)];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = NORMOLEFONT;
        _textLabel = textLabel;
        [self addSubview:_btn];
        [self addSubview:_textLabel];
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"shifangle ");
}
@end
