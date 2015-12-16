//
//  contentModel.m
//  HppleDemo
//
//  Created by tanyuehong on 15/10/16.
//
//

#import "contentModel.h"

@implementation contentModel

+ (instancetype)contentModelWith:(int)flag withContent:(NSAttributedString *)content
{
    contentModel  *mymodel = [[contentModel alloc] init];
    
    mymodel.flage = flag;
    mymodel.content = content;
    
    return mymodel;
}

+ (instancetype)contentModelWith:(int)flag withImage:(UIImage *)geShiImage
{
    
    contentModel  *mymodel = [[contentModel alloc] init];
    
    mymodel.flage = flag;
    mymodel.geshiImage = geShiImage;
    
    return mymodel;
    
}

@end
