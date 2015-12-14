//
//  infoBtn.m
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "infoBtn.h"

@implementation infoBtn
{
    UILabel* subjectTitle;
    UILabel* sortTitle;
    UILabel* infoLabel;
    UIImageView* infoimage;
}

-(id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initControl];
        [self setStyle];
        
    }
    
    return self;
}

-(void)initControl
{
    subjectTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,( self.frame.size.height-30)/2.0, 60, 30)];
    sortTitle = [[UILabel alloc] initWithFrame:CGRectMake(63, 3, 200, self.frame.size.height-6)];
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-120, 3, 80, self.frame.size.height-6)];
    infoLabel.textAlignment = NSTextAlignmentRight;
    infoimage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH-30, (self.frame.size.height-15)/2.0, 15, 15)];
    infoimage.image = [UIImage imageNamed:@"更多"];
    infoLabel.text = @"知识详情";
    [self addSubview:subjectTitle];
    [self addSubview:sortTitle];

    [self addSubview:infoimage];

    [self addSubview:infoLabel];

}

-(void)setStyle
{
    subjectTitle.backgroundColor = DAYTOPBACKCOLOR;
    subjectTitle.textColor = DAYTOPTEXTCOLOR;
    sortTitle.textColor = DAYTEXTCOLOR;
    infoLabel.textColor = DAYTEXTCOLOR;
    [subjectTitle.layer setCornerRadius:subjectTitle.frame.size.height/4.0];
   [subjectTitle.layer setMasksToBounds:YES];
}
@end
