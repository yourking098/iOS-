//
//  AppDelegate.m
//  iOS项目学习
//
//  Created by valenty on 16/2/13.
//  Copyright © 2016年 valenty. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstTabViewController.h"
#import "SecondTabViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    FirstTabViewController *firstTabVC = [[FirstTabViewController alloc] init];
    firstTabVC.navigationItem.title = @"第一个tab标题";
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstTabVC];
    firstNav.tabBarItem.title = @"第一个tab";
    firstNav.tabBarItem.image = [UIImage imageNamed:@"tab_home"];
    UIImage *imageHomeSelected = [UIImage imageNamed:@"tab_home_press"];
    imageHomeSelected = [imageHomeSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    firstNav.tabBarItem.selectedImage = imageHomeSelected;
    
    
    SecondTabViewController *secondTabVC = [[SecondTabViewController alloc] init];
    secondTabVC.navigationItem.title = @"第二个tab标题";
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondTabVC];
    secondNav.tabBarItem.title = @"第二个tab";
    secondNav.tabBarItem.image = [UIImage imageNamed:@"tab_goods"];
    UIImage *imgGoodsSelected = [UIImage imageNamed:@"tab_goods_press"];
    imgGoodsSelected = [imgGoodsSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondNav.tabBarItem.selectedImage = imgGoodsSelected;
    
    
    ThirdViewController *thirdTabVC = [[ThirdViewController alloc] init];
    thirdTabVC.navigationItem.title = @"第三个tab标题";
    UINavigationController *thirdNav = [[UINavigationController alloc] initWithRootViewController:thirdTabVC];
    thirdNav.tabBarItem.title = @"第三个tab";
    thirdNav.tabBarItem.image = [UIImage imageNamed:@"tab_shops"];
    UIImage *imgShopSelected = [UIImage imageNamed:@"tab_shops_press"];
    imgShopSelected = [imgShopSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdNav.tabBarItem.selectedImage = imgShopSelected;
    
    
    FourthViewController *fourthTabVC = [[FourthViewController alloc] init];
    fourthTabVC.navigationItem.title = @"第四个tab标题";
    UINavigationController *fourthNav = [[UINavigationController alloc] initWithRootViewController:fourthTabVC];
    fourthNav.tabBarItem.title = @"第四个tab";
    fourthNav.tabBarItem.image = [UIImage imageNamed:@"tab_me"];
    UIImage *imgMeSelected = [UIImage imageNamed:@"tab_me_press"];
    imgMeSelected = [imgMeSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fourthNav.tabBarItem.selectedImage = imgMeSelected;
    
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[firstNav,secondNav,thirdNav,fourthNav];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];
    
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

@end
