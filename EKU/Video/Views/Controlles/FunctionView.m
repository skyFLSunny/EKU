//
//  FunctionView.m
//  CustomControl
//
//  Created by Qianshanzhicheng on 15/12/14.
//  Copyright © 2015年 Qianshanzhicheng. All rights reserved.
//

#import "FunctionView.h"

#define BaseTag ((int)300)
@implementation FunctionView
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
    otherFuncSeImgs:(NSArray *)otherFuncSeImgs
{
    if (self = [super initWithFrame:frame])
    {
        CGFloat height = 40;
        
        // title
        _titleBtn = [[LeftBtn alloc]initWithFrame:CGRectMake(10, (frame.size.height - height)/2, (frame.size.width - 40)/2, 40)];
        _titleBtn.tag = BaseTag;
        
        [_titleBtn setTitle:title forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:titleImg] forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:titleSeImg] forState:UIControlStateHighlighted];
        [_titleBtn addTarget:self action:@selector(funcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleBtn setTitleColor:DAYTEXTCOLOR forState:UIControlStateNormal];
        _titleBtn.titleLabel.font = SMALLFONT;
        
        [self addSubview:_titleBtn];
        
        [self addFuncBtnByNormalImgs:otherFunImgs selectImgs:otherFuncSeImgs];
    }
    return self;
}
- (void)addFuncBtnByNormalImgs:(NSArray *)normalImgs selectImgs:(NSArray *)selectImgs{
    if (normalImgs == nil||!normalImgs.count) {
        return;
    }
    CGFloat height = self.frame.size.height;
    CGFloat x = SCREENWIDTH- height*4 ;
    CGFloat y = (self.frame.size.height - height)/2;
    CGFloat space = height;
    for (int i = 0; i < normalImgs.count; i ++) {
        UIButton * funcBtn = [[UIButton alloc]initWithFrame:CGRectMake(x +i *space , y, space, height)];
        funcBtn.tag = BaseTag+ 1 + i;
        [funcBtn setImage:[UIImage imageNamed:normalImgs[i]] forState:UIControlStateNormal];
        if (selectImgs&&selectImgs.count>i) {
            [funcBtn setImage:[UIImage imageNamed:selectImgs[i]] forState:UIControlStateHighlighted];
        }
        [funcBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15,15)];
        [funcBtn addTarget:self action:@selector(funcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:funcBtn];
    }
}
- (void)setBlock:(FuncClickBlock)block{
    _block = block;
}
- (void)funcBtnClick:(UIButton *)btn{
    if (_block) {
        _block(btn.tag - BaseTag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
