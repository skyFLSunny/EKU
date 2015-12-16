//
//  TYHDowLoadMole.m
//  LYrecite
//
//  Created by tanyuehong on 15/11/11.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import "TYHDowLoadMole.h"
#define  sourtIDMY  @"mysorIdMT"
#define  MYflage  @"MYflage"
#define  DOwnPathString @"downLoadPathString"

@implementation TYHDowLoadMole

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInteger:self.sortID forKey:sourtIDMY];
    [encoder encodeInteger:self.flage forKey:MYflage];
    [encoder encodeObject:self.downLoadString forKey:DOwnPathString];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self.sortID = [aDecoder decodeIntegerForKey:sourtIDMY];
    self.flage  = [aDecoder decodeIntegerForKey:MYflage];
    self.downLoadString = [aDecoder decodeObjectForKey:DOwnPathString];
    return  self;
}


@end
