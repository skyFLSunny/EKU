//
//  infoBtn.h
//  EKU
//
//  Created by 李瑶 on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoDelegate.h"
@interface infoBtn : UIButton
@property (nonatomic, assign)id<InfoDelegate> delegate;
@end
