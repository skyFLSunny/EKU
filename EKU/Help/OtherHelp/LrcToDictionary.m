#import "LrcToDictionary.h"

@implementation LrcToDictionary
@synthesize _arrayTemp;
@synthesize _arrayItemList;

//加载LRC内容
-(void)LoadData:(NSString *)txtLrc
{
    [self setDefaultValuesWithCurrentModel];
    
    NSArray * tempArray=[txtLrc componentsSeparatedByString:@"\n"];
    for (NSString *str in tempArray)
    {
        if (str && str.length > 0)
        {
            [_arrayTemp removeAllObjects]; // 清除数组里面的临时数据
            [self parseLrcLineWithLineText:str];
            [self parseTempArray:_arrayTemp];
        }
    }
    if (_arrayItemList && _arrayItemList.count > 0)
        [self sortAllItem:_arrayItemList];
}

-(void) parseLrcLineWithLineText:(NSString *)sourceLineText{
    if (!sourceLineText || sourceLineText.length <= 0)
        return;
    NSRange range = [sourceLineText rangeOfString:@"]"];
    if (range.length > 0)
    {
        NSString * time = [sourceLineText substringToIndex:range.location + 1];
        //NSLog(@"time = %@",time);
        NSString * other = [sourceLineText substringFromIndex:range.location + 1];
        //NSLog(@"other = %@",other);
        if (time && time.length > 0&&[time rangeOfString:@":"].location != NSNotFound)
            [_arrayTemp addObject:time];
        if (other)
            [self parseLrcLineWithLineText:other];
    }else
    {
        [_arrayTemp addObject:sourceLineText];
    }
}

-(NSString *)timeToSecond:(NSString *)formatTime {
    if (!formatTime || formatTime.length <= 0)
        return nil;
    if ([formatTime rangeOfString:@"["].length <= 0 && [formatTime rangeOfString:@"]"].length <= 0)
        return nil;
    NSString * minutes = [formatTime substringWithRange:NSMakeRange(1, 2)];
    NSString * second = [formatTime substringWithRange:NSMakeRange(4, 5)];
    float finishSecond = minutes.floatValue * 60 + second.floatValue;
    return [NSString stringWithFormat:@"%f",finishSecond];
}

-(void) parseTempArray:(NSMutableArray *) tempArray
{
    if (!tempArray || tempArray.count <= 0)
        return;
    NSString *value = [tempArray lastObject];
    if (!value || ([value rangeOfString:@"["].length > 0 && [value rangeOfString:@"]"].length > 0))
    {
        [_arrayTemp removeAllObjects];
        return;
    }
    
    for (int i = 0; i < tempArray.count - 1; i++)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init] ;
        NSString * key = [tempArray objectAtIndex:(NSUInteger)i];
        NSString *secondKey = [self timeToSecond:key]; // 转换成以秒为单位的时间计数器
        [dic setObject:value forKey:secondKey];
        [_arrayItemList addObject:dic];
    }
    [_arrayTemp removeAllObjects];
    
}

// 以时间顺序进行排序
-(void)sortAllItem:(NSMutableArray *)array {
    if (!array || array.count <= 0)
        return;
    for (int i = 0; i < array.count - 1; i++)
    {
        for (int j = i + 1; j < array.count; j++)
        {
            id firstDic = [array objectAtIndex:(NSUInteger )i];
            id secondDic = [array objectAtIndex:(NSUInteger)j];
            if (firstDic && [firstDic isKindOfClass:[NSDictionary class]] && secondDic && [secondDic isKindOfClass:[NSDictionary class]])
            {
                NSString *firstTime = [[firstDic allKeys] objectAtIndex:0];
                NSString *secondTime = [[secondDic allKeys] objectAtIndex:0];
                BOOL b = firstTime.floatValue > secondTime.floatValue;
                if (b) // 第一句时间大于第二句，就要进行交换
                {
                    [array replaceObjectAtIndex:(NSUInteger )i withObject:secondDic];
                    [array replaceObjectAtIndex:(NSUInteger )j withObject:firstDic];
                }
            }
        }
    }
}

-(void) setDefaultValuesWithCurrentModel
{
    if (!_arrayTemp)
    {
        _arrayTemp = [[NSMutableArray alloc] init];
    }
    
    if (!_arrayItemList) {
        _arrayItemList = [[NSMutableArray alloc] init];
    }
}




@end