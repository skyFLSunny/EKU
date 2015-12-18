//
//  EKUPracticeController.m
//  EKU
//
//  Created by ruoyi on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EKUPracticeController.h"
#import "EKUPrecticeSectionView.h"
#import "EKUPracticesCollectionCell.h"

@interface EKUPracticeController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
	__weak IBOutlet UICollectionView *mainView;
	NSArray *titleArr;
	NSArray *dataArr;
}
@end


@implementation EKUPracticeController

- (void)viewDidLoad{
	[super viewDidLoad];

	[self prefectUI];
}
- (void)prefectUI{
	self.title = @"练习";
	titleArr = @[@"高考真题 & 模拟题",@"知识点"];
	dataArr = @[
				@[
					@{@"text":@"语文",
					  @"image":@"yuwen"},
					@{@"text":@"数学",
					  @"image":@"shuxue"},
					@{@"text":@"文数",
					  @"image":@"wenshu"},
					@{@"text":@"英语",
					  @"image":@"yingyu"},
					@{@"text":@"物理",
					  @"image":@"wuli"},
					@{@"text":@"化学",
					  @"image":@"huaxue"},
					@{@"text":@"生物",
					  @"image":@"shengwu"},
					@{@"text":@"历史",
					  @"image":@"lishi"},
					@{@"text":@"地理",
					  @"image":@"dili"},
					@{@"text":@"政治",
					  @"image":@"zhengzhi"},
					],
				@[
					@{@"text":@"语文",
					  @"image":@"yuwen"},
					@{@"text":@"文数",
					  @"image":@"wenshu"},
					@{@"text":@"英语",
					  @"image":@"yingyu"},
					@{@"text":@"地理",
					  @"image":@"dili"},
					@{@"text":@"政治",
					  @"image":@"zhengzhi"},
					],
				];
	self.automaticallyAdjustsScrollViewInsets = NO;
	mainView.delegate = self;
	mainView.dataSource = self;
	mainView.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	NSArray *tmp = dataArr[section];
	return tmp.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	EKUPracticesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EKUPracticesCollectionCell" forIndexPath:indexPath];
	NSDictionary *tmpDic = dataArr[indexPath.section][indexPath.item];
	[cell.collectionBtn setTitle:tmpDic[@"text"] forState:UIControlStateNormal];
	[cell.collectionBtn setImage:[UIImage imageNamed:tmpDic[@"image"]] forState:UIControlStateNormal];
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
	if (kind == UICollectionElementKindSectionHeader){
		EKUPrecticeSectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EKUPrecticeSectionView" forIndexPath:indexPath];
		headerView.titleLabel.text = titleArr[indexPath.section];
		return headerView;
	}
	return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

	return CGSizeMake(90, 60);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
	return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
	return CGSizeMake(collectionView.frame.size.width, 50);
}


@end
