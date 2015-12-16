//
//  oprationType.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/16.
//  Copyright (c) 2015年 tanyuehong. All rights reserved.
//

#import "oprationType.h"

@interface oprationType  ()

@property (nonatomic,strong) NSMutableArray  *oprationTypeArr;

@property (nonatomic,strong) NSMutableArray  *zhuanyiArr;

@property (nonatomic,strong) NSMutableArray  *zhuanyiRusult;

@property (nonatomic,strong) NSMutableArray  *xietiArr;

@property (nonatomic,strong) NSMutableArray  *fanXietiArr;

@end

@implementation oprationType

+ (oprationType *)sharedOprationType
{
    static oprationType *shareOprationTypeInstance = nil;
    static dispatch_once_t  predicate;
    dispatch_once(&predicate, ^{
        shareOprationTypeInstance  = [[self alloc] init];
    });
    
    return  shareOprationTypeInstance;
}

//这里是生成运算类型的地方

- (NSMutableArray  *)oprationTypeArr
{
    if (_oprationTypeArr == nil) {
        _oprationTypeArr = [NSMutableArray array];
        
        [_oprationTypeArr addObject:@"\\frac"];
        [_oprationTypeArr addObject:@"\\sup"];
        [_oprationTypeArr addObject:@"\\sub"];
        [_oprationTypeArr addObject:@"\\ud"];
        [_oprationTypeArr addObject:@"\\sum"];
        [_oprationTypeArr addObject:@"\\sum∩olimits"];
        [_oprationTypeArr addObject:@"\\sqrt"];
        [_oprationTypeArr addObject:@"\\equ"];
        [_oprationTypeArr addObject:@"\\onu"];
        [_oprationTypeArr addObject:@"\\ond"];
        [_oprationTypeArr addObject:@"\\onud"];
        [_oprationTypeArr addObject:@"\\to"];
        [_oprationTypeArr addObject:@"\\cdel"];
        [_oprationTypeArr addObject:@"\\cnot"];
        [_oprationTypeArr addObject:@"\\cdown"];
        [_oprationTypeArr addObject:@"\\spin"];
        [_oprationTypeArr addObject:@"`"];
        [_oprationTypeArr addObject:@"\\tab"];
        
        
        
    }
    return _oprationTypeArr;
}

- (NSMutableArray *)zhuanyiRusult
{
    if (_zhuanyiRusult == nil)
    {
        _zhuanyiRusult = [NSMutableArray arrayWithArray:@[@"∈",@"α",@"γ",@"∈",@"η",@"κ",@"π",@"λ",@"→",@"↑",@"℃",@"×",@"≠",@"≤",@"≥",@"≦",@"〥",@"≈",@"β",@"δ",@"ξ",@"θ",@"ω",@"ρ",@"∞",@"←",@"↓",@"√",@"≧",@"＜",@"＞",@"φ",@"μ",@"∠",@"∵",@"⊥",@"‰",@"∩",@"∑",@"÷",@"∴",@"△",@"°",@"∪",@"∫",@"〇",@"±",@"∅",@"•",@"⑩",@"①",@"②",@"③",@"④",@"⑤",@"⑥",@"⑦",@"⑧",@"⑨"]];
    }
    return _zhuanyiRusult;
}

-(NSMutableArray *)zhuanyiArr
{
    
    if (_zhuanyiArr == nil) {
        
        _zhuanyiArr = [NSMutableArray arrayWithArray:@[@"\\∈",@"\\a",@"\\r",@"\\E",@"\\eta",@"\\k",@"\\pi",@"\\入",@"\\-->",@"\\up",@"\\.c",@"\\x",@"\\=/",@"\\<=1",@"\\>=1",@"\\<=",@"\\6",@"\\~~",@"\\b",@"\\delta",@"\\var",@"\\0.",@"\\w",@"\\p",@"\\8",@"\\<--",@"\\down",@"\\v",@"\\>=",@"\\<",@"\\>",@"\\o||",@"\\|u",@"\\/-",@"\\._.",@"\\T",@"\\。/。。",@"\\n",@"\\he",@"\\/",@"\\.-.",@"\\---",@"\\。",@"\\U",@"\\ff",@"\\0",@"\\+-",@"\\o|",@"\\.",@"\\o10",@"\\o1",@"\\o2",@"\\o3",@"\\o4",@"\\o5",@"\\o6",@"\\o7",@"\\o8",@"\\o9"]];
        
    }
    return _zhuanyiArr;
}

- (NSMutableArray *)xietiArr
{
    if (_xietiArr == nil)
    {
        _xietiArr = [NSMutableArray arrayWithArray:@[@"log",@"lim",@"lg",@"α", @"β", @"λ", @"ω", @"ρ", @"φ", @"π", @"θ", @"f", @"a", @"b", @"c", @"d", @"e", @"g", @"h", @"i", @"j", @"k",  @"m", @"n", @"x", @"y", @"z"]];
    }
    return _xietiArr;
}

- (NSMutableArray *)fanXietiArr
{
    if (_fanXietiArr == nil)
    {
        _fanXietiArr = [NSMutableArray arrayWithArray:@[@"cos", @"sin",@"tan",@"ctan"]];
    }
    return _fanXietiArr;
    
}

- (NSMutableArray *)getfanXietiArr
{
    return  self.fanXietiArr;
}
- (NSMutableArray  *)getzhuanyizifu
{
    return self.zhuanyiArr;
}

- (NSMutableArray *)getZhuanYIResult
{
    return self.zhuanyiRusult;
}

- (NSMutableArray  *)getxieTieArr
{
    return self.xietiArr;
}
- (NSMutableArray  *)getoprationType
{
    return self.oprationTypeArr;
}

@end
