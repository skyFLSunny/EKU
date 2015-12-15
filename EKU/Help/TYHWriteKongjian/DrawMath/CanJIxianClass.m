//
//  CanJIxianClass.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/11/6.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import "CanJIxianClass.h"

@interface CanJiXianClass  ()

@property (nonatomic,assign) CGFloat jixian;

@property (nonatomic,assign) CGFloat botomHeit;

@property (nonatomic,strong) NSMutableArray *JixianArr;

@end

@implementation CanJiXianClass

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        self.jixian = 0;
        self.botomHeit = 0;
        self.JixianArr = [NSMutableArray array];
    }
    
    return  self;
    
}

- (void)setHeitAndCurentJixian:(CGFloat)height andJixian:(CGFloat)jixian
{
    
    if (jixian >self.jixian)
    {
        self.jixian  = jixian;
    }
    if (height >self.botomHeit)
    {
        self.botomHeit = height;
    }
    
    [self.JixianArr addObject:[NSNumber numberWithFloat:jixian]];
}

- (CGFloat)getHight
{
    
    return  self.jixian + self.botomHeit;
}

- (CGFloat)getJiXian
{
    return  self.jixian;
}

- (CGFloat )getJIxinWithIndx:(int)index
{
    if(self.JixianArr.count == 0)
    {
        return  0;
    }
    if (index>self.JixianArr.count-1) {
         return  0;
    }
    CGFloat jixian = [self.JixianArr[index] floatValue];
    return jixian;
}

@end
