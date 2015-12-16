//
//  NSString+lyMD5.h
//  downLoadDemo
//
//  Created by liyao on 15/5/27.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (lyMD5)
-(NSString*)MD5;
@end
