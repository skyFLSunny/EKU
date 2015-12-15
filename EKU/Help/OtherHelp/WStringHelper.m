//
//  EStringHelper.m
//  ENetcom
//
//  Created by wzrong1@gmail.com on 12-11-2.
//  Copyright (c) 2012年 北京凤凰学易科技有限公司. All rights reserved.
//

#import "WStringHelper.h"
#import <arpa/inet.h>

//#import "RegexKitLite.h"

@implementation WStringHelper

/**
*  对 url 字符串进行UTF8编码
*
*  @param str 需要编码的字符串
*
*  @return 编码后的字符串
*/
+ (NSString *)urlEncodingUTF8:(NSString *)str{
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[] ",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

/**
 *  判断是否为空字符及空格
 *
 *  @param str 要判断的字符串
 *
 *  @return 包含空格 ? YES : NO
 */
+ (BOOL)isEmpty:(NSString *)str{
    if (!str) {
        return YES;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

/**
 *  判断一个字符串是否包含另外一个字符串
 *
 *  @param motherString 母字符串
 *  @param sonString    子字符串
 *
 *  @return 包含 ? YES : NO
 */
+ (BOOL)stringContentString:(NSString *)motherString subString:(NSString *)sonString{
    if ([motherString rangeOfString:sonString].location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

/**
 *  格式化日期字符串
 *
 *  @param stringDate   日期字符串，如：2013-01-31 14:08:34
 *  @param oldFormatter 旧日期格式，如果为@""或nil时，默认为 @"yyyy/MM/dd HH:mm:ss"
 *  @param newFormatter 新日期格式，如果为@""或nil时，默认为 @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 格式化以后的日期字符串
 */
+ (NSString *)dateFormatter:(NSString *)stringDate oldFormatter:(NSString *)oldFormatter newFormatter:(NSString *)newFormatter{
    // 旧日期
    NSDateFormatter *oldDate = [[NSDateFormatter alloc] init];
    if ([oldFormatter isEqualToString:@""] || oldFormatter == nil) {
        [oldDate setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    }else{
        [oldDate setDateFormat:oldFormatter];
    }

    // 从字符串生成日期对象
    NSDate *date = [oldDate dateFromString: stringDate];

    // 新日期
    NSDateFormatter *newDate = [[NSDateFormatter alloc] init];
    
    if ([newFormatter isEqualToString:@""] || newFormatter == nil) {
        [newDate setDateFormat:@"yyyy-MM-dd"];
    }else{
        [newDate setDateFormat:newFormatter];
    }

    // 从日期对象生成字符串
    NSString *dateString = [newDate stringFromDate:date];

    NSString *result = [NSString stringWithFormat:@"%@", dateString];
    return result;
}

/**
 *  格式化时间字符
 *
 *  @param timeSeconds   为0时表示当前时间,可以传入你定义的时间戳
 *  @param timeFormatStr 为空返回当当时间戳,不为空返回你写的时间格式(yyyy-MM-dd HH:ii:ss)
 *  @param timeZoneStr   ([NSTimeZone systemTimeZone]获得当前时区字符串)
 *
 *  @return 格式化后的时间字符
 */
+(NSString *)setTimeInt:(NSTimeInterval)timeSeconds setTimeFormat:(NSString *)timeFormatStr setTimeZome:(NSString *)timeZoneStr{
    NSString *date_string;

    NSDate *time_str;
    if ( timeSeconds>0 ) {
        time_str = [NSDate dateWithTimeIntervalSince1970:timeSeconds];
    }else{
        time_str= [[NSDate alloc] init];
    }

    if ( timeFormatStr==nil) {
        date_string = [NSString stringWithFormat:@"%ld", (long)[time_str timeIntervalSince1970]];
    }else{
        NSDateFormatter *date_format_str = [[NSDateFormatter alloc] init];
        [date_format_str setDateFormat:timeFormatStr];
        if( timeZoneStr!=nil ){
            [date_format_str setTimeZone:[NSTimeZone timeZoneWithName:timeZoneStr]];
        }
        date_string = [date_format_str stringFromDate:time_str];
    }

    return date_string;
}

/**
 *  解析查询字符串
 *
 *  @param query 查询字符串，以 ‘&’ 分隔
 *
 *  @return 参数字典
 */
+ (NSDictionary *)parseQueryString:(NSString *)query {
    // 定义字典
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 检测字符串中是否包含 ‘？’
    NSRange range = [query rangeOfString:@"?"];
    if(range.location != NSNotFound){
        NSArray *queryArr = [query componentsSeparatedByString:@"?"];
        [dict setObject:queryArr[0] forKey:@"url"];
        query = queryArr[1];
    }else{
        // 如果一个url连 '?' 都没有，那么肯定就没有参数
        return dict;
    }
    
    // 检测字符串中是否包含 ‘&’
    if([query rangeOfString:@"&"].location != NSNotFound){
        // 以 & 来分割字符，并放入数组中
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        // 遍历字符数组
        for (NSString *pair in pairs) {
            // 以等号来分割字符
            NSArray *elements = [pair componentsSeparatedByString:@"="];
            NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            // 添加到字典中
            [dict setObject:val forKey:key];
        }
    }else if([query rangeOfString:@"="].location != NSNotFound){ // 检测字符串中是否包含 ‘=’
        NSArray *elements = [query componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        // 添加到字典中
        [dict setObject:val forKey:key];
    }
    
    NSLog(@"dict -> %@", dict);
    return dict;
}

/**
 *  删掉字符串中的包含的html标签，以及转义符
 *
 *  @param strHtml 含有html标签的字符串
 *
 *  @return 删除html标签后的字符串
 */
+ (NSString *)stringByStrippingHTML:(NSString *)strHtml{
    NSRange r;
    NSString *s = [strHtml copy];
    while ((r = [s rangeOfString:@"<[^>]+>|&[^;]+;" options:NSRegularExpressionSearch]).location != NSNotFound){
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    }
    return s;
}

/**
 *  删掉字符串中的包含的html标签，以及转义符
 *
 *  @param strHtml 含有html标签的字符串
 *  @param reg     正则表达式
 *
 *  @return 删除html标签后的字符串
 */
+ (NSString *)stringByStrippingHTML:(NSString *)strHtml regex:(NSString *)reg{
    NSRange r;
    NSString *s = [strHtml copy];
    while ((r = [s rangeOfString:reg options:NSRegularExpressionSearch]).location != NSNotFound){
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    }
    return s;
}

/**
 *  是否为有效的Email
 *
 *  @param checkString 检测字符串
 *
 *  @return 有效的Email ? YES : NO
 */
+ (BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

/**
 *  获得今天为星期几
 *
 *  @return 星期几
 */
+ (NSInteger)getweek{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;

    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    return [comps weekday] - 1;
}

@end
