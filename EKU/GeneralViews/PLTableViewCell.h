//
//  PLTableViewCell.h
//  LYrecite
//
//  Created by liyao on 15/7/1.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "plModel.h"
#import "plModelFrame.h"

#import "plzhanBtn.h"

@protocol cellDeletClickDelegate <NSObject>
@optional

- (void)cellDeleteBtnClick:(plModelFrame *)model;

@end
@interface PLTableViewCell : UITableViewCell

- (IBAction)presspl:(id)sender;
- (IBAction)presshf:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tximage;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *pllabel;
@property (nonatomic, assign) id<cellDeletClickDelegate> delegate;
@property (weak, nonatomic) UILabel *flowerContLable;
@property (weak, nonatomic) IBOutlet UILabel *znum;
@property (weak, nonatomic) IBOutlet UILabel *hfnum;
@property (weak, nonatomic) IBOutlet UILabel *sep;
typedef void (^plpress)();
typedef void (^hfpress)();
@property (nonatomic, strong)plpress plbtn;
@property (nonatomic, strong)UIViewController* con;
@property (nonatomic, strong)UIImageView* imageVie;
@property (weak, nonatomic) IBOutlet UIButton *zbtn;
@property (strong, nonatomic)  UIButton *wzbtn;
@property (nonatomic, strong)hfpress hfbtn;
@property (nonatomic, strong)plModelFrame* model;

//新修改的里面赞的btn
@property (nonatomic,weak)plzhanBtn  *zhanbtn;
@property (nonatomic, assign) BOOL isxp;
+ (instancetype)cellWithTableVieplCell:(UITableView *)tableView;
-(void)setStyle;
@end
