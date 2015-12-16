//
//  CusHoriListView.m
//  CustomControl
//
//  Created by Qianshanzhicheng on 15/12/15.
//  Copyright © 2015年 Qianshanzhicheng. All rights reserved.
//

#import "CusHoriListView.h"

@implementation CusHoriListView
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _dataArray = [NSMutableArray array];
        [self initTitle];
        [self initHoriListView];
    }
    return self;
}
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [_listView reloadData];
}
- (void)initTitle
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.width - 40, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = DAYTEXTCOLOR;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _leftSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 3, 24)];
    _leftSep.backgroundColor = SUBJECTCOLOR[3];
    
    _sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29.5, self.frame.size.width, 0.5)];
    _sepLabel.backgroundColor = DAYBACKCOLOR;
    [self addSubview:_sepLabel];
    [self addSubview:_leftSep];
    [self addSubview:_titleLabel];
}
- (void)initHoriListView{
  
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _listView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 30) collectionViewLayout:layout];
    _listView.showsHorizontalScrollIndicator = NO;
    _listView.delegate = self;
    _listView.dataSource = self;
    [_listView registerClass:[HoriListViewCell class] forCellWithReuseIdentifier:@"item"];
    
      [self addSubview:_listView];
  
}
#pragma mark - UICollection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!_dataArray) {
        return 0;
    }
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HoriListViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.titleLabel.text =@"不等式1";
      cell.subLable.text =@"不等式1";
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width/3, self.frame.size.height - 30);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setStyle
{
    
}
@end
