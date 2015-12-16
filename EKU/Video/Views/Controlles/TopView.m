//
//  TopView.m
//  EKU
//
//  Created by 李瑶 on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TopView.h"

@implementation TopView
{
    UIView* sepView;
    UIView* headerView;
    UILabel* titileLabel;
}
-(id)initWithFrame:(CGRect)frame withTitle:(NSString*)aTitile
{
    if (self = [super initWithFrame:frame]) {
        [self initHeaderWithTitle:aTitile];
    }
    
    return self;
}
-(void)initHeaderWithTitle:(NSString*)aStr
{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 45)];
    headerView.backgroundColor = DAYTOPBACKCOLOR;
    headerView.alpha = 0.1;
    
    titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH-100, 45)];
    titileLabel.text = aStr;
    titileLabel.textColor = DAYBACKCOLOR;
    titileLabel.backgroundColor = [UIColor clearColor];
    
    sepView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREENWIDTH, 0.5)];
    sepView.backgroundColor = DAYBACKCOLOR;
    
    [self addSubview:sepView];
    [self addSubview:titileLabel];
    [self addSubview:headerView];
}

@end
