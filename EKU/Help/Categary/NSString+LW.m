//
//  Nsssaf.m
//  com.red.LWSina
//
//  Created by tanyuehong on 15-5-11.
//  Copyright (c) 2015年 tanyuehong. All rights reserved.
//

#import "NSString+LW.h"

@implementation NSString (LW)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName :font };
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (NSString *)dictWithString:(NSDictionary *)dict
{
    NSString  *dictstring = @"[{\"NewsSortID\":1,\"Sorting\":100,\"ParentID\":0,\"Name\":\"语文\",\"IconPath\":\"1.png\",\"AddTime\":\"2015-05-28 11:09:47\",\"UpdateTime\":\"2015-05-28 11:09:47\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":2,\"Sorting\":90,\"ParentID\":0,\"Name\":\"数学\",\"IconPath\":\"2.png\",\"AddTime\":\"2015-05-28 11:10:54\",\"UpdateTime\":\"2015-05-28 11:10:54\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":3,\"Sorting\":80,\"ParentID\":0,\"Name\":\"英语\",\"IconPath\":\"3.png\",\"AddTime\":\"2015-05-28 11:16:35\",\"UpdateTime\":\"2015-05-28 11:16:35\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":4,\"Sorting\":70,\"ParentID\":0,\"Name\":\"物理\",\"IconPath\":\"4.png\",\"AddTime\":\"2015-05-28 11:17:28\",\"UpdateTime\":\"2015-05-28 11:17:28\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":5,\"Sorting\":60,\"ParentID\":0,\"Name\":\"化学\",\"IconPath\":\"5.png\",\"AddTime\":\"2015-05-28 11:17:45\",\"UpdateTime\":\"2015-05-28 11:17:45\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":6,\"Sorting\":60,\"ParentID\":0,\"Name\":\"生物\",\"IconPath\":\"6.png\",\"AddTime\":\"2015-05-28 11:17:49\",\"UpdateTime\":\"2015-05-28 11:17:49\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":7,\"Sorting\":50,\"ParentID\":0,\"Name\":\"政治\",\"IconPath\":\"7.png\",\"AddTime\":\"2015-05-28 11:17:56\",\"UpdateTime\":\"2015-05-28 11:17:56\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":8,\"Sorting\":40,\"ParentID\":0,\"Name\":\"历史\",\"IconPath\":\"8.png\",\"AddTime\":\"2015-05-28 11:18:01\",\"UpdateTime\":\"2015-05-28 11:18:01\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":9,\"Sorting\":30,\"ParentID\":0,\"Name\":\"地理\",\"IconPath\":\"9.png\",\"AddTime\":\"2015-05-28 11:18:14\",\"UpdateTime\":\"2015-05-28 11:18:14\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":53,\"Sorting\":10,\"ParentID\":673,\"Name\":\"语文作文\",\"IconPath\":\"53.png\",\"Addt1ime\":\"2015-06-01 11:36:28\",\"UpdateTime\":\"2015-06-01 11:36:28\",\"Difficulty\":\"1\",\"Important\":\"1\"},{\"NewsSortID\":676,\"Sorting\":5,\"ParentID\":673,\"Name\":\"英语作文\",\"IconPath\":\"676.png\",\"Addt1ime\":\"2015-06-04 11:40:28\",\"UpdateTime\":\"2015-06-04 11:40:28\",\"Difficulty\":\"1\",\"Important\":\"1\"}]";
    return dictstring;
    
    
}

@end
