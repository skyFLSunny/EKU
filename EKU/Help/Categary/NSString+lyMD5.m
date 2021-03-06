//
//  NSString+lyMD5.m
//  downLoadDemo
//
//  Created by liyao on 15/5/27.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import "NSString+lyMD5.h"

@implementation NSString (lyMD5)
-(NSString*)MD5
{
    const char *cStr=[self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
