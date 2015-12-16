//
//  PLLIst.h
//  LYrecite
//
//  Created by 李瑶 on 15/11/9.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLLIst : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) int contentID;
@property (nonatomic,assign) BOOL isMy;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)UIViewController* con;
@property (nonatomic,strong)NSString* url;
@property(nonatomic, assign) BOOL isXP;
-(void)reloadDataInfo;
@end
