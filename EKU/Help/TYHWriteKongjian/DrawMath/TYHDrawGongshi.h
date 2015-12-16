//
//  TYHDrawGongshi.h
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/22.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MathImageModel.h"

@interface TYHDrawGongshi : NSObject

@property (nonatomic,strong,readonly)NSMutableArray *contentArr;

+ (instancetype)TYHDrawGongshiWithString:(NSMutableArray *)contentString;
- (MathImageModel *)DrawGongshi;
@end
