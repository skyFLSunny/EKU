//
//  TYHDrawGongshiExpress.m
//  CoreTextDemo
//
//  Created by tanyuehong on 15/9/22.
//  Copyright © 2015年 tanyuehong. All rights reserved.
//

#import "TYHDrawGongshiExpress.h"
#import "TYHDrawMathManger.h"
#import "NSString+LW.h"

#define PI 3.14159265358979323846

@interface TYHDrawGongshiExpress  ()

@property (nonatomic,assign) CGFloat baseHeight;

@property (nonatomic,strong) TYHDrawMathManger *manger;
@end

@implementation TYHDrawGongshiExpress


- (BOOL)drawGonshiExprss:(CGContextRef)ctx withRect:(CGRect)rect withType:(int)type
{
    return true;
}

//这个是绘制根式的绘图
- (void)drawGenshi:(CGContextRef )ctx  withRect:(CGRect)rect
{
    [self.manger.textColor set];
    
    CGFloat width = self.manger.baseHeigt*0.15;
    if (width <2)
    {
        width = 2;
    }
    
    CGContextMoveToPoint(ctx,rect.origin.x+rect.size.width+2,rect.origin.y+1);
    CGContextAddLineToPoint(ctx, rect.origin.x+width*2, rect.origin.y+1);
    CGContextAddLineToPoint(ctx, rect.origin.x+width, rect.origin.y+rect.size.height);
    
    CGContextAddLineToPoint(ctx, rect.origin.x, rect.origin.y+rect.size.height-width);
    CGContextAddLineToPoint(ctx, rect.origin.x-width, rect.origin.y+rect.size.height-1);
    CGContextStrokePath(ctx);
}

- (void)drawFenxian:(CGContextRef)ctx withRect:(CGRect)rect
{
    _gonshiExpressRect = rect;
    [self.manger.textColor set];
    CGContextMoveToPoint(ctx, rect.origin.x-1,rect.origin.y+1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+1);
    CGContextStrokePath(ctx);
    
    
}
- (void)drawsumExepress:(CGContextRef)ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx,   rect.origin.x+rect.size.width,  rect.origin.y+3);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width , rect.origin.y);
    CGContextAddLineToPoint(ctx, rect.origin.x,rect.origin.y);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width/2,rect.origin.y+rect.size.height/2);
    
    CGContextAddLineToPoint(ctx, rect.origin.x, rect.size.height+rect.origin.y);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height-3);
    CGContextStrokePath(ctx);
}

//这个是绘制方程式的公式表达式
- (void)drawFancheng:(CGContextRef )ctx  withRect:(CGRect)rect
{   [self.manger.textColor set];
    CGContextMoveToPoint(ctx,rect.origin.x+7,     rect.origin.y+rect.size.height*0.17);
    CGContextAddLineToPoint(ctx, rect.origin.x+5, rect.origin.y+rect.size.height*0.20);
    CGContextAddLineToPoint(ctx, rect.origin.x+5, rect.origin.y+rect.size.height*0.50);
    CGContextAddLineToPoint(ctx, rect.origin.x+2, rect.origin.y+rect.size.height*0.55);
    CGContextAddLineToPoint(ctx, rect.origin.x+5, rect.origin.y+rect.size.height*0.60);
    CGContextAddLineToPoint(ctx, rect.origin.x+5, rect.origin.y+rect.size.height*0.90);
    CGContextAddLineToPoint(ctx, rect.origin.x+7, rect.origin.y+rect.size.height*0.93);
    CGContextStrokePath(ctx);
}
- (void)drawJiantou:(CGContextRef )ctx withRect:(CGRect)rect withString:(NSString *)content
{
    int  flage = [self getJiantouType:content];
    if (flage == -1)
    {
        NSLog(@"抱歉，不支持%@类型箭头",content);
        return ;
        
        
    }
    rect.origin.y+=2;
    switch (flage) {
        case 0:
            [self drawEquel:ctx withRect:rect];
            break;
        case 1:
            [self drawdanxianJiantou:ctx withRect:rect];
            break;
        case 2:
            [self drawdanxianFanJiantou:ctx withRect:rect];
            break;
        case 3:
            [self drawzuoyouJiantou:ctx withRect:rect];
            break;
        case 4:
            [self drawdenghaoJiantou:ctx withRect:rect];
            break;
        case 5:
            [self drawdenghaoRight:ctx withRect:rect];
            break;
        case 6:
            [self drawLeftDenghao:ctx withRect:rect];
            break;
        case 7:
            [self drawLeftAndRight:ctx withRect:rect];
            break;
        case 8:
            [self drawdanXian:ctx withRect:rect];
            break;
        default:
            break;
    }
    
    
}

- (int)getJiantouType:(NSString *)string
{
    int  flag= -1;
    
    if ([string isEqualToString:@"="])
    {
        flag = 0;
        return  flag;
    }
    
    if ([string isEqualToString:@"->"])
    {
        flag = 1;
        return  flag;
    }
    
    if ([string isEqualToString:@"<-"])
    {
        flag = 2;
        return  flag;
    }
    if ([string isEqualToString:@"<->"])
    {
        flag = 3;
        return  flag;
    }
    if ([string isEqualToString:@"<-->"])
    {
        flag = 4;
        return  flag;
    }
    if ([string isEqualToString:@"=>"])
    {
        flag = 5;
        return  flag;
    }
    if ([string isEqualToString:@"<="])
    {
        flag = 6;
        return  flag;
    }
    if ([string isEqualToString:@"<=>"])
    {
        flag = 7;
        return  flag;
    }
    if ([string isEqualToString:@"-"])
    {
        flag = 8;
        return  flag;
    }
    return flag;
}
-(void)drawdanXian:(CGContextRef )ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx,rect.origin.x, rect.origin.y+rect.size.height/2-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height/2-1);
    
    CGContextStrokePath(ctx);
}
-(void)drawXiaHuaxian:(CGContextRef )ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
     CGContextMoveToPoint(ctx,rect.origin.x,rect.origin.y+rect.size.height-1);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width-1,rect.origin.y+rect.size.height-1);
     CGContextStrokePath(ctx);
}

- (void)drawBaoHanYu1:(CGContextRef )ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGFloat  baseHeit = self.manger.baseHeigt*0.35;
    CGFloat  lineWith = self.manger.textFont.pointSize/20;
    CGContextSetLineWidth(ctx, lineWith);
    CGFloat  banjing = (rect.size.height*0.4)/2;
    CGContextMoveToPoint(ctx, rect.origin.x+rect.size.width, rect.origin.y+baseHeit);
    CGContextAddLineToPoint(ctx, rect.origin.x+banjing, rect.origin.y+baseHeit);
    
    CGContextAddArc(ctx, rect.origin.x+banjing, rect.origin.y+banjing+baseHeit, banjing, radians(270), radians(90), 1);
    
    CGContextMoveToPoint(ctx, rect.origin.x+rect.size.width, rect.origin.y+banjing+banjing+baseHeit);
    CGContextAddLineToPoint(ctx, rect.origin.x+banjing, rect.origin.y+banjing+banjing+baseHeit);

    CGContextMoveToPoint(ctx, rect.origin.x+banjing/2, rect.origin.y+rect.size.height*0.85);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height*0.85);

    CGContextStrokePath(ctx);
    
}
- (void)drawbuBaoHanYu1:(CGContextRef )ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGFloat  baseHeit = self.manger.baseHeigt*0.3;
    CGFloat  lineWith = self.manger.textFont.pointSize/20;
    CGContextSetLineWidth(ctx, lineWith);
    CGFloat  banjing = (rect.size.height*0.4)/2;
    CGContextMoveToPoint(ctx, rect.origin.x+rect.size.width, rect.origin.y+baseHeit);
    CGContextAddLineToPoint(ctx, rect.origin.x+banjing, rect.origin.y+baseHeit);
    
    CGContextAddArc(ctx, rect.origin.x+banjing+1 , rect.origin.y+banjing+baseHeit, banjing, radians(270), radians(90), 1);
    
    CGContextMoveToPoint(ctx, rect.origin.x+rect.size.width, rect.origin.y+banjing+banjing+baseHeit);
    CGContextAddLineToPoint(ctx, rect.origin.x+banjing, rect.origin.y+banjing+banjing+baseHeit);
    
    CGContextMoveToPoint(ctx, rect.origin.x+banjing/2, rect.origin.y+rect.size.height*0.75);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height*0.75);
    
    CGContextMoveToPoint(ctx, rect.origin.x+banjing/2, rect.origin.y+rect.size.height*0.9);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height*0.9);
    
    CGContextMoveToPoint(ctx, rect.origin.x+(rect.size.width/4)*3, rect.origin.y+rect.size.height*0.65);
    CGContextAddLineToPoint(ctx, rect.origin.x+(rect.size.width/4), rect.origin.y+rect.size.height);
    
    CGContextStrokePath(ctx);
    
}


- (void)drawbuBeiBaoHanYu1:(CGContextRef )ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGFloat  baseHeit = self.manger.baseHeigt*0.3;
    CGFloat  lineWith = self.manger.textFont.pointSize/20;
    CGContextSetLineWidth(ctx,lineWith);
    CGFloat  banjing = (rect.size.height*0.4)/2;
    CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y+baseHeit);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width-banjing, rect.origin.y+baseHeit);
    
    CGContextAddArc(ctx, rect.origin.x+rect.size.width-banjing , rect.origin.y+baseHeit+banjing, banjing, radians(-90), radians(90), 0);
    
    CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y+banjing+banjing+baseHeit);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width-banjing, rect.origin.y+banjing+banjing+baseHeit);
    
    CGContextMoveToPoint(ctx, rect.origin.x+rect.size.width-banjing/2, rect.origin.y+rect.size.height*0.75);
    CGContextAddLineToPoint(ctx, rect.origin.x, rect.origin.y+rect.size.height*0.75);
    
    CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y+rect.size.height*0.9);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width-banjing/2, rect.origin.y+rect.size.height*0.9);
    
    CGContextMoveToPoint(ctx, rect.origin.x+(rect.size.width/5)*3, rect.origin.y+rect.size.height*0.65);
    CGContextAddLineToPoint(ctx, rect.origin.x+(rect.size.width/4), rect.origin.y+rect.size.height);
    
    CGContextStrokePath(ctx);
    
}

- (void)drawBeiBaoHanYu1:(CGContextRef )ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGFloat  baseHeit = self.manger.baseHeigt*0.35;
    CGFloat  lineWith = self.manger.textFont.pointSize/20;
    CGContextSetLineWidth(ctx, lineWith);
    CGFloat  banjing = (rect.size.height*0.4)/2;
    CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y+baseHeit);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width-banjing, rect.origin.y+baseHeit);
    
    CGContextAddArc(ctx, rect.origin.x+rect.size.width-banjing, rect.origin.y+banjing+baseHeit, banjing, radians(-90), radians(90), 0);
    CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y+banjing+banjing+baseHeit);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width-banjing, rect.origin.y+banjing+banjing+baseHeit);
    
    CGContextMoveToPoint(ctx, rect.origin.x+rect.size.width-banjing/2, rect.origin.y+rect.size.height*0.85);
    CGContextAddLineToPoint(ctx, rect.origin.x, rect.origin.y+rect.size.height*0.85);
    
    CGContextStrokePath(ctx);
    
}
- (void)drawXieXian:(CGContextRef )ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx,rect.origin.x+rect.size.width*0.9,rect.origin.y+rect.size.height*0.1);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width*0.1,rect.origin.y+rect.size.height*0.9);
    CGContextStrokePath(ctx);
    
}

- (void)drawShanchuXian:(CGContextRef )ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx,rect.origin.x,rect.origin.y+rect.size.height/2+1);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width,rect.origin.y+rect.size.height/2+1);
    CGContextStrokePath(ctx);
}

- (void)drawEquel:(CGContextRef )ctx  withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx,rect.origin.x,rect.origin.y+rect.size.height*0.3);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width,rect.origin.y+rect.size.height*0.3);
    CGContextMoveToPoint(ctx,rect.origin.x,rect.origin.y+rect.size.height*0.6);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height*0.6);
    CGContextStrokePath(ctx);
    
}

- (void)drawdanxianJiantou:(CGContextRef )ctx  withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
    CGFloat with =rect.size.height*0.3;
    CGContextMoveToPoint(ctx,rect.origin.x, rect.origin.y+rect.size.height/2-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height/2-1);
    CGContextMoveToPoint(ctx,rect.origin.x+rect.size.width-with,  rect.origin.y+rect.size.height/2-with-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height/2-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-with,rect.origin.y+rect.size.height/2+with-1);
    CGContextStrokePath(ctx);
}

- (void)drawdanxianFanJiantou:(CGContextRef )ctx  withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
     CGFloat with =rect.size.height*0.3;
    CGContextMoveToPoint(ctx,rect.origin.x, rect.origin.y+rect.size.height/2-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height/2-1);
    CGContextMoveToPoint(ctx,rect.origin.x+with,  rect.origin.y+rect.size.height/2-with-1);
     CGContextAddLineToPoint(ctx,rect.origin.x,rect.origin.y+rect.size.height/2-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+with,rect.origin.y+rect.size.height/2+with-1);
    CGContextStrokePath(ctx);
}


- (void)drawzuoyouJiantou:(CGContextRef )ctx  withRect:(CGRect)rect
{
    [self.manger.textColor set];
     CGContextSetLineWidth(ctx, 1);
     CGFloat with =rect.size.height*0.3;
    CGContextMoveToPoint(ctx,rect.origin.x, rect.origin.y+rect.size.height/2-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height/2-1);
    
    CGContextMoveToPoint(ctx,rect.origin.x+with,  rect.origin.y+rect.size.height/2-with-1);
    CGContextAddLineToPoint(ctx,rect.origin.x,rect.origin.y+rect.size.height/2-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+with,rect.origin.y+rect.size.height/2+with-1);
    
    CGContextMoveToPoint(ctx,rect.origin.x+rect.size.width-with,  rect.origin.y+rect.size.height/2-with-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height/2-1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-with,rect.origin.y+rect.size.height/2+with-1);
    CGContextStrokePath(ctx);
    
}

- (void)drawdenghaoJiantou:(CGContextRef )ctx  withRect:(CGRect)rect
{
    [self.manger.textColor set];
     CGContextSetLineWidth(ctx, 1);
    CGFloat  width = rect.size.height*0.3;
    CGContextMoveToPoint(ctx,rect.origin.x+width,  rect.origin.y+rect.size.height*0.3-width);
    CGContextAddLineToPoint(ctx, rect.origin.x,rect.origin.y+rect.size.height*0.3);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width,rect.origin.y+rect.size.height*0.3);
    
    CGContextMoveToPoint(ctx,rect.origin.x+rect.size.width-width,  rect.origin.y+rect.size.height*0.6+width);
    CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width,rect.origin.y+rect.size.height*0.6);
     CGContextAddLineToPoint(ctx, rect.origin.x,rect.origin.y+rect.size.height*0.6);
    CGContextStrokePath(ctx);

    
}

- (void)drawdenghaoRight:(CGContextRef )ctx  withRect:(CGRect)rect
{
    [self.manger.textColor set];
     CGContextSetLineWidth(ctx, 1);
    CGFloat  width = rect.size.height*0.3;
    
    CGContextMoveToPoint(ctx,rect.origin.x,  rect.origin.y+rect.size.height*0.3);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-width,rect.origin.y+rect.size.height*0.3);
    
    CGContextMoveToPoint(ctx,rect.origin.x,rect.origin.y+rect.size.height*0.6);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-width,rect.origin.y+rect.size.height*0.6);
    
    CGContextMoveToPoint(ctx,rect.origin.x+rect.size.width-width, rect.origin.y+rect.size.height*0.1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height/2);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-width,rect.origin.y+rect.size.height*0.8);
    CGContextStrokePath(ctx);
    
}

- (void)drawLeftDenghao:(CGContextRef )ctx  withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
    CGFloat  width = rect.size.height*0.3;
    
    CGContextMoveToPoint(ctx,rect.origin.x+width,  rect.origin.y+rect.size.height*0.3);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height*0.3);
    
    CGContextMoveToPoint(ctx,rect.origin.x+width,rect.origin.y+rect.size.height*0.6);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height*0.6);
    
    CGContextMoveToPoint(ctx,rect.origin.x+width,  rect.origin.y+rect.size.height*0.1);
    CGContextAddLineToPoint(ctx,rect.origin.x,rect.origin.y+rect.size.height/2);
    CGContextAddLineToPoint(ctx,rect.origin.x+width,rect.origin.y+rect.size.height*0.8);
    CGContextStrokePath(ctx);
}

- (void)drawLeftAndRight:(CGContextRef)ctx withRect:(CGRect)rect
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
    
    CGFloat  width = rect.size.height*0.3;
//  画上线
    CGContextMoveToPoint(ctx,rect.origin.x+width,  rect.origin.y+rect.size.height*0.3);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-width,rect.origin.y+rect.size.height*0.3);
//画下线
    CGContextMoveToPoint(ctx,rect.origin.x+width,rect.origin.y+rect.size.height*0.6);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-width,rect.origin.y+rect.size.height*0.6);
    
//画左箭头
    CGContextMoveToPoint(ctx,rect.origin.x+width,rect.origin.y+rect.size.height*0.1);
    CGContextAddLineToPoint(ctx,rect.origin.x,rect.origin.y+rect.size.height/2);
    CGContextAddLineToPoint(ctx,rect.origin.x+width,rect.origin.y+rect.size.height*0.8);
//画右箭头
    CGContextMoveToPoint(ctx,rect.origin.x+rect.size.width-width,  rect.origin.y+rect.size.height*0.1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width,rect.origin.y+rect.size.height/2);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-width,rect.origin.y+rect.size.height*0.8);
    
  CGContextStrokePath(ctx);
    
    
    
}

- (void)drawBiaoge:(CGContextRef )ctx withRect:(CGRect)rect withHeigtArr:(NSMutableArray *)heigtArr withWindthArr:(NSMutableArray *)widthArr
{
    [self.manger.textColor set];
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx,rect.origin.x+1,  rect.origin.y+1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-1,rect.origin.y+1);
    CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-1,rect.origin.y+rect.size.height-2);
    CGContextAddLineToPoint(ctx,rect.origin.x+1,rect.origin.y+rect.size.height-2);
    CGContextAddLineToPoint(ctx,rect.origin.x+1,rect.origin.y-1);
    CGFloat drawY = rect.origin.x;
    CGFloat  backgradheit = rect.origin.y +[heigtArr[0] floatValue];
    for (NSInteger i= 0; i<heigtArr.count-1;i++)
    {
         drawY += [heigtArr[i] floatValue];
          CGContextMoveToPoint(ctx,rect.origin.x+1,  drawY);
         CGContextAddLineToPoint(ctx,rect.origin.x+rect.size.width-1,  drawY);
    }
    
    CGFloat basewiht =[@"a" sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    CGFloat  bielie = self.manger.baseWidth/basewiht;
    
    CGFloat  drawX = rect.origin.x;
    
    for (NSInteger i = 0; i<widthArr.count-1; i++)
    {
        drawX += ([widthArr[i] floatValue])*bielie;
        CGContextMoveToPoint(ctx,drawX,  rect.origin.y+1);
        CGContextAddLineToPoint(ctx,drawX,rect.origin.y+rect.size.height-2);
        
    }
    CGContextStrokePath(ctx);
    
    UIColor *bakcolor = [self.manger.textColor colorWithAlphaComponent:0.15];
    [bakcolor set];
    CGContextAddRect(ctx, CGRectMake(rect.origin.x, rect.origin.y,rect.size.width, backgradheit));
    CGContextFillPath(ctx);
    
    
    
    
}

static inline float radians(double degrees)
{
    return degrees * PI / 180;
}
- (TYHDrawMathManger *)manger
{
    if (_manger == nil)
    {
        _manger = [TYHDrawMathManger shareTYHDrawMathManger];
    }
    return  _manger;
}
@end
