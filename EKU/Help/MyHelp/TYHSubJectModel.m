//
//  TYHSubJectModel.m
//  LYrecite
//
//  Created by tanyuehong on 15/11/11.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import "TYHSubJectModel.h"

#define   SubjectTITle  @"sbjectTitle"
#define   StateIDMY     @"DownLoadState"
#define   SubjectId     @"subjectId"
#define   DownLoadPreCent @"perSent"
#define   DownLoadArr   @"downLoadArr"
#define   SuceessArr    @"suceessArr"
#define   DownLoadImageArr   @"DownLoadImageArr"
#define   DownLoadImageSUceesArr  @"DownloadImageSucess"
#define   ImageCountmy    @"MYImageCont"
#define   NewDownLoadPerSon  @"downloadPriecnentWith"
#define   SuceesFished      @"sucessFished"


@implementation TYHSubJectModel


-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder  encodeObject:self.title forKey:SubjectTITle];
    [encoder  encodeInt:self.subjectId forKey:SubjectId];
    [encoder  encodeInteger:self.stata forKey:StateIDMY];
    [encoder encodeInteger:self.downLoadPerSent forKey:NewDownLoadPerSon];
    [encoder  encodeInteger:self.ContentCount forKey:DownLoadPreCent];
    [encoder  encodeInteger:self.ImageCount forKey:ImageCountmy];
     [encoder  encodeInteger:self.Finshed forKey:SuceesFished];
    [encoder  encodeObject:self.downLoadArr forKey:DownLoadArr];
    [encoder  encodeObject:self.downLoadImageArr forKey:DownLoadImageArr];
    
}

-(id)initWithCoder:(NSCoder*)decoder
{
    self.title = [decoder decodeObjectForKey:SubjectTITle];
    self.subjectId = [decoder decodeInt32ForKey:SubjectId];
    self.ContentCount = [decoder decodeIntegerForKey:DownLoadPreCent];
    self.ImageCount = [decoder decodeIntegerForKey:ImageCountmy];
    self.Finshed = [decoder decodeIntegerForKey:SuceesFished];
    self.downLoadPerSent = [decoder decodeIntegerForKey:NewDownLoadPerSon];
    self.stata = [decoder  decodeIntegerForKey:StateIDMY];
    self.downLoadArr = [decoder decodeObjectForKey:DownLoadArr];
    self.downLoadImageArr = [decoder decodeObjectForKey:DownLoadImageArr];
    return  self;
}

- (NSMutableArray *)downLoadImageArr
{
    if (_downLoadImageArr == nil)
    {
        _downLoadImageArr = [NSMutableArray array];
    }
    return  _downLoadImageArr;
}

@end
