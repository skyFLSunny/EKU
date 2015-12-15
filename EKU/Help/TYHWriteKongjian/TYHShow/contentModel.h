//
//  contentModel.h
//  HppleDemo
//
//  Created by tanyuehong on 15/10/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface contentModel : NSObject

@property (nonatomic,assign) int  flage;

@property (nonatomic,strong) NSAttributedString  *content;

@property (nonatomic,strong) UIImage   *geshiImage;
+ (instancetype)contentModelWith:(int)flag withContent:(NSAttributedString *)content;
+ (instancetype)contentModelWith:(int)flag withImage:(UIImage *)geShiImage;



@end
