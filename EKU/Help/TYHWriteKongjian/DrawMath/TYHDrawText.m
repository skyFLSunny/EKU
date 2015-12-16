//
//  TYHDrawText.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/22.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import "TYHDrawText.h"
#import "NSString+LW.h"
#import "oprationType.h"
#import "TYHDrawMathManger.h"


@interface TYHDrawText ()

@property (nonatomic,strong) TYHDrawMathManger *manger;

@property (nonatomic,strong) oprationType  *operationtype;

@end

@implementation TYHDrawText


- (CGSize)drawTextWith:(CGRect)rect withContentString:(NSString *)string withFont:(UIFont *)font withTextColor:(UIColor *)textColor
{
    
    
    _contextSize = [string sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [string drawAtPoint:CGPointMake(rect.origin.x,rect.origin.y)  withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor}];
 
    
    return _contextSize;
}
- (CGSize)drawXietiTextWith:(CGRect)rect withContentString:(NSString *)string withFont:(UIFont *)font withTextColor:(UIColor *)textColor
{
    _contextSize = [string sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    NSMutableAttributedString  *xietiString = [[NSMutableAttributedString alloc] initWithString:string];
    int lenth = (int)string.length;
    [xietiString addAttribute:NSForegroundColorAttributeName value:self.manger.textColor range:NSMakeRange(0, lenth)];
    [xietiString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:font.pointSize+1]  range:NSMakeRange(0, lenth)];
    [xietiString drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y)];
    return _contextSize;
}
- (CGSize)drawTextWith:(CGRect)rect withContentString:(NSString *)string withFont:(UIFont *)font
{

    
    if (self.manger.mathFlag == 1)
    {
        
        NSAttributedString  *mystring = [self getAtrtrButiStringWith:string withFont:font];
        [mystring drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y)];

    }else
    {
    
        _contextSize = [string sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
       [string drawAtPoint:CGPointMake(rect.origin.x ,rect.origin.y)  withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:self.manger.textColor}];
        return _contextSize;
    }
    
   return CGSizeMake(0, 0);
    
    
}
- (CGSize)drawTextWith:(CGRect)rect withContentString:(NSString *)string
{
     _contextSize = [string sizeWithFont:self.manger.textFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat drawtextX;
    if (rect.size.width<_contextSize.width) {
        drawtextX= rect.origin.x;
    }else
    {
        drawtextX = rect.origin.x+rect.size.width/2-_contextSize.width/2;
    }
    [string drawAtPoint:CGPointMake(drawtextX,rect.origin.y)  withAttributes:@{NSFontAttributeName:self.manger.textFont,NSForegroundColorAttributeName:self.manger.textColor}];
    
    return _contextSize;
    
}

//绘制时正常文字信息
- (UIImage *)drawTextWithString:(NSString *)content
{
    if (self.manger.mathFlag == 1)
    {
    
        
        NSAttributedString *mysring = [self getAtrtrButiStringWith:content withFont:self.manger.textFont];
        CGSize  mysize  = mysring.size;
        
        UIGraphicsBeginImageContextWithOptions(mysize , NO, 0);
        //1.获取bitmap上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        if(self.manger.backGroundClolor !=nil)
        {
           [self.manger.backGroundClolor set];
            CGContextAddRect(ctx, CGRectMake(0.0f, 0.0f, mysize.width, mysize.height));
            CGContextFillPath(ctx);
            
        }
        //2.绘制文字
        
        CGFloat  conteX =0;
        if ([content characterAtIndex:0]=='f')
        {
                 conteX =self.manger.baseHeigt*0.1;
        }
        [mysring drawAtPoint:CGPointMake(conteX, 0)];
        
        
    }else
    {
        CGSize  gonshiSize = [content sizeWithFont:self.manger.textFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        gonshiSize.width  +=2;
        gonshiSize.height +=2;
        UIGraphicsBeginImageContextWithOptions(gonshiSize , NO, 0);
        //1.获取bitmap上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        if(self.manger.backGroundClolor !=nil)
        {
            [self.manger.backGroundClolor set];
            CGContextAddRect(ctx, CGRectMake(0.0f, 0.0f, gonshiSize.width, gonshiSize.height));
            CGContextFillPath(ctx);
            
        }
    
    [content drawAtPoint:CGPointMake(1, 1) withAttributes:@{NSFontAttributeName:self.manger.textFont,NSForegroundColorAttributeName:self.manger.textColor}];
    }
    //4.获取生成的图片
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    return image;
}


- (void)setContextString:(NSString *)contextString
{
    _contextString = contextString;
    _contextSize = [contextString sizeWithFont:self.manger.textFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
}

- (NSAttributedString *)getAtrtrButiStringWith:(NSString *)contentString  withFont:(UIFont *)font
{
    CGFloat  fontPoint = font.pointSize;
    NSMutableAttributedString  *mystring = [[NSMutableAttributedString alloc] initWithString:contentString attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:self.manger.textColor,NSKernAttributeName :@(1.0f)}];
    NSMutableArray  *xieTiarr = [self.operationtype getxieTieArr];
    
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
                if (mychar=='f')
                {
                    [mystring addAttribute:NSKernAttributeName value:@(4.0f)  range:NSMakeRange(i, 1)];
                }
            }
            
        }
        
        
    }
    NSMutableArray  *fanXietiArr = [self.operationtype getfanXietiArr];
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


//对公式管理类进行懒加载

- (TYHDrawMathManger *)manger
{
    
    if (_manger == nil) {
        
        _manger = [TYHDrawMathManger shareTYHDrawMathManger];
    }
    return _manger;
}

- (oprationType *)operationtype
{
    if (_operationtype == nil)
    {
        _operationtype = [oprationType sharedOprationType];
    }
    return  _operationtype;
}
@end
