//
//  showErrorView.m
//  LYrecite
//
//  Created by 李瑶 on 15/11/7.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import "showErrorView.h"


@interface showErrorView  ()

@property (nonatomic, weak) UILabel* label;
@property (nonatomic, weak) UIImageView* image;
@property (atomic,assign) BOOL  isshow;

@end
 static  showErrorView  *sharedViewInstance = nil;
@implementation showErrorView

+(showErrorView*)shareWithTtile:(NSString*)title  withFangXiang:(int )flag
{
    
  sharedViewInstance = [[showErrorView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
  sharedViewInstance.isshow = false;

    //这段代码的作用时当正在提示 的时候 点击  什么也不做
    
    if ( DEL.isShowError == 1)
    {
        return  nil;
    }
    else
    {
         DEL.isShowError=1;
    }
    sharedViewInstance.label.text = @"";
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        sharedViewInstance.label.text = @"";
        sharedViewInstance.label.text = title;
        sharedViewInstance.label.textColor = [UIColor whiteColor];
        sharedViewInstance.image.image = flag?[UIImage imageNamed:@"TOP无网络小人"]:[UIImage imageNamed:@"TOP有网络小人"];
       
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (flag == 1 || flag == 0)
        {
            if (flag == 1)
            {
                sharedViewInstance.backgroundColor = UIColorFromRGB(0Xff5555);
            }
            if (flag == 0)
            {
                
                sharedViewInstance.backgroundColor = UIColorFromRGB(0X31c27c);
            }
        }
        sharedViewInstance.frame = CGRectMake(0, 64, SCREENWIDTH, 64);
       
        [DEL.window addSubview:sharedViewInstance];
        
        [sharedViewInstance animatshowwithFlage:flag];
    });
    
    return sharedViewInstance;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initBtn];
        
    }
    return self;
}
-(void)initBtn
{
    UIImageView* im = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 34, 34) ];
    _image = im;
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, SCREENWIDTH-100, 44)];
    _label = label;
    _label.textAlignment = NSTextAlignmentLeft;
    _label.numberOfLines = 0;

        _label.font = NORMOLEFONT;
    [self addSubview:_image];
    [self addSubview:_label];
}
-(void)animatshowwithFlage:(int)flag
{
    
         self.frame = CGRectMake(0, -64, SCREENWIDTH,64);
        [UIView animateWithDuration:0.5 animations:^{
            
            self.frame = CGRectMake(0, 0, SCREENWIDTH, 64);
            
        } completion:^(BOOL finished)
         {
             [self performSelector:@selector(animathidewithFlag:) withObject:[NSNumber numberWithInt:flag] afterDelay:2.0f];
         }];
    

}
-(void)animathidewithFlag:(NSNumber *)flag
{
       
    
        self.frame = CGRectMake(0, 0, SCREENWIDTH, 64);
        
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(0, 0, SCREENWIDTH,-64);
            
        } completion:^(BOOL finished) {
            
              DEL.isShowError=0;
            [self removeFromSuperview];
            
        }];
   
}

@end
