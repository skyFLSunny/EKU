//
//  ViewTag.h
//  KGKit
//
//  Created by chen on 14-5-29.
//  Copyright (c) 2014年 14zynr. All rights reserved.
//

#ifndef KGKit_ViewTag_h
#define KGKit_ViewTag_h

#define kNOTIFICATION_REFRESHREWARDWALL  @"NOTIFICATION_REFRESHREWARDWALL"

#define isIpad      ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

//颜色和透明度设置
#define RGBA(r,g,b,a)               [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

/* { thread } */
#define __async_opt__  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define __async_main__ dispatch_async(dispatch_get_main_queue()

#endif
