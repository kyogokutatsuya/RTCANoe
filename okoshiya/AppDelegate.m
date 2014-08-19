//
//  AppDelegate.m
//  okoshiya
//
//  Created by hata kanae on 2014/08/12.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

#define ParseApplicationID @"F92aIWE3lhOTe5xO2ZiazXsTdRVJ6IAGwLr3uYXS"
#define ParseClientKey     @"rOpagcRL6RHdikb2L1sZi2QYHgf6UVrrAT4Tchuz"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //parseを初期化する
    [Parse setApplicationId:ParseApplicationID clientKey:ParseClientKey];
    //プッシュ通知を有効とする
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeSound];
    
    
    
    //ユーザーデフォルト初期化
    userDefaults  = [NSUserDefaults standardUserDefaults];
    
    //設定適用
    [self initSettings];
    
    //ユーザーデフォルトの初回読み込みフラグ立てる
    [self setLoadedOnceUserDefaults];
    
    return YES;
}



//ロック&スリープ禁止の切り替え
- (void)setIdleTimer:(BOOL)isDisabled
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:isDisabled];
}

//設定適用
- (void)initSettings
{
    wakeUpTime     = ![self isLoadedOnceUserDefaults] ? DEFAULT_WAKE_UP_TIME : [userDefaults stringForKey:@"UD_WAKE_UP_TIME_KEY"];
    [userDefaults setObject:wakeUpTime forKey:@"UD_WAKE_UP_TIME_KEY"];
    
    [userDefaults synchronize];
}

//ユーザーデフォルトの初回読み込みフラグ立てる
- (void)setLoadedOnceUserDefaults
{
    [userDefaults setBool:YES forKey:@"UD_LOADED_ONCE"];
    [userDefaults synchronize];
}


//ユーザーデフォルトが初期状態であるか
- (BOOL)isLoadedOnceUserDefaults
{
    return [userDefaults boolForKey:@"UD_LOADED_ONCE"];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//DeviceToken受信メソッド
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    //取得したDeveiceTokenを設定する
    [currentInstallation setDeviceTokenFromData:deviceToken];
    
    //保存する
    [currentInstallation saveInBackground];
}

@end
