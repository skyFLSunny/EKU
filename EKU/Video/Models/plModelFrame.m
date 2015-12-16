//
//  plModelFrame.m
//  LYrecite
//
//  Created by tanyuehong on 15/8/18.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import "plModelFrame.h"
#import "NSString+LW.h"


@implementation plModelFrame

- (void)setModel:(plModel *)model
{
    _model = model;

    
    _imageFrame = CGRectMake(SCREENWIDTH*0.02, SCREENHEIGHT*0.01,30
                             +SCREENWIDTH/320, 30+SCREENWIDTH/320);
    NSString *userID = [NSString stringWithFormat:@"%d",model.UserID];
    
    CGFloat userheight = [userID sizeWithFont:NORMOLEFONT maxSize:CGSizeMake(SCREENWIDTH*0.5, MAXFLOAT)].height;
    _UserIDFrame = CGRectMake(CGRectGetMaxX(_imageFrame)+SCREENWIDTH*0.02, SCREENHEIGHT*0.01,SCREENWIDTH*0.5, userheight);
    
    CGFloat publicTimehieght= [model.PubTime sizeWithFont:NORMOLEFONT maxSize:CGSizeMake(SCREENWIDTH*0.5, MAXFLOAT)].height;
    
    _PubTimeFrame = CGRectMake(_UserIDFrame.origin.x, CGRectGetMaxY(_UserIDFrame)+SCREENHEIGHT*0.01, SCREENWIDTH*0.5, publicTimehieght);
    CGFloat flowerY = _imageFrame.origin.y+(_imageFrame.size.height/2)- (23 +SCREENWIDTH/320)/2;
     NSString *flowsCont = [NSString stringWithFormat:@"%d",model.Flowers];
     CGSize  flowsContSize= [flowsCont sizeWithFont:NORMOLEFONT maxSize:CGSizeMake(SCREENWIDTH*0.2, MAXFLOAT)];
    _zhanbtnFrame = CGRectMake(SCREENWIDTH*0.9-flowsContSize.width, flowerY, 15+SCREENWIDTH/320+flowsContSize.width, 20+SCREENWIDTH/320);
    
    
    
    CGFloat contentHeigt = [model.Content sizeWithFont:NORMOLEFONT maxSize:CGSizeMake(SCREENWIDTH-_UserIDFrame.origin.x, MAXFLOAT)].height;
    _ContentFrame = CGRectMake(_UserIDFrame.origin.x,_PubTimeFrame.origin.y+_PubTimeFrame.size.height+SCREENWIDTH*0.01, SCREENWIDTH*0.98-_UserIDFrame.origin.x, contentHeigt);
      CGSize  wzContSize= [model.title sizeWithFont:NORMOLEFONT maxSize:CGSizeMake(SCREENWIDTH, MAXFLOAT)];

    if(model.title.length!=0)
    {
      _wzBtn = CGRectMake(20,_ContentFrame.origin.y+_ContentFrame.size.height+SCREENHEIGHT*0.01, wzContSize.width+5, wzContSize.height+5);
    }
    else
    {
        _wzBtn = CGRectMake(0,_ContentFrame.origin.y+_ContentFrame.size.height, wzContSize.width+5, wzContSize.height+5);
    }
     _cellHeigt = CGRectGetMaxY(_ContentFrame)+ SCREENHEIGHT*0.015;
}

+ (NSMutableArray  *)plModelFramewitdData:(NSData *)data
{
    NSMutableArray  *pinglunArr = [NSMutableArray array];
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for(int i = 0 ;i<[json count];i++)
    {
        NSDictionary* dict= json[i];
        plModel* model1 = [[plModel alloc] init];
        model1.Content = [dict objectForKey:@"Content"];
        model1.Flowers = (int)[[dict  valueForKey:@"Flowers"] integerValue];
        model1.NewsReplayID = (int)[[dict valueForKey:@"NewsReplayID"] integerValue];
        model1.PubTime = [dict objectForKey:@"PubTime"];
        model1.petName = [dict objectForKey:@"PetName"];
        model1.urlImage= [NSString stringWithFormat:@"%@/Support/Download.aspx?UserIcon=%@",DOCUMENTYM,[dict objectForKey:@"IconPath"]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        NSArray* old = [model1.PubTime componentsSeparatedByString:@" "];
        NSArray* new = [currentDateStr componentsSeparatedByString:@" " ];
        if ([old[0] isEqualToString:new[0]] )
        {
            NSArray* old1=    [old[1] componentsSeparatedByString:@":"];
            NSArray* new1=    [new[1] componentsSeparatedByString:@":"];
            if ([(NSString*)new1[0] isEqualToString:old1[0]]) {
                model1.PubTime = @"刚刚";
                
            }
            else
            {
                model1.PubTime = [NSString stringWithFormat:@"%ld小时前",[new1[0] integerValue]-[old1[0] integerValue]];
            }
        }
        else if ([[new[0] componentsSeparatedByString:@"-"][1] integerValue]-[[old[0] componentsSeparatedByString:@"-"][1] integerValue]==0&&[[new[0] componentsSeparatedByString:@"-"][0] integerValue]-[[old[0] componentsSeparatedByString:@"-"][0] integerValue]==0)
        {
            model1.PubTime  = [NSString stringWithFormat:@"%ld天前",[[new[0] componentsSeparatedByString:@"-"][2] integerValue]-[[old[0] componentsSeparatedByString:@"-"][2] integerValue]];
        }
        else
        {
            
            model1.PubTime  = old[0];
        }
        plModelFrame *modelFrame = [[plModelFrame alloc] init];
        modelFrame.model = model1;
        modelFrame.textFont = NORMOLEFONT;
        
        [pinglunArr addObject:modelFrame];
        
    }
    return pinglunArr;
}

@end
