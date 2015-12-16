//
//  MJDIYHeader.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefreshGifHeader.h"

typedef enum {
    /** 普通闲置状态 */
    TYRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    TYRefreshStatePulling,
    /** 正在刷新中的状态 */
    TYRefreshStateRefreshing

} TYRefreshLable;

@interface MJDIYHeader : MJRefreshGifHeader
@property (weak, nonatomic) UILabel *label;

- (void)setTyRefreshLable:(NSString *)titile titilesSate:(int) state;
@end
