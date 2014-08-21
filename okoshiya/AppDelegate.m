//
//  AppDelegate.m
//  okoshiya
//
//  Created by hata kanae on 2014/08/12.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "AppDelegate.h"
#import "AlarmViewController.h"
#import <Parse/Parse.h>


#define ParseApplicationID @"F92aIWE3lhOTe5xO2ZiazXsTdRVJ6IAGwLr3uYXS"
#define ParseClientKey     @"rOpagcRL6RHdikb2L1sZi2QYHgf6UVrrAT4Tchuz"



#define ALARM_NAME                   @"alarm"
#define ALARM_FILE_EXT               @"mp3"
#define ALARM_PICKER_WIDTH           320
#define ALARM_PICKER_HEIGHT          192
#define ALARM_PICKER_MINUTE_INTERVAL 5
#define ALARM_PLAY_INFINITE          -1
#define ALARM_TIME_DATE_FORMAT       @"HH:mm"
#define ALARM_TIMER_INTERVAL         1
#define ALARM_START_MESSAGE          @"アラームを開始しました。アプリを終了したりスリープさせないでください。"
#define ALARM_ERROR_MESSAGE          @"指定時刻と現在時刻が同じです"
#define ALARM_CTR_BTN_WIDTH          100
#define ALARM_CTR_BTN_HEIGHT         48
#define ALARM_CTR_BTN_Y              142
#define WAKE_UP_TIME_RECT            CGRectMake(0, 0, 320, 48)
#define WAKE_UP_TIME_LABEL_FONT      [UIFont fontWithName:@"Futura" size:16]






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
    
    
     [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    
    
    UILocalNotification *launchNote = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (launchNote){
        // I recieved a notification while not running
      //  NSLog(@"aaajjdhdhdhdhdfhkfh¥eekjwfhekflkewjflkewj¥¥¥¥¥¥¥¥¥flkwfjlkrjlkrfjlwkejflekwjflkwejflkrwjflkrjfa");
        
        
        
    }
    
    return YES;
}
/*
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"fetchjfsjslejgesrferjsesgnvesrjgerjjergiljesrlgfsdnglsdfgjldsfjgj");
    completionHandler(UIBackgroundFetchResultNewData);
    
    
}
 */


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
    
    self.afterplayer = [MPMusicPlayerController applicationMusicPlayer];
    self.afterplayer.volume = self.beforevolume;
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
    NSString *user_id = [userDefaults objectForKey:@"UserID"];
    NSLog(@"user id : %@", user_id);
    
    
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    
    
    //取得したDeveiceTokenを設定する
    [currentInstallation setDeviceTokenFromData:deviceToken];
    
    //channelsにuseridを設定する
    [[PFInstallation currentInstallation] addUniqueObject:[userDefaults objectForKey:@"UserID"] forKey:@"channels"];
    
    //保存する
    [currentInstallation saveInBackground];
        
        
}


-(void)playVoice:(PFFile*)file{
    
    
    [file getDataInBackgroundWithBlock:^(NSData *recivedata, NSError *error) {
        
        if (!error) {
            
            AVAudioPlayer *RaudioPlayer = [[AVAudioPlayer alloc] initWithData:recivedata error:nil];
            [RaudioPlayer play];
            RaudioPlayer = [[DCAudioPlayer alloc]initWithData:recivedata error:nil];
            
            // RaudioPlayer = [[DCAudioPlayer alloc] initWithAudio:ALARM_NAME ext:ALARM_FILE_EXT isUseDelegate:NO];
            [RaudioPlayer setNumberOfLoops:ALARM_PLAY_INFINITE];
            //[audioPlayer prepareToPlay];
            [RaudioPlayer play];
            
        }
        
    }];
    
    
}




//backgroundにてpushきたら鳴るようにする
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    /*
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *viewController;
    viewController = [storyboard instantiateViewControllerWithIdentifier:@"alarm"];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
//    //ファースト画面が変更
//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    UIViewController *viewController;
//    viewController = [storyboard instantiateViewControllerWithIdentifier:@"alarm"];
//    self.window.rootViewController = viewController;
//    [self.window makeKeyAndVisible];
    
     */
    
    
    //userinfo よりpushされた相手のidをとってくる
    NSLog(@"userinfo %@",userInfo);
    NSString *pushedID = [userInfo objectForKey:@"userid"];
    
    
    //PFObject *obj = [PFObject objectWithClassName:@"voice"];
    //NSString *userid = obj[@"userid"];
    
    //voicedataはparseのDBのcolumn
    //PFFile *DLdata = obj[@"voicedata"];
    

   // if()
    
   // PFQuery *query = [PFObject query];
    //[query whereKey:@"userid" equalTo:pushedID];
    
    // NSData
    //NSArray *girls = [query findObjects];
    // NSLog(@"voice data %@",[voicefile getData]);
    // AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:[voicefile getData] error:nil];
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:@"alarm.mp3"] error:nil];
    audioPlayer = [[DCAudioPlayer alloc] initWithAudio:ALARM_NAME ext:ALARM_FILE_EXT isUseDelegate:NO];
    [audioPlayer setNumberOfLoops:ALARM_PLAY_INFINITE];
    //[audioPlayer prepareToPlay];
    NSDate *date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:date];
    [audioPlayer play];

    
    PFQuery *query = [PFQuery queryWithClassName:@"voice"];
    [query whereKey:@"userid" equalTo:pushedID];
    
    
    // __block PFFile *voicefile;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(objects){
            NSLog(@" object[0] %@",objects[0]);
            PFObject *recievedObj = objects[0];
            PFFile * voicefile = recievedObj[@"voicedata"];
            [audioPlayer pause];
            [self playVoice:voicefile];
        }
    }];
    
   // NSData
    //NSArray *girls = [query findObjects];
 
   
    
   // NSLog(@"voice data %@",[voicefile getData]);
    
    /*
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:[voicefile getData] error:nil];
                                  
                                  
   // AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:@"alarm.mp3"] error:nil];
    audioPlayer = [[DCAudioPlayer alloc] initWithAudio:ALARM_NAME ext:ALARM_FILE_EXT isUseDelegate:NO];
    [audioPlayer setNumberOfLoops:ALARM_PLAY_INFINITE];
    //[audioPlayer prepareToPlay];
    [audioPlayer play];
     */
    
    
    //ここに、バックグラウンドで声がなるようにしたい
//    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:@"alarm.mp3"] error:nil];
//    audioPlayer = [[DCAudioPlayer alloc] initWithAudio:ALARM_NAME ext:ALARM_FILE_EXT isUseDelegate:NO];
//    [audioPlayer setNumberOfLoops:ALARM_PLAY_INFINITE];
//    //[audioPlayer prepareToPlay];
//    [audioPlayer play];
//    
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    
    
}


//------------------------
//parse から　json　でこれを送ると鳴るはず
//
//
//{ "aps": { "content-available": 1, "alert": "content test", "badge": 0} }
//
//------------------------



//forgroundにてpushきても鳴るようにする
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:@"alarm.mp3"] error:nil];
    audioPlayer = [[DCAudioPlayer alloc] initWithAudio:ALARM_NAME ext:ALARM_FILE_EXT isUseDelegate:NO];
    [audioPlayer setNumberOfLoops:ALARM_PLAY_INFINITE];
   // [audioPlayer prepareToPlay];
    [audioPlayer play];
    NSLog(@"userinfo %@",userInfo);
    NSString *pushedID = [userInfo objectForKey:@"userid"];
    
    
//    PFObject *obj = [PFObject objectWithClassName:@"voice"];
//    PFObject *userid = [PFObject objectWithClassName:@"userid"];
//    
//    //voicedataはparseのDBのcolumn
    PFObject *obj = [PFObject objectWithClassName:@"voice"];
    PFObject *userid = [PFObject objectWithClassName:@"userid"];
    
    //voicedataはparseのDBのcolumn
    //PFFile *DLdata = obj[@"voicedata"];
    
    
    // if()
    
    
    // PFQuery *query = [PFObject query];
    //[query whereKey:@"userid" equalTo:pushedID];
    
    PFQuery *query = [PFQuery queryWithClassName:@"voice"];
    [query whereKey:@"userid" equalTo:pushedID];
    
    //__block PFFile *voicefile;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(objects){
            NSLog(@"%@",objects[0]);
            PFObject *recievedObj = objects[0];
           // voicefile = recievedObj[@"voicedata"];
            PFFile * voicefile = recievedObj[@"voicedata"];
            
            voicefile = recievedObj[@"voicedata"];
            [audioPlayer pause];
            [self playVoice:voicefile];
            }
        }];

    
    
    

}

@end
