//
//  TYHGetContentImage.h
//  LYrecite
//
//  Created by tanyuehong on 15/10/30.
//  Copyright © 2015年 liyao. All rights reserved.
//

#import <Foundation/Foundation.h>


//这个类 的作用时用来获取文章显示的图片

//里面封装 图片的缓存 的功能
@protocol TYHGetContentImageDelegate <NSObject>

@optional

- (void)contentImageDidGet;

@end
@interface TYHGetContentImage : NSObject

@property (nonatomic,weak ) id <TYHGetContentImageDelegate>  delegate;

+ (instancetype)getTYHContentImage:(NSMutableArray *)imagePath with:(NSString *)baseUrl;

- (UIImage  *)getImageWithImageIndex:(NSInteger )imageIndex;



@end
