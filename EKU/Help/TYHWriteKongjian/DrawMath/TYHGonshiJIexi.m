//
//  TYHGonshiJIexi.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/23.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import "TYHGonshiJIexi.h"
#import "oprationType.h"

@interface  TYHGonshiJIexi()

@property (nonatomic,strong) oprationType  *myoperationType;
@property (nonatomic,strong) NSMutableArray   *contentArr;

@end

@implementation TYHGonshiJIexi
- (NSMutableArray *)getJieXiArr:(NSString *)conttentString
{
    self.contentArr = [NSMutableArray array];
    
    NSMutableArray  *zhuanyiArr = [self.myoperationType getzhuanyizifu];
    NSMutableArray  *resuleArr = [self.myoperationType getZhuanYIResult];
    NSString *resultString;
    for (int i =0 ; i<resuleArr.count; i++)
    {
        NSString *zhuanyi = zhuanyiArr[i];
        NSString *result = resuleArr[i];
        resultString = [conttentString stringByReplacingOccurrencesOfString:zhuanyi withString:result];
        conttentString = resultString;
        
    }
    
    [self jiexi:conttentString withContentArr:self.contentArr];
    
    return self.contentArr;
}

//  运用递归方法解析公式
- (void)jiexi:(NSString *)discrble  withContentArr:(NSMutableArray *)contentArr
{
    if (discrble == nil) {
        return  ;
    }
    if (discrble.length == 0) {
        return  ;
    }
    
    //获取保存着标志符号的位置
    
    int  flageIndex=-1;
    
    //记录是否为斜体的标志
    int  biaozhi = -1;
    
    //查找标志位所在位置
    
    for (int  i= 0; i<discrble.length; i++)
    {
        
        unichar  flagChar = [discrble characterAtIndex:i];
        if (flagChar == '\\')
        {
            flageIndex  = i;
            break;
            
        }
        if (flagChar == '`')
        {
            biaozhi=i;
            break;
        }
        
    }
    
    //截取内容字符串
    //1.如果没有标志位则为简单的字符，直接保存绘制内容
    
    if (flageIndex == -1&&discrble.length!=0&&biaozhi==-1)
    {
        NSString  *content = discrble;
        [contentArr addObject:content];
        return;
    }
    //如果第一位不是公式符号，将内容加入数组，继续解析
    if (flageIndex>0)
    {
        NSString *mycont= [discrble substringToIndex:flageIndex];
        [contentArr addObject:mycont];
        NSString *subString = [discrble substringFromIndex:flageIndex];
        [self jiexi:subString withContentArr:contentArr];
        
    }else
    {
        if (biaozhi>0)
        {
             NSString *mycont= [discrble substringToIndex:biaozhi];
            [contentArr addObject:mycont];
             NSString *subString = [discrble substringFromIndex:biaozhi];
            [self jiexi:subString withContentArr:contentArr];
        }else
        {
            flageIndex = 0;
        }
        
    }
      
 
    // 这里是对公式内容的解析
    if (flageIndex == 0)
    {
        
        int  findFlage = -1;
        NSString  *opration;
        if (discrble.length>6)
        {
            opration = [discrble substringToIndex:6];
        }else
        {
            opration  = discrble;
        }
        
        NSMutableArray  *oprationType = [self.myoperationType getoprationType];
        for (int i = 0; i<oprationType.count; i++)
        {
            NSString  *findString = oprationType[i];
            
            if ([opration rangeOfString:findString].location != NSNotFound)
            {
                findFlage = i;
                
            }
        }
        
        //公式类型知道后解析开始解析
        //在里面没有找到公式则是转义字符
        if (findFlage == -1)
        {
            int zhuanyiFlag = -1;
            NSString  *zhuanyi;
            NSMutableArray  *zhuanyiarr = [self.myoperationType getzhuanyizifu];
            if (discrble.length>5) {
                zhuanyi = [discrble substringToIndex:5];
            }
            else
            {
                zhuanyi = discrble;
            }
            int count = (int)zhuanyiarr.count;
            for (int i = 0; i<count; i++)
            {
                NSString  *findString = zhuanyiarr[i];
                
                if ([zhuanyi rangeOfString:findString].location != NSNotFound)
                {
                    zhuanyiFlag = i;
                    break;
                }
                
            }
            if (zhuanyiFlag == -1)
            {
                NSLog(@"未定义转义符号%@",discrble);
                return ;
            }else
            {
                
                NSNumber  *myNumber = [NSNumber numberWithInt:zhuanyiFlag];
                [contentArr addObject:myNumber];
                NSString  *string = zhuanyiarr[zhuanyiFlag];
                
                NSString *subString = [discrble substringFromIndex:string.length];
                [self  jiexi:subString withContentArr:contentArr];
                
            }
            
            
            
        }else
        {
            if (findFlage  == 0)
            {
                [self gongshiTypeJiexi:findFlage withString:discrble withContArr:contentArr];
              
                
                
            }
            if (findFlage ==1) {
                [self gongshiTypeJiexi:findFlage withString:discrble withContArr:contentArr];
                
                
            }
            if (findFlage == 2)
            {
                [self gongshiTypeJiexi:findFlage withString:discrble withContArr:contentArr];
               
               
                
            }
            if (findFlage ==3)
            {
                 [self gongshiShangxiabiao:findFlage withString:discrble withContArr:contentArr];
                
            }
            if (findFlage == 4)
            {
                unichar flagChar = [discrble characterAtIndex:5];
                if (flagChar == 'o')
                {
                    findFlage = 5;
                }
                [self gongshiTypeJiexi:findFlage withString:discrble withContArr:contentArr];
                
            }
            if (findFlage == 6)
            {
                
                [self gonshiTypeJiexigenshi:findFlage withString:discrble withContArr:contentArr];
            }
            if (findFlage == 7) {
                [self gonshiTypeJieximutable:findFlage withString:discrble withContArr:contentArr];
            }
            if (findFlage == 8)
            {
                [self gongshiTypeJiexi:findFlage withString:discrble withContArr:contentArr];
                
            }
            if (findFlage == 9) {
                [self gongshiTypeJiexi:findFlage withString:discrble withContArr:contentArr];
            }
            if (findFlage == 10) {
                [self gongshiTypeJiexiThreeCanshu:findFlage withString:discrble withContArr:contentArr];
            }
            if (findFlage == 11) {
                [self gongshiTypeJiexi:findFlage withString:discrble withContArr:contentArr];
                
            }
            if (findFlage == 12) {
                [self gongshiTypeJiexiOne:findFlage withString:discrble withContArr:contentArr];
            }
            if (findFlage == 13) {
                [self gongshiTypeJiexiOne:findFlage withString:discrble withContArr:contentArr];
                
            }
            if (findFlage == 14) {
                [self gongshiTypeJiexiOne:findFlage withString:discrble withContArr:contentArr];
            }
            if (findFlage == 15) {
                [self gongshiTypeJiexi:findFlage withString:discrble withContArr:contentArr];
            }
            if (findFlage == 16)
            {
                [self jiXieXieti:findFlage withString:discrble withContArr:contentArr];
            }
            if (findFlage == 17)
            {
                [self gonshiTypeJiexibiaoGe:findFlage withString:discrble withContArr:contentArr];
            }
            
            
        }
        
        
        
    }
    
    
    
}
- (void)jiXieXieti:(int )findFlage withString:(NSString *)discrble withContArr:(NSMutableArray *)contentArr
{
    NSMutableArray *xietiArr= [NSMutableArray array];
    [xietiArr addObject:[NSNumber numberWithInt:findFlage]];
    NSString *xieTiString = [discrble substringWithRange:NSMakeRange(1, 1)];
    [xietiArr addObject:xieTiString];
    NSString *contilieSring = [discrble substringFromIndex:2];
    [contentArr addObject:xietiArr];
    [self jiexi:contilieSring withContentArr:contentArr];
    
}

- (void )gongshiShangxiabiao:(int )findFlage withString:(NSString *)discrble withContArr:(NSMutableArray *)contentArr
{
    NSMutableArray *gonshiArr = [NSMutableArray array];
    NSNumber  *gonshiType = [NSNumber numberWithInt:findFlage];
    [gonshiArr addObject:gonshiType];
    
    NSString *oprartin = self.myoperationType.getoprationType[findFlage];
    
    NSString *subString1 = [discrble substringFromIndex:oprartin.length];
    NSMutableArray  *mycontentarr = [NSMutableArray array];
    NSString *LeftcontString = [self jiequCont:subString1 withArr:mycontentarr];
    if (mycontentarr.count>0)
    {
        subString1 = [subString1 substringFromIndex:((NSString *)mycontentarr[0]).length];
    }
 
    NSMutableArray *leftContent = [NSMutableArray array];
    [self jiexi:LeftcontString withContentArr:leftContent];
    NSString *subString2 = [subString1 substringFromIndex:LeftcontString.length+2];
    NSMutableArray *rightContent = [NSMutableArray array];
    NSString *rightContString  = [self jiequCont:subString2];
    [self jiexi:rightContString withContentArr:rightContent];
    
    [gonshiArr addObject:mycontentarr];
    [gonshiArr addObject:leftContent];
    [gonshiArr addObject:rightContent];
    
    [contentArr addObject:gonshiArr];
    NSString  *continuString = [subString2 substringFromIndex:rightContString.length+2];
    [self jiexi:continuString withContentArr:contentArr];
}

//按照公式类型解析公式的方法
- (void)gongshiTypeJiexiOne:(int )findFlage withString:(NSString *)discrble withContArr:(NSMutableArray *)contentArr
{
    // 首先获取公式类型，
    NSMutableArray *gonshiArr = [NSMutableArray array];
    NSNumber  *gonshiType = [NSNumber numberWithInt:findFlage];
    [gonshiArr addObject:gonshiType];
    
    //解析第一个参数
    NSString *oprartin = self.myoperationType.getoprationType[findFlage];
    NSString *subString1 = [discrble substringFromIndex:oprartin.length];
    NSString *LeftcontString = [self jiequCont:subString1];
    
    NSMutableArray *leftArr = [NSMutableArray array];
    
    //对参数进行递归解析，可能参数是公式
    [self jiexi:LeftcontString withContentArr:leftArr];
    [gonshiArr addObject:leftArr];
    
    //将所有公式解析出来的数据加入当前数据中
    [contentArr addObject:gonshiArr];
    
    //对当前公式解析完成后继续解析
    NSString  *continuString = [subString1 substringFromIndex:LeftcontString.length+2];
    [self jiexi:continuString withContentArr: contentArr];
    
}

- (NSString *)jiequCont:(NSString *)discrble withArr:(NSMutableArray *)contentArr
{
    
    int starflg = 0;
    int endFalg = 0;
    int endIndex= -1;
    int  starIndex = -1;
    for(int i = 0; i<discrble.length;i++)
    {
        unichar  mychar = [discrble characterAtIndex:i];
        
        if (mychar == '{')
        {
            if (starflg==0)
            {
                starIndex  = i;
            }
            
            starflg  ++;
            
        }
        if (mychar == '}')
        {
            endFalg ++;
            if (endFalg ==starflg) {
                endIndex = i;
                break;
                
            }
            
        }
    }

    NSString *mysubString = [discrble substringWithRange:NSMakeRange(starIndex+1,endIndex-starIndex-1)];
    
    if (starIndex>0)
    {
        NSString *cotentString = [discrble substringToIndex:starIndex];
        [self jiexi:cotentString withContentArr:contentArr];
        
    }
    return mysubString;
}

//- (NSMutableArray *)jiequShangxiabiao:(NSString *)dicrible
//{
//    
//    
//}
- (NSString *)jiequCont:(NSString *)discrble
{
    int starflg = 0;
    int endFalg = 0;
    int endIndex= -1;
    int  starIndex = -1;
    for(int i = 0; i<discrble.length;i++)
    {
        unichar  mychar = [discrble characterAtIndex:i];
        
        if (mychar == '{')
        {
            if (starflg==0)
            {
                starIndex  = i;
            }
            
            starflg  ++;
            
        }
        if (mychar == '}')
        {
            endFalg ++;
            if (endFalg ==starflg) {
                endIndex = i;
                break;
            }
            
        }
    }
    NSString *mysubString = [discrble substringWithRange:NSMakeRange(starIndex+1,endIndex-starIndex-1)];
    return mysubString;
    
}

- (void)gonshiTypeJiexigenshi:(int )findFlage withString:(NSString *)discrble withContArr:(NSMutableArray *)contentArr
{
    NSMutableArray *gonshiArr = [NSMutableArray array];
    NSNumber  *gonshiType = [NSNumber numberWithInt:findFlage];
    [gonshiArr addObject:gonshiType];
    
    NSString *oprartin = self.myoperationType.getoprationType[findFlage];
    NSString *subString1 = [discrble substringFromIndex:oprartin.length];
    if ([subString1 characterAtIndex:0]!='[')
    {
        NSString *LeftcontString = [self jiequCont:subString1];
        NSMutableArray  *leftContent = [NSMutableArray array];
        [self jiexi:LeftcontString withContentArr:leftContent];
        [gonshiArr addObject:leftContent];
        [contentArr addObject:gonshiArr];
        NSString *continuString = [subString1 substringFromIndex:LeftcontString.length+2];
        [self jiexi:continuString withContentArr:contentArr];
        
    }
    else
    {
        NSRange  subRang = [subString1 rangeOfString:@"]"];
        NSString  *subString2  = [subString1 substringWithRange:NSMakeRange(1, subRang.location-1)];
        NSMutableArray *gengShiContent = [NSMutableArray array];
        [self jiexi:subString2 withContentArr:gengShiContent];
        
        subString2 = [subString1 substringFromIndex:subRang.location+1];
        NSString *mysubString = [self jiequCont:subString2];
        NSMutableArray  *contentarr = [NSMutableArray array];
        [self jiexi:mysubString withContentArr:contentarr];
        NSString  *mysubtingto = [subString2 substringFromIndex:mysubString.length+2];
        
        [gonshiArr addObject:gengShiContent];
        [gonshiArr addObject:contentarr];
        [contentArr addObject:gonshiArr];
        
        [self jiexi:mysubtingto withContentArr:contentArr];
        
    }
    
    
}

- (void )gongshiTypeJiexi:(int )findFlage withString:(NSString *)discrble withContArr:(NSMutableArray *)contentArr
{
    // 首先获取公式类型，
    NSMutableArray *gonshiArr = [NSMutableArray array];
    NSNumber  *gonshiType = [NSNumber numberWithInt:findFlage];
    [gonshiArr addObject:gonshiType];
    
    
    //解析第一个参数
    NSString *oprartin = self.myoperationType.getoprationType[findFlage];
    NSString *subString1 = [discrble substringFromIndex:oprartin.length];
    NSString *LeftcontString = [self jiequCont:subString1];
    
    NSMutableArray  *canshuOne = [NSMutableArray array];
    
    //对参数进行递归解析，可能参数是公式
    [self jiexi:LeftcontString withContentArr:canshuOne];
    
    //解析第二个参数
    NSRange   myRange = [subString1 rangeOfString:LeftcontString];
    NSString *subString2 = [subString1 substringFromIndex:(myRange.location+myRange.length)+1];
    NSString *rightContString  = [self jiequCont:subString2];
    
    NSMutableArray  *canshuTwo = [NSMutableArray array];
    
    [self jiexi:rightContString withContentArr:canshuTwo];
    
    //将所有公式解析出来的数据加入当前数据中
    [gonshiArr addObject:canshuOne];
    [gonshiArr addObject:canshuTwo];
    [contentArr addObject:gonshiArr];
    
    
    //对当前公式解析完成后继续解析
    NSString  *continuString = [subString2 substringFromIndex:rightContString.length+2];
    [self jiexi:continuString withContentArr:contentArr];
}

- (void )gongshiTypeJiexiThreeCanshu:(int )findFlage withString:(NSString *)discrble withContArr:(NSMutableArray *)contentArr
{
    NSMutableArray *gonshiArr = [NSMutableArray array];
    NSNumber  *gonshiType = [NSNumber numberWithInt:findFlage];
    [gonshiArr addObject:gonshiType];
    
    NSString *oprartin = self.myoperationType.getoprationType[findFlage];
    
    NSString *subString1 = [discrble substringFromIndex:oprartin.length];
    NSString *LeftcontString = [self jiequCont:subString1];
    NSMutableArray *leftContent = [NSMutableArray array];
    [self jiexi:LeftcontString withContentArr:leftContent];
    
    NSString *subString2 = [subString1 substringFromIndex:LeftcontString.length+2];
    NSString *rightContString  = [self jiequCont:subString2];
    NSMutableArray *rightContent = [NSMutableArray array];
    [self jiexi:rightContString withContentArr:rightContent];
    
    
    NSString *subString3  = [subString2 substringFromIndex:rightContString.length+2];
    NSString *lastString = [self jiequCont:subString3];
    NSMutableArray *lastContet = [NSMutableArray array];
    [self jiexi:lastString withContentArr:lastContet];
    
    [gonshiArr addObject:leftContent];
    [gonshiArr addObject:rightContent];
    [gonshiArr addObject:lastContet];
    [contentArr addObject:gonshiArr];
    NSString  *continuString = [subString3 substringFromIndex:lastString.length+2];
    [self jiexi:continuString withContentArr:contentArr];
}
- (void)gonshiTypeJieximutable:(int )findFlage withString:(NSString *)discrble withContArr:(NSMutableArray *)contentArr
{
    NSMutableArray *gonshiArr = [NSMutableArray array];
    NSNumber  *gonshiType = [NSNumber numberWithInt:findFlage];
    [gonshiArr addObject:gonshiType];
    
    NSString *oprartin = self.myoperationType.getoprationType[findFlage];
    NSString *subString1 = [discrble substringFromIndex:oprartin.length];
    NSRange  myRange = [subString1 rangeOfString:@"{"];
    NSString *conut = [subString1 substringToIndex:myRange.location];
    NSString *subString2= [subString1 substringFromIndex:conut.length];
    int  count = [conut intValue];
    [gonshiArr addObject:[[NSNumber alloc] initWithInt:count]];
    for (int i = 0; i<count; i++)
    {
        
        NSString *LeftcontString = [self jiequCont:subString2];
        NSMutableArray  *leftContent = [NSMutableArray array];
    
        [self jiexi:LeftcontString withContentArr:leftContent];
        [gonshiArr addObject:leftContent];
        subString2 = [subString2 substringFromIndex:LeftcontString.length+2];
        
        
    }
    [contentArr addObject:gonshiArr];
    [self jiexi:subString2 withContentArr:contentArr];
    
}

- (void)gonshiTypeJiexibiaoGe:(int )findFlage withString:(NSString *)discrble withContArr:(NSMutableArray *)contentArr
{
    NSMutableArray *gonshiArr = [NSMutableArray array];
    NSNumber  *gonshiType = [NSNumber numberWithInt:findFlage];
    [gonshiArr addObject:gonshiType];
    
    NSString *oprartin = self.myoperationType.getoprationType[findFlage];
    NSString *subString1 = [discrble substringFromIndex:oprartin.length];
    NSRange  myRange = [subString1 rangeOfString:@"{"];
    NSString *conut = [subString1 substringToIndex:myRange.location];
    NSString *subString2= [subString1 substringFromIndex:conut.length];
    int  count = [conut intValue];
    [gonshiArr addObject:[[NSNumber alloc] initWithInt:count]];
    for (int i = 0; i<count+1; i++)
    {
        
             NSString *LeftcontString = [self jiequCont:subString2];
             subString2 = [subString2 substringFromIndex:LeftcontString.length+2];
            
            if (i>1)
            {
                NSMutableArray  *arr = [NSMutableArray array];
                for (int j = 0; j<100; j++)
                {
                    NSMutableArray  *canSHuarr = [NSMutableArray array];
                    NSString *leftstring = [self jiequCont:LeftcontString];
                    [self jiexi:leftstring withContentArr:canSHuarr];
                    LeftcontString = [LeftcontString substringFromIndex:leftstring.length+2];
                     [arr addObject:canSHuarr];
                    if ([LeftcontString isEqualToString:@""]) {
                        break;
                    }
                   
                }
                [gonshiArr addObject:arr];
                
            }else
            {
                NSMutableArray  *mycontentArr = [self huoqueCanshu:LeftcontString];
                
                [gonshiArr addObject:mycontentArr];
              
            }
       
        
    }
    [contentArr addObject:gonshiArr];
    [self jiexi:subString2 withContentArr:contentArr];
    
}

- (NSMutableArray  *)huoqueCanshu:(NSString *)contentString
{
    NSMutableArray *contetnarr = [NSMutableArray array];
    
    for (int i=0; i<contentString.length; i++)
    {
        unichar flagchar = [contentString characterAtIndex:i];
        if (flagchar == ',')
        {
            [contetnarr addObject:[contentString substringToIndex:i]];
            contentString = [contentString substringFromIndex:i+1];
            i=0;
        }
    }
    [contetnarr addObject:contentString];
    return  contetnarr;
    
}



- (oprationType*)myoperationType
{
    
    if (_myoperationType == nil)
    {
        _myoperationType  = [oprationType sharedOprationType];
    }
    return _myoperationType;
}


@end
