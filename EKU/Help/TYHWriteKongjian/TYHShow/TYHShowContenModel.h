//
//  TYHShowContenModel.h
//  HppleDemo
//
//  Created by tanyuehong on 15/10/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TYHShowContenModel : NSObject

//文字大小和类型
@property (nonatomic,strong) UIFont *textFont;

//控件左右间距  默认为6
@property (nonatomic,assign) CGFloat  jianju;

/**
 *  控件大小
 *
 *  @param   none
 */
@property (nonatomic,assign)CGSize  kongjianSize;

/**
 *  文字颜色
 *
 *  @param   none
 */
@property (nonatomic,strong) UIColor   *textColor;

/**
 *     背景颜色
 *
 */

@property (nonatomic,strong) UIColor    *backgroudColor;

/**
*   是否为数学公式
*
*  @param    0  不是数学公式   1 表示时数学 公式  2－－表示时音频数据
*/

@property (nonatomic,assign) int    mathFlag;

/**
 *     设置 行距  的属性
 *
 *   此数 值 为   行 距 大小  正的 加大  负得 减小
 */


@property (nonatomic,assign) CGFloat  lineSpace;


/**
 *     头部 距离内容的间距  默认为6
 *
 *
 */
@property (nonatomic,assign) NSInteger  magrging;

/**
 *
 *   这个是用来指定图片的基本路径
 */
@property (nonatomic,strong) NSString  *baseUrl;




@end
