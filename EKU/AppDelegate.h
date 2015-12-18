//
//  AppDelegate.h
//  EKU
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "PersonalViewController.h"

#import "VideoViewController.h"
@class EKUPracticeController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) NSUInteger isShowError;
@property (strong, nonatomic) NSArray*normalImageArray;
@property (strong, nonatomic) NSArray*selectedImageArray;
@end

