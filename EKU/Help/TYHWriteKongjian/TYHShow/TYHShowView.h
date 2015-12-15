//
//  TYHShowView.h
//  HppleDemo
//
//  Created by tanyuehong on 15/10/14.
//
//

#import <Foundation/Foundation.h>
#import "TYAttributedLabel.h"
#import "TYHShowContenModel.h"



@protocol TYHShowViewWillShow <NSObject>

@optional
/**
 
   参数说明  flag  0 表示初始化生成   1表示更新
 */
- (void)TYHShowViewWillShow:(CGSize )size   withFlag:(int) flag;

@end

@interface TYHShowView : UIView

//根据配置模型生成控件


- (void)shengchengNeiRong:(NSString *)contentString  withModel:(TYHShowContenModel *)model  with:(id)delegate;
//对控件新增返回控件大小的方法

- (CGSize )getTYHShowSzie;


@property (nonatomic,weak) id  <TYHShowViewWillShow> delegete;

- (void)changeStyle;

- (int)changeFont:(UIFont *)font;

@end
