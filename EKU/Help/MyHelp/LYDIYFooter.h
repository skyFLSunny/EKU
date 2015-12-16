//
//  LYDIYFooter.h
//  LYrecite
//
//  Created by tanyuehong on 15/8/5.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import "MJRefreshBackGifFooter.h"


typedef enum {
    /** 普通闲置状态 */
    footerTYRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    footerTYRefreshStatePulling,
    /** 正在刷新中的状态 */
    footerTYRefreshStateRefreshing
    
} footerTYRefreshLable;


@interface LYDIYFooter : MJRefreshBackGifFooter

- (void)setTyFooterRefreshLable:(NSString *)titile titilesSate:(int) state;
@end
