//
//  videoModel.h
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface videoModel : NSObject
@property (nonatomic, assign) float height;
@property (nonatomic, strong) NSMutableArray* videoArray;
@property (nonatomic, strong) NSString* subjectTitle;
@end
