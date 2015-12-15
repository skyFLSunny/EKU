//
//  TYHShowView.m
//  HppleDemo
//
//  Created by tanyuehong on 15/10/14.
//
//

#import "TYHShowView.h"
#import "NSString+LW.h"
#import "TYHDrawMathManger.h"

#import "TYHShowContenModel.h"
#import "contentModel.h"
#import "TYImageStorage.h"
#import "ClickImage.h"
#import "TYHGetContentImage.h"


@interface TYHShowView () <TYAttributedLabelDelegate,TYHGetContentImageDelegate>

@property (nonatomic,weak) TYAttributedLabel *mycontent;

@property (nonatomic,assign) CGFloat  width;

@property (nonatomic,strong) NSAttributedString *attString;

@property (nonatomic,assign) CGSize  kongjianSize;


@property (nonatomic,strong) NSMutableArray *gongshiArr;

@property (nonatomic,strong) NSMutableArray *gongshiImaeArr;


@property (nonatomic,strong)TYHShowContenModel *mySHowContModel;

@property (nonatomic,strong) NSMutableArray   *mycontentArr;

@property (nonatomic,strong)NSString  *contetnString;

@property (nonatomic,assign) int   shengchengflag;

@property (nonatomic, strong)   TYTextContainer *MytextContainer;

@property (nonatomic,strong) TYHGetContentImage  *getContetntImage;

@property (nonatomic,strong) NSDictionary  *nomalDict;


@end
@implementation TYHShowView
{
    BOOL gongshiSuccss;
    BOOL imageSuceess;
    BOOL  conetnetSucee;
    
     int   gsJiShu;
     int imageJishu;
}

- (id)init
{
    self =[super init];
    if (self)
    {
        TYAttributedLabel  *mycontent = [[TYAttributedLabel alloc] init];
        self.mycontent = mycontent;
        mycontent.delegate = self;
        [self addSubview:mycontent];
    }
    return  self;
}


- (void)shengchengNeiRong:(NSString *)contentString  withModel:(TYHShowContenModel *)model  with:(id)delegate

{
    self.userInteractionEnabled = YES;
    self.mySHowContModel = model;
    _delegete = delegate;
    self.shengchengflag = 0;
    
    gongshiSuccss = NO;
    imageSuceess  = NO;
    conetnetSucee = NO;
    
    self.width = [UIScreen mainScreen].bounds.size.width;
    
    //1  获取公式解析并开线程生成公式
    NSString  *content = [self huoquGonshiWithString:contentString];
    
    //2  获取内容里面的图片并开启线程下载
    
    NSMutableArray *contentimageArr = [self getImageArr:content];
    
    //4 下载内容里面的图片
    [self getContentImage:contentimageArr];
    
    
    //5  将显示内容里面的图片替换成特殊的标记
    NSString *mynewString = [self  relaceImageContent:content withImagerArr:contentimageArr];
    self.contetnString = mynewString;
    [self jiexieContentAndImage:mynewString];
    
    
}
- (void)jiexieContentAndImage:(NSString *)contnetString
{
    NSMutableArray  *contentArr = [NSMutableArray array];
    for (int i=0; i<contnetString.length-3&&contnetString.length>3; i++)
    {
        NSString  *tagString = [contnetString substringWithRange:NSMakeRange(i, 3)];
        if ([tagString isEqualToString:@"<b>"])
        {
            NSString *String = [contnetString substringToIndex:i];
            [self shengchengContent:String with:contentArr withFlage:1];
            contnetString =[contnetString substringFromIndex:i+3];
            i = -1;
            continue;
        }
        
        if ([tagString isEqualToString:@"</b"])
        {
            NSString *string = [contnetString substringToIndex:i];
            [self shengchengContent:string with:contentArr withFlage:2];
            contnetString = [contnetString substringFromIndex:i+4];
            i=-1;
            continue;
            
        }
        if ([tagString isEqualToString:@"<<G"])
        {
            
            NSString *string = [contnetString substringToIndex:i];
            [self shengchengContent:string with:contentArr withFlage:3];
            contnetString =[contnetString substringFromIndex:i+5];
            i=-1;
            continue;
        }
        if ([tagString isEqualToString:@"<su"])
        {
           
            NSString *string = [contnetString substringToIndex:i];
            [self shengchengContent:string with:contentArr withFlage:4];
            contnetString =[contnetString substringFromIndex:i+5];
            i = -1;
            continue;
        }
        if ([tagString isEqualToString:@"</s"])
        {
            NSString  *show = [contnetString substringToIndex:i+6];
            contnetString = [contnetString substringFromIndex:i+6];
            [self addsubAndSupwith:show withArrr:contentArr];
            i=-1;
            continue;
            
        }
        if ([tagString isEqualToString:@"<<I"]) {
            
            
            NSString  *string = [contnetString substringToIndex:i];
            [self shengchengContent:string with:contentArr withFlage:5];
            contnetString =[contnetString substringFromIndex:i+5];
            i=-1;
            continue;
        }
        if ([tagString isEqualToString:@"<u>"])
        {
            NSString *string = [contnetString substringToIndex:i];
            [self shengchengContent:string with:contentArr withFlage:1];
            contnetString = [contnetString substringFromIndex:i+3];
            i=-1;
            continue;
        }
        if ([tagString isEqualToString:@"</u"])
        {
            NSString *string = [contnetString substringToIndex:i];
            [self shengchengContent:string with:contentArr withFlage:7];
            contnetString = [contnetString substringFromIndex:i+4];
            i=-1;
            continue;
            
        }
        if ([tagString isEqualToString:@"<i>"])
        {
            NSString *string = [contnetString substringToIndex:i];
            [self shengchengContent:string with:contentArr withFlage:1];
            contnetString = [contnetString substringFromIndex:i+3];
            i=-1;
            continue;
            
        }
        
        if ([tagString isEqualToString:@"</i"])
        {
            NSString *string = [contnetString substringToIndex:i];
            [self contentShengChengXieti:string with:contentArr];
           
            contnetString = [contnetString substringFromIndex:i+4];
            i=-1;
            continue;
        }

    }
    [self shengchengContent:contnetString with:contentArr withFlage:1];
    
    //6 生成里面的内容
    self.mycontentArr = contentArr;
    
}


- (void)contentShengChengXieti:(NSString *)xietiContetn  with:(NSMutableArray *)contentArr
{
    CGFloat  pointSize = self.mySHowContModel.textFont.pointSize;
    
    UIFont  *font = [UIFont italicSystemFontOfSize:pointSize];
    UIColor  *fontColor = self.mySHowContModel.textColor;
    
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(20 * (CGFloat)M_PI / 180), 1, 0, 0);
    
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:@"Baskerville-Bold" matrix:matrix];
    
    font = [UIFont fontWithDescriptor:desc size:17];
    NSAttributedString  *string = [[NSAttributedString alloc] initWithString:xietiContetn attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:fontColor}];
    contentModel  *mymodel = [contentModel contentModelWith:96 withImage:nil];
    mymodel.content = string;
    [contentArr addObject:mymodel];
    
}
- (void)contentshengCheng:(TYTextContainer *)mycontent wihthModel:(contentModel *)model
{
    int  flage = model.flage;
    
    switch (flage)
    {
        case 1:
            [mycontent appendTextAttributedString:model.content];
            break;
        case 2:
            [mycontent appendTextAttributedString:model.content];
            break;
        case 3:
           [mycontent appendTextAttributedString:model.content];
           [mycontent appendImage:self.gongshiImaeArr[gsJiShu] size:[self getImageSIze:((UIImage *)self.gongshiImaeArr[gsJiShu]).size]  alignment:TYDrawAlignmentCenter];
            gsJiShu++;
            break;
        case 5:
            [mycontent appendTextAttributedString:model.content];
            [self addimagewithUrl:mycontent];
            break;
        case 4:
            [mycontent appendTextAttributedString:model.content];
            break;
        case 100:
            [mycontent appendImage:model.geshiImage];
            break;
        case 99:
            [mycontent appendImage:model.geshiImage size:model.geshiImage.size alignment:TYDrawAlignmentButtom];
            break;
        case 6:
            [mycontent appendTextAttributedString:model.content];
            break;
        case 7:
            [mycontent appendTextAttributedString:model.content];
            break;
        case 96:
            [mycontent appendTextAttributedString:model.content];
            break;
            
        default:
            break;
    }
    
}
- (void)addimagewithUrl:(TYTextContainer *)mycontent
{
    
     UIImage  *image = [self.getContetntImage getImageWithImageIndex:imageJishu];
     ClickImage  *myClickImage = [[ClickImage alloc] initWithImage:image];
     CGSize  imageSize = [self getImageSIze:image.size];
     myClickImage.frame = CGRectMake(0, 0,imageSize.width,imageSize.height);
    myClickImage.canClick = YES;
    [mycontent appendView:myClickImage ];
    imageJishu++;
   
}

- (void)shengchengContent:(NSString *)content  with:(NSMutableArray *)contentArr withFlage:(int) flage
{
     NSDictionary *contextdict;
    if (flage == 1 || flage==3 ||flage == 4 || flage == 5)
    {
        contextdict = self.nomalDict;
    }
    if (flage == 2)
    {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
         paraStyle.lineSpacing = self.mySHowContModel.lineSpace;
        CGFloat pointSize = self.mySHowContModel.textFont.pointSize;
        UIFont  *font = [UIFont boldSystemFontOfSize:pointSize];
         contextdict =@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:font,NSForegroundColorAttributeName:self.mySHowContModel.textColor};
    }
    if (flage == 7)
    {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = self.mySHowContModel.lineSpace;
        NSNumber  *linNume = [NSNumber numberWithInteger:NSUnderlineStyleThick];
        CGFloat  pointSize = self.mySHowContModel.textFont.pointSize;
        UIFont  *undelerLineFont = [UIFont systemFontOfSize:pointSize];
        contextdict =@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:undelerLineFont,NSForegroundColorAttributeName:self.mySHowContModel.textColor,NSUnderlineStyleAttributeName:linNume};
    }
    if (flage == 6)
    {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = self.mySHowContModel.lineSpace;
         NSNumber  *qingxie = [NSNumber numberWithFloat:10.0];
        contextdict =@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:self.mySHowContModel.textFont,NSForegroundColorAttributeName:[UIColor redColor],NSObliquenessAttributeName:qingxie};
        NSShadow  *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 5;
        shadow.shadowColor = [UIColor blueColor];
        shadow.shadowOffset = CGSizeMake(1, 3);
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        
        paragraph.alignment = NSTextAlignmentCenter;
        
       contextdict =@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:16],//文本的颜色 字体 大小
                                NSObliquenessAttributeName:@100
                               };
        
    }
    NSAttributedString  *mytext =  [[NSAttributedString alloc] initWithString:content attributes:contextdict];
    
    contentModel  *model = [contentModel contentModelWith:flage withContent:mytext];
    [contentArr addObject:model];
}

- (void)addsubAndSupwith:(NSString *)string withArrr:(NSMutableArray *)contentArr
{
    
    NSInteger lenth = string.length;
    NSString *flageString =[string substringWithRange:NSMakeRange(lenth-3, 3)];
    contentModel  *mymodel;
    if ([flageString isEqualToString:@"up>"])
    {
        NSString  *showString = [string substringToIndex:lenth-6];
        UIImage   *shangbiao = [self shengchengShangbiao:showString];
        mymodel= [contentModel contentModelWith:100 withImage:shangbiao];
        
    }else
    {
        UIImage   *shangbiao = [self shengchengXiabiao:[string substringToIndex:lenth-6]];
        mymodel = [contentModel contentModelWith:99 withImage:shangbiao];
    }
    [contentArr addObject:mymodel];
}

- (NSString *)relaceImageContent:(NSString *)contentString withImagerArr:(NSMutableArray *)imageArr
{
    contentString = [contentString stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
    for (NSInteger  i=0; i<imageArr.count; i++)
    {
        contentString =[contentString stringByReplacingOccurrencesOfString:imageArr[i] withString:@"<<I>>"];
    }
    return contentString;
}
- (NSMutableArray *)getImageArr:(NSString *)str
{
    NSMutableArray *metchers=[[NSMutableArray alloc]init];
    NSInteger  index = 0;
    for (NSInteger i=0; i<str.length-3; i++)
    {
        
        NSString *flageString = [str substringWithRange:NSMakeRange(i, 4)];
        if ([flageString isEqualToString:@"{img"])
        {
            index = i;
            
        }
        if ([flageString isEqualToString:@"png}"] || [flageString isEqualToString:@"jpg}"])
        {
            NSString  *imagString = [str substringWithRange:NSMakeRange(index, i-index+4)];
            [metchers addObject:imagString];
        }
        
    }
    return metchers;
}
- (void)shengChengWenBenContent:(NSMutableArray *)contentArr
{
    gsJiShu = 0;
    imageJishu = 0;
    TYTextContainer  *textContrler= [[TYTextContainer alloc] init];
    for (NSInteger i =0; i<self.mycontentArr.count; i++)
    {
       contentModel  *model = self.mycontentArr[i];
       [self contentshengCheng:textContrler wihthModel:model];
    }
    self.mycontent.backgroundColor = self.mySHowContModel.backgroudColor;
    self.mycontent.textContainer = textContrler;
    [self.mycontent setFrameWithOrign:CGPointMake(self.mySHowContModel.jianju, self.mySHowContModel.jianju) Width:self.width-2*self.mySHowContModel.jianju];
    self.kongjianSize = [self.mycontent getSize];
    if ([_delegete respondsToSelector:@selector(TYHShowViewWillShow:withFlag:)])
    {
        [_delegete TYHShowViewWillShow:CGSizeMake(self.kongjianSize.width, self.kongjianSize.height+10) withFlag:self.shengchengflag];
    }
}

- (CGSize)getImageSIze:(CGSize )size
{
    CGFloat  width;
    CGFloat  height;
    if (size.width>self.width)
    {
        width = self.width-self.mySHowContModel.jianju;
        height = size.height*(width/size.width);
    }else
    {
        return  size;
    }
    return CGSizeMake(width, height);
}

- (NSString *)huoquGonshiWithString:(NSString *)contentString
{
    NSMutableArray  *gongshiArr =[NSMutableArray array];
     NSString* newString = @"";
    
    if (contentString.length>0) {
        //处理公式
        int  indexEnd = -1;   //记录每一轮最后一个>的位置
        int index=-1;
        
        for (int i = 0; i < contentString.length - 1; i++)
        {
            NSString* str1 = [contentString substringWithRange:NSMakeRange(i, 2)];
            if ([str1 isEqualToString:@"<<"])
            {
                if (i > 0 && indexEnd + 1 < i)
                {
                    newString= [newString stringByAppendingString:[contentString  substringWithRange:NSMakeRange(indexEnd+1, i-indexEnd-1)]];
                }
                index = i;
                i += 2;
                continue;
            }
            if ([str1 isEqualToString:@">>"]&&index>-1) {
                NSString* latex = [contentString substringWithRange:NSMakeRange(index+2, i-index-2)]; //获得公式
                [gongshiArr addObject:latex];
                
                NSString  *path = @"<<G>>";
                newString = [newString stringByAppendingString:path ];
                indexEnd = i + 1;
                
            }
        }
        if (indexEnd < contentString.length - 1)
        {
            newString = [newString stringByAppendingString:[contentString  substringFromIndex:indexEnd+1]]   ;
        }
    }
    if (gongshiArr.count==0)
    {
        gongshiSuccss = YES;
        return contentString;
    }
    self.gongshiArr = gongshiArr;
 
    return  newString;

}


//这里生成公式
- (void)setGongshiArr:(NSMutableArray *)gongshiArr
{
    _gongshiArr = gongshiArr;
    
    [self   huaGongshi:gongshiArr];

}

- (void)huaGongshi:(NSMutableArray *)stringGongshiArr
{
    
    TYHDrawMathManger  *manager = [TYHDrawMathManger shareTYHDrawMathManger];
    manager.textColor = self.mySHowContModel.textColor;
    manager.textFont = self.mySHowContModel.textFont;
    CGFloat  textSize = self.mySHowContModel.textFont.pointSize;
    manager.smallTextFont = [UIFont systemFontOfSize:textSize*0.7];
    manager.mathFlag = self.mySHowContModel.mathFlag;
    manager.fontSize = textSize;
    manager.backGroundClolor = self.mySHowContModel.backgroudColor;
    
    //这里开启线程进行生成公式
    dispatch_queue_t myque = dispatch_queue_create("mymathQue", nil);
    dispatch_async(myque,  ^{
        NSMutableArray  *imagerArr = [manager drawAllMathExpresswithArr:stringGongshiArr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.gongshiImaeArr = imagerArr;
            
        });
        
    });
}

 // 这里下载内容里面的图片

- (void)getContentImage:(NSMutableArray *)metchers
{
    
    if (metchers.count==0||metchers==nil)
    {
        imageSuceess = YES;
        return  ;
    }
    NSMutableArray  *imagePatharr = [NSMutableArray array];
    
    int  count  = (int)metchers.count;
    
    for (int i = 0; i<count; i++)
    {
        NSString *picID=[metchers objectAtIndex:i];
        picID=[picID stringByReplacingOccurrencesOfString:@"{img," withString:@""];
        picID=[picID stringByReplacingOccurrencesOfString:@"}" withString:@""];

        NSString  *path= [NSString stringWithFormat:@"%@/Support/Download.aspx?NewsPicture=%@",DOCUMENTYM,picID];
        [imagePatharr addObject:path];
        
    }
    
    TYHGetContentImage  *contentImage = [TYHGetContentImage getTYHContentImage:imagePatharr with:self.mySHowContModel.baseUrl];
    contentImage.delegate = self;
    self.getContetntImage  = contentImage;
}

- (void)contentImageDidGet
{
    //内容里面的图片已经下载完成
    imageSuceess = YES;
    [self  isShowConent];
}


- (UIImage *)shengchengShangbiao:(NSString *)shangContent
{
    CGFloat  fontPonintSize = self.mySHowContModel.textFont.pointSize;
    UIFont  *font = [UIFont systemFontOfSize:fontPonintSize*0.8];
    
    UIColor  *fontColor = self.mySHowContModel.textColor;
    UIColor  *backColor = self.mySHowContModel.backgroudColor;

    CGSize  shangSize = [shangContent sizeWithFont:self.mySHowContModel.textFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
     UIGraphicsBeginImageContextWithOptions(CGSizeMake(shangSize.width, shangSize.height*(1.2)) , NO, 0);
    //1.获取bitmap上下文
   
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [backColor set];
    CGContextAddRect(ctx, CGRectMake(0.0f, 0.0f, shangSize.width, shangSize.height));
    CGContextFillPath(ctx);
    [shangContent drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:fontColor}];
    
    //4.获取生成的图片
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    return image;
    
}
- (UIImage *)shengchengxieti:(NSString *)xietiContent
{
    
    UIColor  *fontColor = self.mySHowContModel.textColor;
    NSAttributedString  *xieti = [[NSAttributedString alloc] initWithString:xietiContent attributes:@{NSFontAttributeName:self.mySHowContModel.textFont,NSForegroundColorAttributeName:fontColor,NSObliquenessAttributeName:@1}];
    CGSize   xietiSize = xieti.size;
     UIGraphicsBeginImageContextWithOptions(CGSizeMake(xietiSize.width+4, xietiSize.height) , NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor greenColor] set];
    CGContextAddRect(ctx, CGRectMake(0.0f, 0.0f, xietiSize.width, xietiSize.height));
    CGContextFillPath(ctx);
    [xieti drawAtPoint:CGPointMake(0, 0)];
    
    //4.获取生成的图片
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    return image;
    
}
- (UIImage *)shengchengXiabiao:(NSString *)shangContent
{
    CGFloat  fontPonintSize = self.mySHowContModel.textFont.pointSize;
    UIFont  *font = [UIFont systemFontOfSize:fontPonintSize*0.8];
    UIColor  *fontColor = self.mySHowContModel.textColor;
    UIColor  *backColor = self.mySHowContModel.backgroudColor;
    CGSize  shangSize = [shangContent sizeWithFont:self.mySHowContModel.textFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(shangSize.width, shangSize.height*1.2) , NO, 0);
    //1.获取bitmap上下文
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [backColor set];
    CGContextAddRect(ctx, CGRectMake(0.0f, 0.0f, shangSize.width, shangSize.height*1.2));
    CGContextFillPath(ctx);
    
    [shangContent drawAtPoint:CGPointMake(0, shangSize.height*0.2) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:fontColor}];
    
    //4.获取生成的图片
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    return image;
    
}


- (CGSize )getTYHShowSzie
{
    return _kongjianSize;
}

-(void)setGongshiImaeArr:(NSMutableArray *)gongshiImaeArr
{
    _gongshiImaeArr = gongshiImaeArr;
    gongshiSuccss = YES;
    [self isShowConent];
    
}


- (void)setMycontentArr:(NSMutableArray *)mycontentArr
{
    _mycontentArr = mycontentArr;
    conetnetSucee = YES ;
    [self isShowConent];
}
- (void)isShowConent
{
    if (imageSuceess==YES &&gongshiSuccss == YES && conetnetSucee ==YES)
    {
        
        [self shengChengWenBenContent:self.mycontentArr];
    }
    
}

- (int)changeFont:(UIFont *)font;
{
    self.mySHowContModel.textFont = font;
    self.mySHowContModel.lineSpace = 15*0.2;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = self.mySHowContModel.lineSpace;
    self.nomalDict =  @{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:self.mySHowContModel.textFont,NSForegroundColorAttributeName:self.mySHowContModel.textColor};
    self.shengchengflag = 1;
    gongshiSuccss = NO;
    conetnetSucee = NO;
    [self huaGongshi:self.gongshiArr];
    [self jiexieContentAndImage:self.contetnString];
    return  1;

}


- (void)setMySHowContModel:(TYHShowContenModel *)mySHowContModel
{
    _mySHowContModel = mySHowContModel;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = self.mySHowContModel.lineSpace;
    self.nomalDict =  @{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:self.mySHowContModel.textFont,NSForegroundColorAttributeName:self.mySHowContModel.textColor};
    
}
- (void)changeStyle
{
    self.shengchengflag = 1;
    self.backgroundColor = self.mySHowContModel.backgroudColor;
    self.mySHowContModel.backgroudColor = self.mySHowContModel.backgroudColor;
    self.mySHowContModel.textColor = self.mySHowContModel.textColor;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = self.mySHowContModel.lineSpace;
    self.nomalDict =  @{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:self.mySHowContModel.textFont,NSForegroundColorAttributeName:self.mySHowContModel.textColor};
    gongshiSuccss  = NO;
    conetnetSucee = NO;
    [self huaGongshi:self.gongshiArr];
    [self jiexieContentAndImage:self.contetnString];

}
@end
