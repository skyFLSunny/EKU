//
//  WStringHelper.h
//  ScanningKing
//
//  Created by wzrong1@gmail.com on 12-11-2.
//  Copyright (c) 2012年 北京凤凰学易科技有限公司. All rights reserved.
//
//  字符串助手
//
//  说明：
//      对字符串进行一些必要的处理，如：编码...
//

#import <Foundation/Foundation.h>

@interface WStringHelper : NSObject

/*
 对 url 字符串进行UTF8编码
 **/ 
+ (NSString *)urlEncodingUTF8:(NSString *)str;

/*
 判断是否为空字符及空格
 **/
+ (BOOL)isEmpty:(NSString *)str;

/**
 *  判断一个字符串是否包含另外一个字符串
 *
 *  @param motherString 母字符串
 *  @param sonString    子字符串
 *
 *  @return 包含 ? YES : NO
 */
+ (BOOL)stringContentString:(NSString *)motherString subString:(NSString *)sonString;

/*
 格式化日期字符串
 stringDate: 日期字符串，如：2013-01-31 14:08:34
 oldFormatter: 旧日期格式，如果为@""或nil时，默认为 @"yyyy/MM/dd HH:mm:ss"
 newFormatter: 新日期格式，如果为@""或nil时，默认为 @"yyyy-MM-dd HH:mm:ss"
 **/
+ (NSString *)dateFormatter:(NSString *)stringDate oldFormatter:(NSString *)oldFormatter newFormatter:(NSString *)newFormatter;

/**
 格式化时间
 timeSeconds 为0时表示当前时间,可以传入你定义的时间戳
 timeFormatStr为空返回当当时间戳,不为空返回你写的时间格式(yyyy-MM-dd HH:ii:ss)
 setTimeZome ([NSTimeZone systemTimeZone]获得当前时区字符串)
 */
+(NSString *)setTimeInt:(NSTimeInterval)timeSeconds setTimeFormat:(NSString *)timeFormatStr setTimeZome:(NSString *)timeZoneStr;

/**
 解析查询字符串
 query : 查询字符串
 */
+ (NSDictionary *)parseQueryString:(NSString *)query;

/**
 删掉字符串中的包含的html标签，以及转义符
 strHtml : 含有html标签的字符串
 */
+ (NSString *) stringByStrippingHTML:(NSString *)strHtml;

/**
 删掉字符串中的包含的html标签，以及转义符
 strHtml : 含有html标签的字符串
 */
+ (NSString *)stringByStrippingHTML:(NSString *)strHtml regex:(NSString *)reg;

/**
 是否为有效的Email
 checkString : 检测字符串
 */
+ (BOOL) isValidEmail:(NSString *)checkString;

/**
 获得星期天
 */
+ (NSInteger)getweek;


@end
