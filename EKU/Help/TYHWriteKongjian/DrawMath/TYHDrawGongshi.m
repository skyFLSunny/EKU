//
//  TYHDrawGongshi.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/22.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import "TYHDrawGongshi.h"
#import "TYHDrawText.h"
#import "TYHDrawGongshiExpress.h"
#import "TYHGetSizeGonshi.h"
#import "TYHDrawMathManger.h"
#import "NSString+LW.h"


#define  fontWithFlag  flag==0?self.manger.textFont:self.manger.smallTextFont

@interface TYHDrawGongshi ()
@property (nonatomic,strong)TYHDrawText  *drawText;
@property (nonatomic,strong)TYHDrawGongshiExpress  *drawExpress;
@property (nonatomic,strong)TYHGetSizeGonshi  *gonshiSize;
@property (nonatomic,strong)UIImage  *gonshiImage;
@property (nonatomic,strong)TYHDrawMathManger  *manger;


@end

@implementation TYHDrawGongshi
+ (instancetype)TYHDrawGongshiWithString:(NSMutableArray *)contentArr
{
    return  [[TYHDrawGongshi alloc] initWithContentArr:contentArr];
}

- (id)initWithContentArr:(NSMutableArray *)contentarr
{
    if (self= [super init])
    {
        _contentArr = contentarr;
        
    }
    return self;
    
}
- (MathImageModel *)DrawGongshi
{
    CGSize  gonshiSize = [self.gonshiSize getGongshiSize:self.contentArr withFlag:0 with:NULL];
    
    UIGraphicsBeginImageContextWithOptions(gonshiSize , NO, 0);
    //1.获取bitmap上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if(self.manger.backGroundClolor !=nil)
    {
        [self.manger.backGroundClolor set];
        CGContextAddRect(ctx, CGRectMake(0.0f, 0.0f, gonshiSize.width, gonshiSize.height));
        CGContextFillPath(ctx);
        
    }
    //2.绘图
    
    CGFloat  yzuoBiao = [self dracGonshiWithArr:self.contentArr withContext:ctx with:CGRectMake(0, 0, gonshiSize.width, gonshiSize.height) withFlag:0];
    
    //4.获取生成的图片
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    self.gonshiImage = image ;
    MathImageModel *mathModel = [MathImageModel MathImageModelWith:image WithDarwY:yzuoBiao];
    return mathModel;
    
}



- (CGFloat)dracGonshiWithArr:(NSMutableArray *)arr withContext:(CGContextRef )ctx  with:(CGRect)rect withFlag:(int)flag;
{
    
    int  type = [arr[0] intValue];
    CGFloat  yZuobiao = -1;
    CGFloat  curentY = 0;
    switch (type) {
        case 0:
            curentY =[self huaFenshi:ctx witharr:arr withRect:rect withFlag:flag];
            if (yZuobiao == -1)
            {
                yZuobiao = curentY;
            }
            break;
        case 1:
            curentY =[self huaShangxiaBiao:ctx withArr:arr withRect:rect withFlag:flag];
            if (yZuobiao == -1)
            {
                yZuobiao = curentY;
            }
            break;
        case 2:
           curentY =  [self huaxiaBiao:ctx withArr:arr withRect:rect withFlag:flag];
            if (yZuobiao == -1)
            {
                yZuobiao = curentY;
            }
            break;
        case 3:
            curentY = [self huashangxiabiaothree:ctx withArr:arr withRect:rect withFlag:flag];
            if (yZuobiao == -1)
            {
                yZuobiao = curentY;
            }
            break;
        case 4:
            curentY =[self huaqiuhe:ctx withArr:arr withRect:rect withFlag:1];
            if (yZuobiao == -1)
            {
                yZuobiao = curentY;
            }
            break;
        case 5:
            curentY = [self huaqiuheright:ctx withArr:arr withRect:rect withFlag:1];
            if (yZuobiao == -1) {
                
                yZuobiao = curentY;
            }
            break;
        case 6:
            curentY =[self huagengshi:ctx withArr:arr withRect:rect withFlag:flag];
            if (yZuobiao == -1) {
                
                yZuobiao = curentY;
            }
            break;
        case 7:
            curentY =[self huafengchengshi:ctx withArr:arr withRect:rect withFlag:flag];
            if (yZuobiao == -1)
            {
                yZuobiao = curentY;
            }
            break;
        case 8:
            curentY = [self huashangxian:ctx withArr:arr withRect:rect withFlag:flag];
            if (yZuobiao == -1)
            {
                yZuobiao = curentY;
            }
            break;
        case 9:
            curentY = [self huaXiaxianwith:ctx withArr:arr withRect:rect withFlag:flag];
            if (yZuobiao == -1)
            {
                yZuobiao = curentY;
            }
            break;
        case 10:
            curentY = [self huaShangxiaXianWith:ctx withArr:arr withRect:rect withFlag:flag];
            if (yZuobiao == -1)
            {
                yZuobiao = curentY;
            }
            break;
        case 11:
            [self  huaJiantou:ctx withArr:arr withRect:rect withFlag:flag];
            break;
        case 12:
            [self  huaShanchuxian:ctx withArr:arr withRect:rect withFlag:flag];
            break;
        case 13:
            [self  huaxieXian:ctx withArr:arr withRect:rect withFlag:flag];
            break;
        case 14:
            [self  huaXiahuaXian:ctx withArr:arr withRect:rect withFlag:flag];
            break;
        case 15:
            [self huaXuanzhuan:ctx withArr:arr withRect:rect withFlag:flag];
            break;
        case 16:
            [self huaXieTizi:ctx withArr:arr withRect:rect withFlag:flag];
            break;
        case 17:
            [self huaBiaoge:ctx withArr:arr withRect:rect withFlag:flag];
            break;
        default:
            break;
    }
    if (yZuobiao == -1) {
        return  0;
    }
    return  yZuobiao;
    
}

- (void)huaBiaoge:(CGContextRef)ctx  withArr:(NSMutableArray*)arr withRect:(CGRect)rect withFlag:(int)flag
{
    NSMutableArray  *heigtArr = [NSMutableArray array];
    
    int  count = [arr[1] intValue];
    NSMutableArray  *widtharr = arr[2];
    CGFloat  startRecty = rect.origin.y;
    for ( int i=0; i<count; i++)
    {
        CGSize canshuSize;
        if (i==0)
        {
            canshuSize = [self.gonshiSize getCanshuSize:arr[i+3] withFlag:flag];
        }else
        {
            canshuSize = [self.gonshiSize getbiaoGeCanshuSize:arr[i+3] withFlag:flag];
        }
       
       
        [self drawBiaoCanShu:widtharr withArr:arr[i+3] withRect:CGRectMake(rect.origin.x+3, rect.origin.y, canshuSize.width, canshuSize.height) withFlag:flag withcontent:ctx];
        rect.origin.y += canshuSize.height;
        [heigtArr addObject:[NSNumber numberWithFloat:canshuSize.height]];
    }
    rect.origin.y = startRecty;
    [self.drawExpress drawBiaoge:ctx withRect:rect withHeigtArr:heigtArr withWindthArr:widtharr];

    
    
}


- (void)huaXieTizi:(CGContextRef)ctx  withArr:(NSMutableArray*)arr withRect:(CGRect)rect withFlag:(int)flag
{
    NSString *xiet =arr[1];
    rect.origin.x+=2;
    [self.drawText drawXietiTextWith:rect withContentString:xiet withFont:fontWithFlag withTextColor:self.manger.textColor];
}

- (void)huaXuanzhuan:(CGContextRef)ctx  withArr:(NSMutableArray*)arr withRect:(CGRect)rect withFlag:(int)flag
{
    CGSize   mySize = rect.size;
    
    id  content = arr[1];
    CGSize  contentSize = [self.gonshiSize getCanshuSize:content withFlag:flag];

    //保存当前上下文
    CGContextSaveGState(ctx);
    NSString  *angle = arr[2][0];
    
    CGContextTranslateCTM(ctx, mySize.width / 2, mySize.height/2);
    
    //获取旋转角度
    CGFloat  angel = [angle floatValue];
    CGContextRotateCTM(ctx, radians(angel));
    CGContextTranslateCTM(ctx , -mySize.width / 2 , -mySize.height / 2);
    
    [self drawCanShu:ctx withArr:content withRect:CGRectMake(rect.origin.x, rect.origin.y+self.manger.baseHeigt*0.1, contentSize.width, contentSize.height) withFlag:flag];
    //恢复当前上下文
    CGContextRestoreGState(ctx);
    
    
    
}
//获取翻转的角度

static inline double radians (CGFloat degrees)
{
    return degrees * M_PI/180;
}
- (CGFloat)huaShangxiaXianWith:(CGContextRef)ctx  withArr:(NSMutableArray*)arr withRect:(CGRect)rect withFlag:(int)flag
{
    id content1 = arr[1];
    id content2 = arr[2];
    id content3 = arr[3];
    
    CGFloat centery      = 0;
    
    CGSize  contentSize2 = [self.gonshiSize getCanshuSize:content2 withFlag:1];
    CGFloat rectX1       = [self getRectX:rect with:contentSize2];
    [self drawCanShu:ctx withArr:content2 withRect:CGRectMake(rectX1, rect.origin.y+3, contentSize2.width, contentSize2.height) withFlag:1];
    rect.origin.y       += contentSize2.height;
    
    
    CGSize  contentSize1 = [self.gonshiSize getCanshuSize:content1 withFlag:flag];
     CGFloat rectX2      = [self getRectX:rect with:contentSize1];
    [self drawCanShu:ctx withArr:content1 withRect:CGRectMake(rectX2, rect.origin.y, contentSize1.width, contentSize1.height) withFlag:flag];
    rect.origin.y       += contentSize1.height;
    
    centery =  contentSize2.height;
   
    CGSize  contentSize3 = [self.gonshiSize getCanshuSize:content3 withFlag:1];
     CGFloat rectX3      = [self getRectX:rect with:contentSize3];
    [self drawCanShu:ctx withArr:content3 withRect:CGRectMake(rectX3, rect.origin.y, contentSize3.width, contentSize3.height) withFlag:1];
    
    return centery;
}

- (CGFloat)huaXiaxianwith:(CGContextRef)ctx  withArr:(NSMutableArray*)arr withRect:(CGRect)rect withFlag:(int)flag
{
    id content1 = arr[1];
    
    NSMutableArray *contentArr = content1;
    if ([contentArr[0] isKindOfClass:[NSMutableArray class]])
    {
        NSMutableArray *gonshiArr = contentArr[0];
        int flage = [gonshiArr[0] intValue];
        if (flage == 15)
        {
            int  angel = [gonshiArr[2][0] intValue];
            NSString *content = gonshiArr[1][0];
            if ([content isEqualToString:@"∩"])
            {
                
            
            switch (angel)
            {
                case 270:
                    [self.drawExpress drawbuBaoHanYu1:ctx withRect:CGRectMake(rect.origin.x+1, rect.origin.y, rect.size.width-2, rect.size.height)];
                    break;
                case 90:
                    [self.drawExpress drawbuBeiBaoHanYu1:ctx withRect:CGRectMake(rect.origin.x+1, rect.origin.y, rect.size.width-2, rect.size.height)];
                    break;
                    
                default:
                    break;
            }
            return 0;
            }
            
        }
        
    }
    id  content2       = arr[2];
    
    CGFloat  centerY   = 0;
    CGSize  shangSize  = [self.gonshiSize getCanshuSize:content1 withFlag:flag];
    CGFloat  rectX = [self getRectX:rect with:shangSize];
    [self drawCanShu:ctx withArr:content1 withRect:CGRectMake(rectX, rect.origin.y, shangSize.width, shangSize.height) withFlag:flag];
    
    //这里减去的是  文字绘制的时候不是在原点绘制的哦
    
    rect.origin.y+= (shangSize.height-self.manger.baseHeigt*0.3);
    
    CGSize  xiaSize = [self.gonshiSize getCanshuSize:content2 withFlag:1];
    CGFloat  rectX1 = [self getRectX:rect with:xiaSize];
    [self drawCanShu:ctx withArr:content2 withRect:CGRectMake(rectX1, rect.origin.y, xiaSize.width, xiaSize.height) withFlag:1];
    return centerY;
}

- (void)huaXiahuaXian:(CGContextRef)ctx  withArr:(NSMutableArray*)arr withRect:(CGRect)rect withFlag:(int)flag
{
    
    id content = arr[1];
    NSMutableArray *contentArr = content;
    if ([contentArr[0] isKindOfClass:[NSMutableArray class]])
    {
        NSMutableArray *gonshiArr = contentArr[0];
        int flage = [gonshiArr[0] intValue];
        if (flage == 15)
        {
            int  angel = [gonshiArr[2][0] intValue];
            NSString *content = gonshiArr[1][0];
            if ([content isEqualToString:@"∩"])
            {
             switch (angel) {
                 case 270:
                    [self.drawExpress drawBaoHanYu1:ctx withRect:CGRectMake(rect.origin.x+1, rect.origin.y, rect.size.width-2, rect.size.height)];
                    break;
                case 90:
                    [self.drawExpress drawBeiBaoHanYu1:ctx withRect:CGRectMake(rect.origin.x+1, rect.origin.y, rect.size.width-2, rect.size.height)];
                    break;
                    
                default:
                    break;
            }
            return ;
            }
        }
        
    }
    CGSize contentSize = [self.gonshiSize getCanshuSize:content withFlag:flag];
    [self drawCanShu:ctx withArr:content withRect:CGRectMake(rect.origin.x,rect.origin.y,contentSize.width, contentSize.height) withFlag:flag];
    
    [self.drawExpress drawXiaHuaxian:ctx withRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
}
- (void)huaxieXian:(CGContextRef)ctx  withArr:(NSMutableArray*)arr withRect:(CGRect)rect withFlag:(int)flag
{
    id content = arr[1];
    
    CGSize contentSize = [self.gonshiSize getCanshuSize:content withFlag:flag];
    [self drawCanShu:ctx withArr:content withRect:CGRectMake(rect.origin.x, rect.origin.y+2, contentSize.width, contentSize.height) withFlag:flag];
    
    [self.drawExpress drawXieXian:ctx withRect:CGRectMake(rect.origin.x, rect.origin.y+2, rect.size.width, rect.size.height-2)];
    
}

- (void)huaShanchuxian:(CGContextRef)ctx  withArr:(NSMutableArray*)arr withRect:(CGRect)rect withFlag:(int)flag
{
    id  content = arr[1];
    CGSize contenSize = [self.gonshiSize getCanshuSize:content withFlag:flag];
    [self drawCanShu:ctx withArr:content withRect:CGRectMake(rect.origin.x, rect.origin.y, contenSize.width, contenSize.height) withFlag:flag];
    [self.drawExpress  drawShanchuXian:ctx withRect:rect];
    
}
- (void)huaJiantou:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    id content = arr[1];
    NSString *contentString = content[0];
    [self.drawExpress drawJiantou:ctx withRect:CGRectMake(rect.origin.x, rect.origin.y+self.manger.baseHeigt*0.1, rect.size.width, rect.size.height*0.8) withString:contentString];
}
- (CGFloat)huashangxian:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    id  content1 = arr[1];
    
    CGFloat centery    =  0;
    id  content2       =  arr[2];
    CGSize  shangSize  =  [self.gonshiSize getCanshuSize:content2 withFlag:1];
    CGFloat rectShangX =  [self getRectX:rect with:shangSize];
    [self drawCanShu:ctx withArr:content2 withRect:CGRectMake(rectShangX, rect.origin.y, shangSize.width, shangSize.height) withFlag:1];
    
    CGSize ContenSIze  = [self.gonshiSize getCanshuSize:content1 withFlag:flag];
    CGFloat rectY      = rect.origin.y + shangSize.height-self.manger.baseHeigt*0.4;
    CGFloat rectX      = [self getRectX:rect with:ContenSIze];
    [self drawCanShu:ctx withArr:content1 withRect:CGRectMake(rectX, rectY, ContenSIze.width, ContenSIze.height) withFlag:flag];
    
    centery = shangSize.height-self.manger.baseHeigt*0.5;
    return centery;
    
}


- (CGFloat)huafengchengshi:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    
    [self.drawExpress drawFancheng:ctx withRect:rect];
    int  count = [arr[1] intValue];
    rect.origin.x+= 10;
    for (int i=2; i<count+2; i++)
    {
        
        id  content = arr[i];
        CGSize contentSize =[self.gonshiSize getCanshuSize:content withFlag:flag];
        [self drawCanShu:ctx withArr:content withRect:CGRectMake(rect.origin.x, rect.origin.y, contentSize.width, contentSize.height) withFlag:flag];
        rect.origin.y+= contentSize.height;
        
    }
    return  rect.size.height/2-self.manger.baseHeigt*0.7;
    
}
- (CGFloat)huagengshi:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    CGFloat  centery = 0;
    CGFloat  baseHeith = self.manger.baseHeigt;
    rect.origin.y += baseHeith*0.3;
    rect.size.height -= baseHeith*0.3;
    if (arr.count>2)
    {
        id  content1  = arr[1];
        CGSize  cihiszie = [self.gonshiSize getCanshuSize:content1 withFlag:1];
        [self drawCanShu:ctx withArr:content1 withRect:CGRectMake(rect.origin.x, rect.origin.y-baseHeith*0.2, cihiszie.width, cihiszie.height) withFlag:1];
        rect.origin.x += (cihiszie.width-baseHeith*0.2);
        
        [self.drawExpress drawGenshi:ctx withRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width-cihiszie.width, rect.size.height)];
        
        rect.origin.x += baseHeith*0.5;
        
        id  content2 = arr[2];
        CGSize  contSIze = [self.gonshiSize getCanshuSize:content2 withFlag:flag];
        CGFloat  rectY  = [self  getRectY:rect with:contSIze];
        
        [self drawCanShu:ctx withArr:content2 withRect:CGRectMake(rect.origin.x, rectY, rect.size.width, contSIze.height) withFlag:flag];
        
    }else
    {
        
        id  content = arr[1];
        CGSize  contentSize = [self.gonshiSize getCanshuSize:content withFlag:flag];
        [self.drawExpress drawGenshi:ctx withRect:CGRectMake(rect.origin.x+baseHeith*0.2, rect.origin.y, contentSize.width+baseHeith*0.1, contentSize.height-1)];

        [self drawCanShu:ctx withArr:content withRect:CGRectMake(rect.origin.x+baseHeith*0.7, rect.origin.y, contentSize.width, contentSize.height) withFlag:flag];
    }
    centery = rect.size.height-baseHeith;

    return  centery;

    
}
- (CGFloat)huaqiuheright:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    id  content1 = arr[1];
    CGSize  ShangSize;
    CGSize  xiaSize;
    CGFloat  centery = 0;
  
    ShangSize = [self.gonshiSize getCanshuSize:content1 withFlag:1];

 
    id content2 = arr[2];
    
    xiaSize = [self.gonshiSize getCanshuSize:content2 withFlag:1];
    
    CGFloat  Sumwidth = self.manger.baseHeigt;
    
    [self.drawExpress drawsumExepress:ctx withRect:CGRectMake(rect.origin.x, rect.origin.y+ShangSize.height-self.manger.baseHeigt*0.5, Sumwidth, Sumwidth)];
    
    rect.origin.x += Sumwidth;
    centery = ShangSize.height-self.manger.baseHeigt*0.6;
    
    [self drawCanShu:ctx withArr:content1 withRect:CGRectMake(rect.origin.x, rect.origin.y, ShangSize.width, ShangSize.height) withFlag:1];
    
    [self drawCanShu:ctx withArr:content2 withRect:CGRectMake(rect.origin.x, rect.origin.y+rect.size.height-xiaSize.height, xiaSize.width, xiaSize.height) withFlag:1];
    return  centery;
}

- (CGFloat)huaqiuhe:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    id  content1 = arr[1];
    CGFloat  centy = 0;
    CGSize  contetSize1 = [self.gonshiSize getCanshuSize:content1 withFlag:1];
    
    CGFloat  rectX = [self getRectX:rect with:contetSize1];
    
    [self drawCanShu:ctx withArr:content1 withRect:CGRectMake(rectX, rect.origin.x, contetSize1.width, contetSize1.height) withFlag:1];
    rect.origin.y += contetSize1.height;
    
     CGFloat sumWindth = self.manger.baseHeigt;
    CGFloat rectmyX= [self getRectX:rect with:CGSizeMake(sumWindth, sumWindth)];
     [self.drawExpress drawsumExepress:ctx withRect:CGRectMake(rectmyX, rect.origin.y, sumWindth, sumWindth)];
    
    centy = contetSize1.height - self.manger.baseHeigt*0.2;
    rect.origin.y += (sumWindth);
    id content2 = arr[2];
    CGSize  xiaSize = [self.gonshiSize getCanshuSize:content2 withFlag:1];
    CGFloat rectX1 = [self getRectX:rect with:xiaSize];
    [self drawCanShu:ctx withArr:content2 withRect:CGRectMake(rectX1, rect.origin.y, xiaSize.width, xiaSize.height) withFlag:1];
    
    return  centy;
}
- (CGFloat)huashangxiabiaothree:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    
    id content1 = arr[1];
    CGFloat  centy = 0;
    id shangContent = arr[2];
    id  xiaContent  = arr[3];
    CGSize  contentSize = [self.gonshiSize getCanshuSize:content1 withFlag:flag];
    CGSize  shangSize = [self.gonshiSize getCanshuSize:shangContent withFlag:1];
    CGSize xiaSize  = [self.gonshiSize getCanshuSize:xiaContent withFlag:1];
    
    
    [self drawCanShu:ctx withArr:content1 withRect:CGRectMake(rect.origin.x, rect.origin.y+shangSize.height*0.5, contentSize.width, contentSize.height) withFlag:flag];
    rect.origin.x += contentSize.width;
    
    centy = shangSize.height*0.5;
    
    
    [self drawCanShu:ctx withArr:shangContent withRect:CGRectMake(rect.origin.x, rect.origin.y, shangSize.width, shangSize.height) withFlag:1];
    
    
    [self drawCanShu:ctx withArr:xiaContent withRect:CGRectMake(rect.origin.x,rect.origin.y+rect.size.height-xiaSize.height, xiaSize.width, xiaSize.height) withFlag:1];
    
    return  centy;
    
}
- (CGFloat )huaxiaBiao:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    id  content = arr[1];
    CGFloat  cneterY = 0;
    
    CGSize  contentSize = [self.gonshiSize  getCanshuSize:content withFlag:flag];
    
    [self drawCanShu:ctx withArr:content withRect:CGRectMake(rect.origin.x, rect.origin.y, contentSize.width, contentSize.height) withFlag:flag];
    
    rect.origin.x += (contentSize.width);
    
    id xiaoContent = arr[2];
    
    CGSize contentSize1 = [self.gonshiSize getCanshuSize:xiaoContent withFlag:1];
    
    [self drawCanShu:ctx withArr:xiaoContent withRect:CGRectMake(rect.origin.x,rect.origin.y+contentSize.height*0.5, contentSize1.width, contentSize1.height) withFlag:1];
    
    return  cneterY ;
}
- (CGFloat )huaShangxiaBiao:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    CGFloat  centY = 0;
    
    id  content1  = arr[1];
    CGSize xiaSize = [self.gonshiSize getCanshuSize:content1 withFlag:flag] ;
    
    id conten2 = arr[2];
    CGSize shangSize = [self.gonshiSize getCanshuSize:conten2 withFlag:1];
    
  
    [self drawCanShu:ctx withArr:content1 withRect:CGRectMake(rect.origin.x, rect.origin.y+rect.size.height-xiaSize.height, xiaSize.width, xiaSize.height) withFlag:flag];
  
    rect.origin.x+=(xiaSize.width);
  
    
    [self drawCanShu:ctx withArr:conten2 withRect:CGRectMake(rect.origin.x, rect.origin.y, shangSize.width, shangSize.height) withFlag:1];
    centY = rect.size.height-xiaSize.height;
    
    return  centY;
    
}
- (CGFloat )huaFenshi:(CGContextRef)ctx witharr:(NSMutableArray *)arr withRect:(CGRect)rect withFlag:(int )flag
{
    // 1.获取分子 分母
    
    id contTent1 = arr[1];
    CGSize  fenzhiSize = [self.gonshiSize getCanshuSize:contTent1 withFlag:flag];
    CGFloat  rectX1 = [self getRectX:rect with:fenzhiSize];
    [self drawCanShu:ctx withArr:contTent1 withRect:CGRectMake(rectX1, rect.origin.y, fenzhiSize.width, fenzhiSize.height) withFlag:flag];
    rect.origin.y+=(fenzhiSize.height);
    
    CGFloat  drawy = fenzhiSize.height-self.manger.baseHeigt*0.7;
    [self.drawExpress drawFenxian:ctx withRect:rect];
    
    
    rect.origin.y+=1;
    //3.画分母
    id contTent2 = arr[2];
    CGSize fenmuSize = [self.gonshiSize getCanshuSize:contTent2 withFlag:flag];
    CGFloat rectX = [self getRectX:rect with:fenmuSize];
    [self drawCanShu:ctx withArr:contTent2 withRect:CGRectMake(rectX, rect.origin.y, fenmuSize.width, fenmuSize.height) withFlag:flag];
   
    
    return drawy;
    
}

- (void)drawCanShu:(CGContextRef)ctx withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag
{
    
    NSInteger  CanshuCount = arr.count;
    CGSize   canShuArr[CanshuCount];
    
    CanJiXianClass *model = [[CanJiXianClass alloc] init];
    
    for (NSInteger  j=0; j<CanshuCount; j++)
    {
        id  content  = arr [j];
        
        if ([content isKindOfClass:[NSString class]])
        {
              canShuArr[j]  = [self.gonshiSize getStringSize:content withFlage:flag];
            
        }else
        {
           
              canShuArr[j] = [self.gonshiSize getGongshiSize:content withFlag:flag with:model];
         
        }
    }
    CGFloat  jixian = [model getJiXian];
    CGFloat  jiaxi = self.manger.baseHeigt*0.1;
    int gonshiJishu = 0;

    
    for (int  i =0; i<arr.count; i++)
    {
        id content = arr[i];
        if ([content isKindOfClass:[NSString class]])
        {
            [self.drawText drawTextWith:CGRectMake(rect.origin.x,rect.origin.y+jixian, canShuArr[i].width, canShuArr[i].height) withContentString:content withFont:fontWithFlag];
            rect.origin.x += (canShuArr[i].width);
        }else
        {
            CGFloat  drawYp = jixian -[model getJIxinWithIndx:gonshiJishu];
            [self dracGonshiWithArr:content withContext:ctx with:CGRectMake(rect.origin.x,rect.origin.y+ drawYp, canShuArr[i].width, canShuArr[i].height) withFlag:flag];
            gonshiJishu++;
            rect.origin.x += (canShuArr[i].width+jiaxi);
        }
        
    }
    
}

- (void)drawBiaoCanShu:(NSMutableArray *)windthArr withArr:(NSMutableArray *)arr  withRect:(CGRect)rect withFlag:(int)flag  withcontent:(CGContextRef )ctx
{
    CGFloat  baseWith = [@"a" sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    NSInteger  count = arr.count;
    CGFloat  beishu = (self.manger.baseWidth/baseWith);
    for (int  i =0; i<count; i++)
    {
        id content = arr[i];
        if ([content isKindOfClass:[NSString class]])
        {
            CGSize  contentSize = [content sizeWithFont:fontWithFlag maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            CGFloat  rectY = [self getRectY:rect with:contentSize];
            [self.drawText drawTextWith:CGRectMake(rect.origin.x,rectY, contentSize.width, contentSize.height) withContentString:content withFont:fontWithFlag];
           
            
        }else
        {
            [self drawCanShu:ctx withArr:content withRect:rect withFlag:flag];
            
        }
         rect.origin.x += ([windthArr[i] floatValue]*beishu+3);
        
    }
    
}
- (CGFloat)getRectX:(CGRect)rect with:(CGSize)size
{
    CGFloat  returnVule;
    if (size.width<rect.size.width)
    {
        returnVule = rect.origin.x+(rect.size.width/2 - size.width/2);
    }else
    {
        returnVule = rect.origin.x;
    }
    return returnVule;
}

- (CGFloat)getRectY:(CGRect)rect with:(CGSize)size
{
    CGFloat  returnVule;
    if(size.height<rect.size.height)
    {
        returnVule = rect.origin.y + (rect.size.height/2-size.height/2);
    }else
    {
        returnVule = rect.origin.y;
    }
    return  returnVule;
}
- (TYHDrawText*)drawText
{
    if (_drawText == nil) {
        _drawText = [[TYHDrawText alloc] init];
    }
    return _drawText;
}

- (TYHDrawGongshiExpress*)drawExpress
{
    if (_drawExpress == nil) {
        _drawExpress = [[TYHDrawGongshiExpress alloc] init];
    }
    return _drawExpress;
}

- (TYHGetSizeGonshi *)gonshiSize
{
    if (_gonshiSize == nil) {
        _gonshiSize = [[TYHGetSizeGonshi alloc] init];
    }
    return _gonshiSize;
    
}
- (TYHDrawMathManger *)manger
{
    if (_manger == nil)
    {
        _manger = [TYHDrawMathManger shareTYHDrawMathManger];
    }
    return _manger;
}
@end
