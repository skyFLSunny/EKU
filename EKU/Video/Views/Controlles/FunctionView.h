//
//  FunctionView.h
//  CustomControl
//
//  Created by Qianshanzhicheng on 15/12/14.
//  Copyright © 2015年 Qianshanzhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftBtn.h"
typedef void (^FuncClickBlock)(NSInteger index);

@interface FunctionView : UIButton

@property (nonatomic,strong) LeftBtn * titleBtn;
@property (nonatomic,copy)   FuncClickBlock block;
/**
 * @param frame 
 * @param title 左侧标题
 * @param titleImg 标题常态图片
 * @param titleSeImg 标题高亮图片
 * @param otherFunImgs 其他按钮常态图片数组
 * @param otherFuncSeImgs 其他按钮高亮图片数组
 * return ''
 */
- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
         titleImage:(NSString *)titleImg
         titleSeImg:(NSString *)titleSeImg
      otherFuncImgs:(NSArray *)otherFunImgs
    otherFuncSeImgs:(NSArray *)otherFuncSeImgs;

@end
