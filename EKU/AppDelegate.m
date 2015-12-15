//
//  AppDelegate.m
//  EKU
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
{
    MainViewController *main;
    PersonalViewController *perSon;
    TestViewController *test;
    VideoViewController *video;
    
    UITabBarController *tabBarCon;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self initControllers];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 创建tabbar
- (void)initControllers
{
    // 创建Controller
    main = [[MainViewController alloc] init];
    video = [[VideoViewController alloc] init];
    test = [[TestViewController alloc] init];
    perSon = [[PersonalViewController alloc] init];
    UINavigationController* mainNav = [[UINavigationController alloc] initWithRootViewController:main];
    UINavigationController* videoNav = [[UINavigationController alloc] initWithRootViewController:video];
    UINavigationController* testNav = [[UINavigationController alloc] initWithRootViewController:test];
    UINavigationController* personalNav = [[UINavigationController alloc] initWithRootViewController:perSon];
    tabBarCon = [[UITabBarController alloc] init];
    tabBarCon.viewControllers = @[mainNav,videoNav,testNav,personalNav];
    
   
    
    self.window.rootViewController = tabBarCon;
    [self.window makeKeyAndVisible];
    
    [self setTabBarStyle:self.normalImageArray selectArray:self.selectedImageArray back:DAYFOOTBACKCLOR text:[UIColor blackColor] select:DAYTOPBACKCOLOR];

    
}


// 设置TabBar样式
- (void)setTabBarStyle:(NSArray*)normalArray selectArray:(NSArray*)selelctedarray back:(UIColor*)backColor text:(UIColor*)textColor select:(UIColor*)selectColor
{
    
    NSArray *items = @[@"首页", @"视频", @"练习", @"我的"];
    UITabBar *tabBar = tabBarCon.tabBar;
    for (NSInteger i=0; i<items.count; i++)
    {
        UITabBarItem *tabBarItem = tabBar.items[i];
        
        tabBarItem.selectedImage = [[UIImage imageNamed:selelctedarray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem.image = [[UIImage imageNamed:normalArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tabBarItem.title = items[i];
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            selectColor, UITextAttributeTextColor,
                                            [UIColor clearColor], UITextAttributeTextShadowColor,
                                            [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                            [UIFont fontWithName:@"AmericanTypewriter" size:10.0], UITextAttributeFont,
                                            nil]
                                  forState:UIControlStateSelected];
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            textColor, UITextAttributeTextColor,
                                            [UIColor clearColor], UITextAttributeTextShadowColor,
                                            [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                            [UIFont fontWithName:@"AmericanTypewriter" size:10.0], UITextAttributeFont,
                                            nil]
                                  forState:UIControlStateNormal];
    }
    
    [tabBarCon.tabBar setBarTintColor: backColor];
    
    
    
}

// 初始化
- (NSArray*)normalImageArray
{
    if (!_normalImageArray)
    {
        _normalImageArray = @[@"首页.png",@"视频.png",@"练习.png",@"我的.png"];
    }
    
    return _normalImageArray;
}

- (NSArray*)selectedImageArray
{
    if (!_selectedImageArray)
    {
        _selectedImageArray = @[@"首页2.png",@"视频2.png",@"练习2.png",@"我的2.png"];
    }
    
    return _selectedImageArray;
}

@end
