//
//  TYHDrawMathFactor.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/22.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//


//应用了工厂模式绘制公式
#import "TYHDrawMathManger.h"
#import "TYHGonshiJIexi.h"
#import "TYHDrawGongshi.h"
#import "TYHDrawText.h"
#import "NSString+LW.h"
#import <UIKit/UIKit.h>
#import "MathImageModel.h"

@interface TYHDrawMathManger ()

@property (nonatomic,strong)TYHGonshiJIexi  *GSjiexi;

@property (nonatomic,strong)TYHDrawGongshi *drawGonshi;

@property (nonatomic,strong)TYHDrawText  *drawText;


@property (atomic,assign) int  isFinshFlag;


@end

@implementation TYHDrawMathManger

+ (TYHDrawMathManger *)shareTYHDrawMathManger
{
    
    static TYHDrawMathManger *shareTYHDrawMathManger = nil;
    static dispatch_once_t  predicate;
    dispatch_once(&predicate, ^{
        shareTYHDrawMathManger  = [[self alloc] init];
    });
    return  shareTYHDrawMathManger;
    
}

//绘制所有的公式对象，自动支持多线程的绘制
- (NSMutableArray *)drawAllMathExpresswithArr:(NSMutableArray *)arr
{
    
    return [self getGonshiArr:arr];

}

- (NSMutableArray  *)getGonshiArr:(NSMutableArray *)arr
{
    NSMutableArray  *gonshiAarr = [NSMutableArray array];
    for (NSInteger i =0; i<arr.count; i++)
    {
        NSMutableArray *goshiArr = [self.GSjiexi getJieXiArr:arr[i]];
        UIImage  *image = [self drawMathExpresswithArr:goshiArr];
        [gonshiAarr addObject:image];
        
    }
    
    return gonshiAarr;
}

- (UIImage *)drawMathExpresswithArr:(NSMutableArray *)arr
{
    NSMutableArray  *imageArr = [NSMutableArray array];
    
    for (int i = 0; i<arr.count; i++)
    {
        
        id content = arr[i];
        if ([content isKindOfClass:[NSString class]])
        {
            UIImage *wenzhiImage = [self.drawText drawTextWithString:content];
            MathImageModel   *imageModel = [MathImageModel MathImageModelWith:wenzhiImage WithDarwY:0];
            [imageArr addObject:imageModel];
        }else
        {
            MathImageModel *gonshiImage = [self drawGonshiImageWithArr:content];
            [imageArr addObject:gonshiImage];
        }
    }
    
    return  [self sumImagewitImageArr:imageArr];
    
}

- (UIImage *)sumImagewitImageArr:(NSMutableArray *)imageArr
{
    CGFloat  windth = 0;
    CGFloat  heigt = 0;
    CGFloat  baseJixian = 0;
    CGFloat  botomHeight = 0;
    
    for (NSInteger i =0; i<imageArr.count; i++)
    {
        
        //这里是获取第一张的一个中间基线 的位置 ，以后根据这个位置计算高度，基线位置根据
        
        MathImageModel  *mathModel = imageArr[i];
        CGSize   imageSize = [mathModel getMathImage].size;
        CGFloat  drawY = [mathModel getDrawY];
        windth            +=  imageSize.width;
        CGFloat tempHeit   =  imageSize.height;
        //对比基线 的高度
        if (baseJixian <drawY)
        {
            baseJixian = drawY;
        }
       
        CGFloat  tempBotmHeight = tempHeit-drawY;
        if (botomHeight<tempBotmHeight)
        {
            botomHeight = tempBotmHeight;
        }
    }
    heigt = baseJixian +botomHeight;
    CGSize  gonshiSize = CGSizeMake(windth, heigt);
    
    UIGraphicsBeginImageContextWithOptions(gonshiSize , NO, 0);
    //1.获取bitmap上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if(self.backGroundClolor !=nil)
    {
        [self.backGroundClolor set];
        CGContextAddRect(ctx, CGRectMake(0.0f, 0.0f, gonshiSize.width, gonshiSize.height));
        CGContextFillPath(ctx);
        
    }
    CGFloat  drawX = 0;
    for (NSInteger  i =0; i<imageArr.count; i++)
    {
        
        MathImageModel  *mathModel = imageArr[i];
        UIImage  *image =  [mathModel getMathImage];
        CGFloat  drawY = [mathModel getDrawY];
        [image drawAtPoint:CGPointMake(drawX, baseJixian-drawY)];
        drawX += image.size.width;
    }
    
    //4.获取生成的图片
    UIImage *jieguoimage=UIGraphicsGetImageFromCurrentImageContext();
    
    return jieguoimage;
    
}

//绘制一个公式对象
- (MathImageModel *)drawGonshiImageWithArr:(NSMutableArray *)contentArr
{
    TYHDrawGongshi *mydraw = [TYHDrawGongshi TYHDrawGongshiWithString:contentArr];
  
    MathImageModel *myImage = [mydraw DrawGongshi];
    
    return myImage;
}

- (TYHGonshiJIexi *)GSjiexi
{
    if (_GSjiexi == nil) {
        _GSjiexi  = [[TYHGonshiJIexi alloc] init];
    }
    return _GSjiexi;
}
- (TYHDrawGongshi *)drawGonshi
{
    if (_drawGonshi == nil) {
        _drawGonshi  = [[TYHDrawGongshi alloc] init];
    }
    return _drawGonshi;
}
- (CGFloat)baseHeigt
{
    _baseHeigt = [@"a" sizeWithFont:self.textFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height*0.8;
    return _baseHeigt;
}

- (CGFloat)baseWidth
{
    _baseWidth = [@"a" sizeWithFont:self.textFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    return _baseWidth;
}
- (TYHDrawText *)drawText
{
    if (_drawText == nil)
    {
        _drawText = [[TYHDrawText alloc] init];
    }
    return  _drawText;
}
@end
