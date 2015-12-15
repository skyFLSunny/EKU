//
//  videoTableViewCell.h
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoTableViewCell : UITableViewCell
+ (instancetype)cellWithTableViewCell:(UITableView *)tableView withArray:(NSArray*)aArray withName:(NSString*)aName;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray*)aArray withName:(NSString*)aName;
-(void)setSepColor:(NSInteger)aNum;
@end
