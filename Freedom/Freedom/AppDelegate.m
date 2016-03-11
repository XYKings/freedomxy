//
//  AppDelegate.m
//  Freedom
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "AppDelegate.h"
#import <MMDrawerController.h>
#import "LMS_LeftDrawer_ViewController.h"
#import "LMS_Main_ViewController.h"

//     test
#import "LMS_MusicPlay_ViewController.h"
#import "LMS_MusicList_ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    /********************************   Test    ***********************************************/
//    LMS_MusicList_ViewController *musicVC = [[LMS_MusicList_ViewController alloc] init];
//    UINavigationController *musicNC = [[UINavigationController alloc] initWithRootViewController:musicVC];
//    self.window.rootViewController = musicNC;
    
    
    //*********      Main
     
    LMS_Main_ViewController *mainVC = [[LMS_Main_ViewController alloc] init];
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    LMS_LeftDrawer_ViewController *leftVC = [[LMS_LeftDrawer_ViewController alloc] init];
    MMDrawerController *drawerC = [[MMDrawerController alloc] initWithCenterViewController:mainNC leftDrawerViewController:leftVC];
    
    [drawerC setMaximumLeftDrawerWidth:260];
    
    [drawerC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeBezelPanningCenterView];
    [drawerC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeTapCenterView];
    
    self.window.rootViewController = drawerC;
    
//    *************/
    
    
    
    
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
