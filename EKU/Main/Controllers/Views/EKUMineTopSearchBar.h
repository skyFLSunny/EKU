//
//  EKUMineTopSearchBar.h
//  EKU
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EKUMineTopSearchBarDelegate<NSObject>
//点击yk
-(void)ykButtonClickedWithSearchText:(NSString *)searchText;
//点击搜索
-(void)searchButtonClickWithSearchText:(NSString *)searchText;
@end

@interface EKUMineTopSearchBar : UIView
@property (nonatomic,weak) id<EKUMineTopSearchBarDelegate> delegate;
@end
