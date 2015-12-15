#import "Helper.h"

#import "UIImage+LY.h"
@implementation Helper

NSDictionary* dicSubjectPager=nil;
NSMutableArray *arrFavor=nil;


//获得某分类显示的页码
-(int)getSubjectPagerValue : (NSString *) key
{
    [self loadSubjectPager];
    NSString *data = [dicSubjectPager valueForKey:key];
    return [data intValue];
}

//保存某分类显示的页码
-(void)setSubjectPagerValue : (int) dataValue : (NSString *)key
{
    [self loadSubjectPager];
    NSString *value=[[NSString alloc]initWithFormat:@"%d",dataValue];
    [dicSubjectPager  setValue:value forKey:key];
    
    
    //保存
    [dicSubjectPager writeToFile: [self getSubjectPagerPath ] atomically:YES];
}

//返回集合
-(NSMutableArray *)getFavorArray
{
    [self loadFavor];
    return arrFavor;
}
//添加一个收藏
-(void)addFavorValue : (int) data
{
    [self loadFavor];
    for (NSInteger i=0; i<arrFavor.count; i++) {
        int tmp = [[arrFavor objectAtIndex:i] intValue];
        if(data==tmp)
            return;
    }
    NSString *obj=[[NSString alloc]initWithFormat:@"%d",data];
    [arrFavor addObject:obj];
    //保存
    [arrFavor writeToFile: [self getFavorPath ] atomically:YES];
}
//删除一个收藏
-(void)delFavorValue : (int) data
{
    [self loadFavor];
    for (NSInteger i=0; i<arrFavor.count; i++) {
        int tmp = [[arrFavor objectAtIndex:i] intValue];
        if(data==tmp)
        {
            [arrFavor removeObjectAtIndex:i];
            //保存
            [arrFavor writeToFile: [self getFavorPath ] atomically:YES];
            return;
        }
    }
}


-(void)loadSubjectPager
{
    NSString *path=[self getSubjectPagerPath ];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path])
    {
        dicSubjectPager = [NSDictionary dictionaryWithContentsOfFile:
                           [self getSubjectPagerPath ]];
    }
    else {
        NSString *value=@"-1";
        dicSubjectPager=[[NSDictionary alloc]initWithObjectsAndKeys:value,@"1",value,@"2",value,@"3",value,@"4",value,@"5",value,@"6",value,@"7",value,@"8",value,@"9",value,@"10",value,@"11",value,@"12",value,@"13",value,@"14",value,@"15",value,@"16",value,@"17",value,@"18",value,@"19",value,@"20",value,@"21",value,@"22",value,@"23",value,@"24",value,@"25",value,@"26",value,@"27",value,@"28",value,@"29",value,@"30",value,@"31",value,@"32",value,@"33",value,@"34",value,@"35",value,@"36",value,@"37",value,@"38",@"14",@"100",nil];
        [dicSubjectPager writeToFile: [self getSubjectPagerPath ] atomically:YES];
    }
}

-(void)loadFavor
{
    NSString *path=[self getFavorPath ];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path])
    {
        arrFavor = [NSMutableArray arrayWithContentsOfFile:
                    [self getFavorPath ]];
    }
    else {
        arrFavor=[[NSMutableArray alloc]init];
        [arrFavor writeToFile: [self getFavorPath ] atomically:YES];
    }
}

-(NSString *)getSubjectPagerPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"SubjectPager.plist"];
    return filename;
}

-(NSString *)getFavorPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"Favor.plist"];
    return filename;
}

//获得导出的文件路径
-(NSString *)getOutFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


//获得WEB方式管理中web源文件保存的路径
-(NSString *)getWebServerPath
{
    NSString *newPath=[[NSBundle mainBundle] pathForResource:@"web" ofType:nil];
    return  newPath;
}


//返回ajax请求结果
-(NSString *)getAjax:(NSString *)url
{
    NSRange range = [url rangeOfString:@"?"];
    NSString *query =[url substringFromIndex:range.location+1];
    query=[query stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//URL解码
    query=[query stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];//  \转义符
    
    dbHelper=[DBHelper new];
    if (sqlite3_open([[dbHelper getDocumentsPath] UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
    }
    
    //返回所有类别
    if([query hasPrefix:@"subject=yes"])
    {
        NSString *json=@"[";
        NSString *query = @"select SubjectID,[Name] from Subject";
        sqlite3_stmt *statement;
        int result = sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil);
        if(SQLITE_OK==result)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *subjectID=[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *name=[[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
                json=[json stringByAppendingFormat:@"{SubjectID:%@,Name:\"%@\"},",subjectID,name];
                
            }
        }
        json=[json stringByAppendingString:@"]"];
        sqlite3_finalize(statement);
        
        
        if(json.length>3)
        {
            json=[json stringByReplacingOccurrencesOfString:@",]" withString:@"]"];
        }
        
        return json;
    }
    
    //返回某类别下所有标题
    if([query hasPrefix:@"showtitle=yes"])
    {
        NSArray *arr = [query componentsSeparatedByString:@"&"];
        NSString *subjectID=[[arr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"subjectid=" withString:@""];
        NSString *json=@"[";
        NSString *query = [[NSString alloc] initWithFormat:@"select ContentID,title from Content where SubjectID=%@ order by Sorting desc,ContentID asc",subjectID];
        sqlite3_stmt *statement;
        int result = sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil);
        if(SQLITE_OK==result)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *contentID=[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *title=[[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
                json=[json stringByAppendingFormat:@"{ContentID:%@,Title:\"%@\"},",contentID,title];
                
            }
        }
        json=[json stringByAppendingString:@"]"];
        sqlite3_finalize(statement);
        
        if(json.length>3)
        {
            json=[json stringByReplacingOccurrencesOfString:@",]" withString:@"]"];
        }
        
        return json;
    }
    
    //返回文章信息
    if([query hasPrefix:@"contentid="])
    {
        NSArray *arr = [query componentsSeparatedByString:@"&"];
        NSString *contentID=[[arr objectAtIndex:0] stringByReplacingOccurrencesOfString:@"contentid=" withString:@""];
        NSString *json=@"[";
        NSString *query = [[NSString alloc] initWithFormat:@"select Title,Remark from Content where ContentID=%@",contentID];
        sqlite3_stmt *statement;
        int result = sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil);
        if(SQLITE_OK==result)
        {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *title=[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *remark=[[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
                remark=[self getContentHtml:remark];
                title=[title stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
                title=[title stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                title=[title stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                json=[json stringByAppendingFormat:@"{Title:\"%@\",Remark:\"%@\"}",title,remark];
                
            }
        }
        json=[json stringByAppendingString:@"]"];
        sqlite3_finalize(statement);
        
        return json;
        
    }
    return @"";
}

-(NSString *)getContentHtml : (NSString *)content
{
    NSString *html=@"";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[{]\\d{1,6}[}]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *array = [regex matchesInString:content options:0 range:NSMakeRange(0, [content length])];
    NSMutableArray *metchers=[[NSMutableArray alloc]init];
    for (NSTextCheckingResult* b in array)
    {
        [metchers addObject:[content substringWithRange:b.range]];
    }
    //有图片
    if(metchers.count>0)
    {
        //获得所有的文字
        int length=0;
        NSMutableArray *texts=[[NSMutableArray alloc]init];
        for(int i=0;i<content.length;i++)
        {
            unichar chr = [content characterAtIndex:i];
            if(chr=='{' || i==content.length-1)
            {
                NSString *text=@"";
                if(i>length)
                    text=[content substringWithRange:NSMakeRange(length, i-length)];
                if(chr=='}' && i==content.length-1)//文章最后是"}"
                {
                    text=@"";
                }
                
                if([text hasSuffix:@"\r\n"])
                    text=[text substringToIndex:text.length-2];
                if([text hasSuffix:@"\n" ])
                    text=[text substringToIndex:text.length-1];
                if(text.length<=2)
                    text=@"";
                [texts addObject:text];
                continue;
            }
            if(chr=='}')
            {
                length=i+1;
            }
        }
        
        
        for(int i=0;i<texts.count;i++)
        {
            //显示文本
            if([[texts objectAtIndex:i] length]>1)//有文字
            {
                NSString *tmp=[texts objectAtIndex:i];
                tmp=[tmp stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
                html=[html  stringByAppendingFormat:@"<div class='text'>%@<br/></div>",tmp];
            }
            
            //显示图片
            if(metchers.count>i)
            {
                NSString *picID=[metchers objectAtIndex:i];
                picID=[picID stringByReplacingOccurrencesOfString:@"{" withString:@""];
                picID=[picID stringByReplacingOccurrencesOfString:@"}" withString:@""];
                
                html=[html stringByAppendingFormat:@"<div><img src='Data/pic_%@.db'><br/></div>",picID];
            }
        }
    }
    else { //没有图片,直接显示文本
        NSString *tmp=[content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
        html=[html stringByAppendingFormat:@"<div class='text'>%@</div>",tmp];
    }
    html=[html stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
    html=[html stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    html=[html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    html=[html stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    html=[html stringByReplacingOccurrencesOfString:@"  " withString:@"&nbsp;&nbsp;"];
    
    return html;
}


//保存购买的信息
-(void)setBuy : (NSString *) strKey
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory=[documentsDirectory stringByAppendingString:@"/key.plist"];
    
    NSDictionary *dicKey = [[NSDictionary alloc] initWithObjectsAndKeys:strKey,@"key",nil];
    [dicKey writeToFile:documentsDirectory atomically:YES];
}
//获得购买的信息
-(NSString *) getBuy
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory=[documentsDirectory stringByAppendingString:@"/key.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:documentsDirectory])
    {
        @try{
            NSDictionary *dicKey = [NSDictionary dictionaryWithContentsOfFile:documentsDirectory];
            return [dicKey objectForKey:@"key"];
        }
        @catch(NSException *ex){
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

//获得缓存的路径
-(NSString *)getCachePath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

//缓存分类的字符串
-(void)setSortCacheString : (NSString *)strJson
{
    NSString *path=[[self getCachePath] stringByAppendingString:@"/sortCache.txt"];
    [strJson writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
//获得分类缓存的字符串
-(NSString *)getSortCacheString
{
    NSString *path=[[self getCachePath] stringByAppendingString:@"/sortCache.txt"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path])
    {
        NSString *txt=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        if(txt==nil || txt.length<10)
            return @"";
        else
            return  txt;
    }
    else
        return @"";
}

-(UIColor*) colorWithRGBHexString:(NSString*)rgbColor withAlpha:(float)al{
    
    NSString *cString = rgbColor;
    //去除空格并大写
    cString = [[cString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        //返回默认颜色
        return [UIColor redColor];
    }
    if ([cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    else if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        //返回默认颜色
        return [UIColor redColor];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:al];
}
-(UIColor*) colorWithRGBHexString:(NSString*)rgbColor{
    
    NSString *cString = rgbColor;
    //去除空格并大写
    cString = [[cString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        //返回默认颜色
        return [UIColor redColor];
    }
    if ([cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    else if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        //返回默认颜色
        return [UIColor redColor];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0f];
}

- (UIImage*) getBrighterImage:(UIImage *)originalImage
{
    UIImage *brighterImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:originalImage.CGImage];
    
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:inputImage forKey:kCIInputImageKey];
    [lighten setValue:@(0.2) forKey:@"inputBrightness"];
    
    CIImage *result = [lighten valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    brighterImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return brighterImage;
}
@end
