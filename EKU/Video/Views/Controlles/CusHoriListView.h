//
//  CusHoriListView.h
//  CustomControl
//
//  Created by Qianshanzhicheng on 15/12/15.
//  Copyright © 2015年 Qianshanzhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HoriListViewCell.h"
@interface CusHoriListView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * leftSep;
@property (nonatomic,strong)UILabel * sepLabel;// 副标题
@property (nonatomic,strong) UICollectionView * listView;
@property (nonatomic,strong) NSMutableArray * dataArray;
- (id)initWithFrame:(CGRect)frame;
@end
