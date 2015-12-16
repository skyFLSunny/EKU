//
//  TYHShowGoodPL.m
//  LYrecite
//
//  Created by tanyuehong on 15/9/24.
//  Copyright © 2015年 liyao. All rights reserved.
//

#define  lachcountkey     @"appLachCount"
#define  delayGoogPL      @"delayGoodPl"
#define  showGoogPLTime      @"timeafferSHow"

#import "TYHShowGoodPL.h"

@implementation TYHShowGoodPL

static BOOL  isDebug;


+ (void)appDidLached:(BOOL)islached
{
    
    NSInteger   lachcount = [[NSUserDefaults standardUserDefaults] integerForKey:lachcountkey];
    lachcount++;
    [[NSUserDefaults standardUserDefaults] setInteger:lachcount forKey:lachcountkey];
    if (lachcount==1)
    {
         NSDate *curent = [NSDate date];
         NSInteger  timetraver = [curent timeIntervalSince1970];
         [[NSUserDefaults standardUserDefaults] setInteger:timetraver forKey:showGoogPLTime];
            
    }
       
    
    
}
+(BOOL )isShoudShowGoodPl
{
    NSInteger  flag = [[NSUserDefaults standardUserDefaults] integerForKey:@"yijinghaoping"];
    if (flag == 8) {
        return false;
    }
    NSInteger lachCount = [[NSUserDefaults standardUserDefaults] integerForKey:lachcountkey];
    NSInteger  timeTraver = [[NSUserDefaults standardUserDefaults] integerForKey:showGoogPLTime];
    NSInteger  curentTrver = [[NSDate date] timeIntervalSince1970];
    NSInteger  isShow = [[NSUserDefaults standardUserDefaults] integerForKey:showGoogPLTime];
    if (lachCount>30 && (timeTraver+60*60*24*3)<curentTrver &&isShow!=6)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:6 forKey:showGoogPLTime];
        return  YES;
    }
    NSDate  *courrentDate = [NSDate date];
    NSInteger currentInterval  = [courrentDate  timeIntervalSince1970];
    
    
    NSInteger dateInter = [[NSUserDefaults standardUserDefaults] integerForKey:delayGoogPL];
    
    if (dateInter>10)
    {
        if (currentInterval>dateInter)
        {
            
            return YES;
        }
        
    }
    
    
    return  false;
    
}



+ (void)setDebug:(BOOL)Debug
{
    isDebug = Debug;
    
}


@end
