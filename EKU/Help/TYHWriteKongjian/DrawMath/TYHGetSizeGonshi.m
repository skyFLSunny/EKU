//
//  TYHGetSizeGonshi.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/23.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import "TYHGetSizeGonshi.h"
#import "NSString+LW.h"
#import "TYHDrawMathManger.h"
#import "oprationType.h"


#define  fontWithFlag  flag==0?self.manger.textFont:self.manger.smallTextFont

#define  sizemakebig  CGSizeMake(MAXFLOAT, MAXFLOAT)

@interface TYHGetSizeGonshi ()

@property (nonatomic,strong)TYHDrawMathManger *manger;

@property (nonatomic,strong)oprationType  *operationType;

//这个事记录上一次参数的高度，
@property (nonatomic,assign)CGFloat  heitht;


@end
@implementation TYHGetSizeGonshi

- (CGSize)getGongshiSize:(NSMutableArray *)contentArr  withFlag:(int)flag with:(CanJiXianClass *)JixianModel
{
    _contentArr = contentArr;
    CGSize gongshiSize;
    
    int type = [contentArr[0] intValue];
    
    switch (type) {
        case 0:
            gongshiSize = [self getFenshiSizeWithContArr:contentArr withFlag:flag with:JixianModel];
            break;
        case 1:
            gongshiSize = [self getShangXiaoBiaoSize:contentArr withFlag:flag with:JixianModel];
            break;
        case 2:
            gongshiSize = [self getxiaoSize:contentArr withFlag:flag with:JixianModel];
            break;
        case  3:
            gongshiSize = [self getSizeShangxiathree:contentArr withFlag:flag with:JixianModel];
            break;
        case 4:
            gongshiSize = [self getsizeSum:contentArr withFlag:1 with:JixianModel];
            break;
        case 5:
            gongshiSize =  [self getqiuheSumright:contentArr withFlag:1 with:JixianModel];
            break;
        case 6:
            gongshiSize = [self getgengshiSize:contentArr withFlag:flag with:JixianModel];
            break;
        case 7:
            gongshiSize = [self getfangchengshi:contentArr withFlag:flag with:JixianModel];
            break;
        case  8:
            gongshiSize = [self getshangxian:contentArr withFlag:flag with:JixianModel];
            break;
        case 9:
            gongshiSize = [self getXiaxianSize:contentArr withFlag:flag with:JixianModel];
            break;
        case 10:
            gongshiSize = [self getShangxiaXIanSize:contentArr withFlag:flag with:JixianModel];
            break;
        case 11:
            gongshiSize = [self  getJiantouSize:contentArr withFlag:flag with:JixianModel];
            break;
        case 12:
            gongshiSize = [self getShanchuXianSize:contentArr withFlag:flag];
            break;
        case 13:
            gongshiSize = [self getShanchuXianSize:contentArr withFlag:flag];
            break;
        case 14:
            gongshiSize = [self getShanchuXianSize:contentArr withFlag:flag];
            break;
        case 15:
            gongshiSize = [self getxuanzhuanSize:contentArr withFlag:flag];
            break;
        case 16:
            gongshiSize = [self getxieTiSize:contentArr withFlag:flag];
            break;
        case 17:
             gongshiSize =[self getBiaogeSize:contentArr withFlag:flag];
            break;
            
        default:
            NSLog(@"计算尺寸时没有找到%d类型",type);
            gongshiSize =CGSizeMake(0, 0);
            break;
    }
    
    return  gongshiSize;
    
}

- (CGSize)getBiaogeSize:(NSMutableArray *)contentArr withFlag:(int)flag
{
    CGFloat  baseWith = [@"a" sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    CGFloat  width = 0;
    
    NSMutableArray  *widtharr = contentArr[2];
    NSInteger  count = widtharr.count;
    for (NSInteger i=0; i<count; i++)
    {
        width += ([widtharr[i] floatValue]*(self.manger.baseWidth/baseWith));
    }
    
    CGFloat  heiht = 0;
    
    NSMutableArray  *headContent = contentArr[3];
    
    CGSize  headSize = [self getCanshuSize:headContent withFlag:flag];
    heiht += headSize.height;
    
    NSInteger canshucount = contentArr.count-4;
    for (int  i = 0; i<canshucount; i++)
    {
        NSMutableArray *canShuArr = contentArr[i+4];
        CGSize  canshuSize  = [self getbiaoGeCanshuSize:canShuArr withFlag:flag];

        heiht += canshuSize.height;
    }
    
    return CGSizeMake(width, heiht);
}


- (CGSize)getxieTiSize:(NSMutableArray *)contentArr withFlag:(int)flag
{
    NSString *xieTisring = contentArr[1];
    CGSize  gonshiSize = [xieTisring sizeWithFont:fontWithFlag maxSize:sizemakebig];
    return CGSizeMake(gonshiSize.width+2, gonshiSize.height+2);
}

- (CGSize)getxuanzhuanSize:(NSMutableArray *)contentArr withFlag:(int)flag
{
    id  content = contentArr[1];
    CGSize  xuanzhuanSize  = [self getCanshuSize:content withFlag:flag];

    return CGSizeMake(xuanzhuanSize.width, xuanzhuanSize.height);
}

- (CGSize)getShangxiaXIanSize:(NSMutableArray *)contentArr withFlag:(int)flag with:(CanJiXianClass *)model
{
    
    id content1 = contentArr[1];
    id content2 = contentArr[2];
    id content3 = contentArr[3];
    
    CGSize  contentSize1 = [self getCanshuSize:content1 withFlag:flag];
    CGSize  contentSize2 = [self getCanshuSize:content2 withFlag:1];
    CGSize  contentSize3 = [self getCanshuSize:content3 withFlag:1];
    CGFloat  maxWindth;
    
    //计算最大的一个宽度
    CGFloat  temp = contentSize1.width>contentSize2.width ?contentSize1.width :contentSize2.width;
    maxWindth = temp>contentSize3.width ?temp :contentSize3.width;
    
    CGFloat  height = contentSize1.height+contentSize2.height+contentSize3.height;
    
    CGFloat  centry = contentSize2.height;
    if (model != NULL)
    {
        [model setHeitAndCurentJixian:height-centry andJixian:centry];
    }
    
    return CGSizeMake(maxWindth, height);
    
}

- (CGSize)getXiaxianSize:(NSMutableArray *)contentArr withFlag:(int)flag  with:(CanJiXianClass *)model
{
    id cotent1 = contentArr[1];
    CGSize  shangSize = [self getCanshuSize:cotent1 withFlag:flag];
    NSMutableArray *mycontentArr = cotent1;
    if ([mycontentArr[0] isKindOfClass:[NSMutableArray class]])
    {
        NSMutableArray *gonshiArr = mycontentArr[0];
        int flage = [gonshiArr[0] intValue];
        if (flage == 15)
        {
            int  angel = [gonshiArr[2][0] intValue];
            
            NSString *content = gonshiArr[1][0];
            if ([content isEqualToString:@"∩"])
            {
                
                if (angel == 90 ||angel == 270)
                {
                    return CGSizeMake(self.manger.baseHeigt+2, self.manger.baseHeigt/0.7);
                }
            }
            
        }
        
    }
    
    
    id content2 = contentArr[2];
    CGSize  xiaSize = [self getCanshuSize:content2 withFlag:1];
    
    CGFloat width = shangSize.width>xiaSize.width ? shangSize.width:xiaSize.width;
    CGFloat height = shangSize.height+xiaSize.height-self.manger.baseHeigt*0.3;
    if (model != nil)
    {
        [model setHeitAndCurentJixian:height andJixian:0];
    }
    return  CGSizeMake(width,height);
    
}
- (CGSize)getShanchuXianSize:(NSMutableArray *)contentArr withFlag:(int)flag
{
    id content = contentArr[1];
    CGSize  shanchuSize = [self getCanshuSize:content withFlag:flag];
    
    id gonshiArr = contentArr[1][0];
    if ([gonshiArr isKindOfClass:[NSMutableArray class]])
    {
        
        int flage = [gonshiArr[0] intValue];
        if (flage == 15)
        {
            int  angel = [gonshiArr[2][0] intValue];
            if (angel == 90 || angel == 270)
            {
                NSString *content = gonshiArr[1][0];
                if ([content isEqualToString:@"∩"])
                {
                    return CGSizeMake(self.manger.baseHeigt+2, self.manger.baseHeigt/0.8);
                }
                
            }
        }
        
    }
  
   
    return CGSizeMake(shanchuSize.width, shanchuSize.height+2);
}

- (CGSize)getJiantouSize:(NSMutableArray *)contentArr withFlag:(int)flag with:(CanJiXianClass *)model
{
    int  count = [contentArr[2][0] intValue];
    
    CGFloat  height = self.manger.baseHeigt/0.8;
    if (model != nil)
    {
        [model setHeitAndCurentJixian:(height-0) andJixian:0];
    }
    
    return   CGSizeMake(self.manger.baseHeigt*count,self.manger.baseHeigt/0.8);
    
}
- (CGSize)getshangxian:(NSMutableArray *)contentArr withFlag:(int)flag with:(CanJiXianClass *)model
{
    id content1 = contentArr[1];
    id content2 = contentArr[2];
    CGSize xiaSize = [self getCanshuSize:content1 withFlag:flag] ;
    CGSize shangsize = [self getCanshuSize:content2 withFlag:1] ;
    
    CGFloat  windth = shangsize.width>xiaSize.width ? shangsize.width :xiaSize.width;
    
    CGFloat  height = shangsize.height-self.manger.baseHeigt*0.4+xiaSize.height;
    
    CGFloat centery = shangsize.height-self.manger.baseHeigt*0.5;
    
    if (model != nil)
    {
        [model setHeitAndCurentJixian:(height-centery) andJixian:centery];
    }
    return CGSizeMake(windth, shangsize.height-self.manger.baseHeigt*0.4+xiaSize.height);
    
}


- (CGSize)getfangchengshi:(NSMutableArray *)contentArr withFlag:(int)flag with:(CanJiXianClass *)model
{
    
    CGSize  gonshiSzie= CGSizeMake(0, 0);
    CGSize  tempSzie;
    int  conunt = [contentArr[1] intValue];
    for (int i = 2; i<conunt+2; i++)
    {
        id content  = contentArr[i];
        
        tempSzie = [self getCanshuSize:content withFlag:flag];
        gonshiSzie.height+= tempSzie.height;
        gonshiSzie.width = (tempSzie.width+6)>gonshiSzie.width ? (tempSzie.width+6):gonshiSzie.width;
        
    }
    gonshiSzie.width+=3;
    
    CGFloat centry = gonshiSzie.height/2-self.manger.baseHeigt*0.7;
    
    if (model != nil)
    {
        [model setHeitAndCurentJixian:(gonshiSzie.height-centry) andJixian:centry];
    }
    return gonshiSzie;
    
}
- (CGSize)getgengshiSize:(NSMutableArray *)contentArr withFlag:(int)flag with:(CanJiXianClass *)model
{
    id content1 = contentArr[1];
    if (contentArr.count>2)
    {
        CGSize leftSize  = [self getCanshuSize:content1 withFlag:1];
        
        id  content2 = contentArr[2];
        CGSize genshixiaSize = [self getCanshuSize:content2 withFlag:flag];
        CGFloat height = leftSize.height>genshixiaSize.height ?leftSize.height:genshixiaSize.height;
        height += self.manger.baseHeigt*0.3;
        CGFloat  centery = height-self.manger.baseHeigt/0.7;
        if (centery <0)
        {
            centery = 0;
        }
        if (model != nil)
        {
            [model setHeitAndCurentJixian:(height - centery) andJixian:centery];
        }
        return  CGSizeMake(leftSize.width+self.manger.baseHeigt*0.5+genshixiaSize.width,height);

    }
    
    CGSize contentSize = [self getCanshuSize:content1 withFlag:flag];
    
    CGFloat  heith = contentSize.height +self.manger.baseHeigt*0.3;
    
    CGFloat  centery = heith-self.manger.baseHeigt/0.7;
    
    if (model != nil)
    {
        [model setHeitAndCurentJixian:(heith - centery) andJixian:centery];
    }
    
    return  CGSizeMake(contentSize.width+self.manger.baseHeigt*0.8, heith);
    
  
}
- (CGSize)getqiuheSumright:(NSMutableArray *)contentArr withFlag:(int)flag with:(CanJiXianClass *)model
{
    id content1 = contentArr[1];
    CGSize  shangsize ;
    CGSize  xiasize;

    shangsize = [self getCanshuSize:content1 withFlag:1];
    id content2 = contentArr[2];
    xiasize  = [self getCanshuSize:content2 withFlag:1];
    
    CGFloat sumWidth = self.manger.baseHeigt;
    
    CGFloat contentwidth = shangsize.width>xiasize.width ? shangsize.width:xiasize.width;
    
    
    CGFloat  width = sumWidth + contentwidth;
    CGFloat  height = shangsize.height-self.manger.baseHeigt+xiasize.height+sumWidth;
    
    CGFloat centery = shangsize.height-self.manger.baseHeigt*0.6;
    
    if (model != nil)
    {
        [model setHeitAndCurentJixian:(height - centery) andJixian:centery];
    }
    
    return CGSizeMake(width, height);
    
}
- (CGSize)getsizeSum:(NSMutableArray *)contentArr withFlag:(int)flag   with:(CanJiXianClass *)model
{
    id content = contentArr[1];
    CGSize shangSize = [self getCanshuSize:content withFlag:1];
    
    id contet1 = contentArr[2];
    CGSize xiaSize = [self getCanshuSize:contet1 withFlag:1];
   
    CGFloat  contentWidth  = shangSize.width>xiaSize.width ? shangSize.width :xiaSize.width;
    CGFloat  width  =  contentWidth>self.manger.baseHeigt ? contentWidth :self.manger.baseHeigt;
    
    CGFloat height =  shangSize.height+xiaSize.height+self.manger.baseHeigt;
    
    CGFloat centy = shangSize.height - [self getBaseHeitWihtFlag:flag]*0.2;
    
    if (model != nil)
    {
        [model setHeitAndCurentJixian:(height - centy) andJixian:centy];
    }
    return CGSizeMake(width+3 , height);
    
}
- (CGSize)getSizeShangxiathree:(NSMutableArray *)contentArr withFlag:(int)flag  with:(CanJiXianClass *)model
{
    
    id content = contentArr[1];
    CGSize contentSize = [self getCanshuSize:content withFlag:flag];
    
    id  shangContent = contentArr[2];
    CGSize ShangSize = [self getCanshuSize:shangContent withFlag:1];
    
    id  xiaContent = contentArr[3];
    CGSize xiaSize = [self getCanshuSize:xiaContent withFlag:1];
    
    CGFloat centy = ShangSize.height -[self getBaseHeitWihtFlag:flag]*0.3;
   
    CGFloat  rigthWithd =  (ShangSize.width>xiaSize.width ? ShangSize.width :xiaSize.width);
    CGFloat  width = contentSize.width +rigthWithd;
    CGFloat  heigt;
   
    heigt  = ShangSize.height+xiaSize.height*0.6+contentSize.height*0.6;
    
    if (model !=nil)
    {
        [model setHeitAndCurentJixian:heigt-centy andJixian:centy];
    }
    
    return CGSizeMake(width, heigt);
    
}
- (CGSize)getxiaoSize:(NSMutableArray *)contentArr withFlag:(int)flag with:(CanJiXianClass *)model
{
    
    id content = contentArr[1];
    CGSize contentSize = [self getCanshuSize:content withFlag:flag];
    
    id  content2 = contentArr[2];
    CGSize xiaSize =  [self getCanshuSize:content2 withFlag:1];
    
    CGFloat  height =  contentSize.height*0.5+xiaSize.height;
    
    if (model != nil)
    {
        [model setHeitAndCurentJixian:height andJixian:0];
    }
    
    return  CGSizeMake(contentSize.width+xiaSize.width,height);
}
- (CGSize)getShangXiaoBiaoSize:(NSMutableArray *)contentArr withFlag:(int)flag with:(CanJiXianClass *)model
{
    id  content1 = contentArr[1];
    CGSize  shangBiaoSize = [self getCanshuSize:content1 withFlag:flag];
    id  content2 = contentArr[2];
    CGSize  xiaBiaoSize = [self getCanshuSize:content2 withFlag:1];
  
    CGFloat  Width = shangBiaoSize.width+xiaBiaoSize.width;
    CGFloat height = shangBiaoSize.height+xiaBiaoSize.height*0.5;
    CGFloat  centY;
    
    //这里做了更改
    if (flag == 1)
    {
        centY = height- self.manger.baseHeigt;
    }else
    {
        centY = height- self.manger.baseHeigt/0.8;
    }
   
    if (model != nil)
    {
        [model setHeitAndCurentJixian:height-centY andJixian:centY];
    }
    return  CGSizeMake(Width, height);
}


- (CGSize)getFenshiSizeWithContArr:(NSMutableArray *)contentArr withFlag:(int)flag with:(CanJiXianClass *)model
{
    id   fenzhi = contentArr[1];
    CGSize fenziSize = [self  getCanshuSize:fenzhi withFlag:flag];

    id   fenMu = contentArr[2];
    CGSize fenmuSize = [self getCanshuSize:fenMu withFlag:flag];
    CGFloat fenshiWidth ;
    if (fenmuSize.width>fenziSize.width)
    {
        fenshiWidth = fenmuSize.width;
    }else
    {
        fenshiWidth = fenziSize.width;
    }
    
    CGFloat  drawy = fenziSize.height-self.manger.baseHeigt*0.4;
    
    //这里定义了分子线的一个高度4
    CGFloat fenshiHeight = fenziSize.height+fenmuSize.height+1;
    
    fenziSize= CGSizeMake(fenshiWidth,fenshiHeight);
    if (model !=nil)
    {
        [model setHeitAndCurentJixian:fenshiHeight -drawy andJixian:drawy];
    }

    
    return fenziSize;
    
}

- (CGSize)getCanshuSize:(NSMutableArray *)contentArr withFlag:(int)flag
{
    //参数的宽度
    CGFloat  windth = 0;
    CGFloat  height = 0;
    CGFloat  jianxi = self.manger.baseHeigt*0.1;
    for (NSInteger i =0; i<contentArr.count; i++)
    {
        id  content = contentArr[i];
        
        
        if ([content isKindOfClass:[NSString class]])
        {
           
            CGSize suSize = [self getStringSize:content withFlage:flag];

            windth += (suSize.width+jianxi);
            if (height<suSize.height)
            {
                height = suSize.height;
            }
            
        }else
        {
            CGSize suSize = [self getGongshiSize:content withFlag:flag with:nil];
            windth +=(suSize.width+jianxi);
            if (height<suSize.height) {
                height = suSize.height;
            }
        }
    }
    return CGSizeMake(windth, height);
    
}


- (CGSize)getStringSize:(NSString *)conentString  withFlage:(int)flag
{
    if (self.manger.mathFlag !=1)
    {
        return  [conentString sizeWithFont:fontWithFlag maxSize:sizemakebig];
    }
    else
    {
        
        NSAttributedString *mystring = [self getAtrtrButiStringWith:conentString withFont:fontWithFlag];
        
        CGSize  mysize   =  mystring.size;
        
        return CGSizeMake(mysize.width, mysize.height);
    }
}

- (CGSize)getbiaoGeCanshuSize:(NSMutableArray *)contentArr  withFlag:(int)flag
{
    CGFloat  width = 0;
    CGFloat  heigt = 0;
    
    for (NSInteger i= 0; i<contentArr.count; i++)
    {
        CGSize  canshuSize = [self getCanshuSize:contentArr[i] withFlag:flag];
        if (heigt<canshuSize.height)
        {
            heigt  = canshuSize.height;
        }
        width += (canshuSize.width);
        
    }
    
    return  CGSizeMake(width, heigt);
}

- (NSAttributedString *)getAtrtrButiStringWith:(NSString *)contentString  withFont:(UIFont *)font
{
    CGFloat  fontPoint = font.pointSize;
    NSMutableAttributedString  *mystring = [[NSMutableAttributedString alloc] initWithString:contentString attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:self.manger.textColor,NSKernAttributeName :@(1.0f)}];
    NSMutableArray  *xieTiarr = [self.operationType getxieTieArr];
    
    for (int i = 0; i<contentString.length; i++)
    {
        unichar mychar = [contentString characterAtIndex:i];
        
        for (int j = 0; j<xieTiarr.count; j++)
        {
            NSString *xieti = xieTiarr[j];
            unichar xietiChar = [xieti characterAtIndex:0];
            if (mychar == xietiChar)
            {
                [mystring addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:fontPoint]  range:NSMakeRange(i, 1)];
                if (mychar=='f') {
                    [mystring addAttribute:NSKernAttributeName value:@(4.0f)  range:NSMakeRange(i, 1)];
                }
                
                
            }
            
        }
        
        
    }
    NSMutableArray  *fanXietiArr = [self.operationType getfanXietiArr];
    for (int i = 0; i<fanXietiArr.count; i++)
    {
        NSString  *fanXieti = fanXietiArr[i];
        int lenth =(int) contentString.length;
        NSRange  serchRange = NSMakeRange(0, lenth);
        while (1)
        {
            
            NSRange myrange = [contentString rangeOfString:fanXieti options:NSNumericSearch&&NSCaseInsensitiveSearch range:serchRange];
            if (myrange.location == NSNotFound)
            {
                break;
            }else
            {
                
                [mystring addAttribute:NSFontAttributeName value:self.manger.textFont  range:myrange];
                serchRange.location=(myrange.location+myrange.length);
                serchRange.length =lenth-(myrange.length+myrange.location);
            }
            
            
        }
    }
    
    return  mystring;
}


- (TYHDrawMathManger *)manger
{
    if (_manger == nil) {
        _manger = [TYHDrawMathManger shareTYHDrawMathManger];
    }
    return _manger;
}
- (oprationType *)operationType
{
    if (_operationType == nil) {
        _operationType = [oprationType sharedOprationType];
    }
    return _operationType;
}

- (CGFloat)getBaseHeitWihtFlag:(int)flag
{
    return  [@"a" sizeWithFont:fontWithFlag maxSize:sizemakebig].height;
}
@end
