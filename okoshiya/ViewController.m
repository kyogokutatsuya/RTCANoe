//
//  ViewController.m
//  okoshiya
//
//  Created by hata kanae on 2014/08/12.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "ViewController.h"
#import "OnseiViewController.h"
#import "myViewController.h"






@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *UserID = [userDefaults objectForKey:@"UserID"];
    NSLog(@"key %@",UserID);
    
    if([userDefaults integerForKey:@"flag"] == 1){
        goto already;
    }
    
    [userDefaults setObject:@"nothing" forKey:@"UserID"];
    [userDefaults synchronize];
    
    
already:
   

    
	// Do any additional setup after loading the view, typically from a nib.
    
   //  AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
 
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"alarm" ofType:@"mp3"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//
  //-------------fordaisukedebug---------
    // AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:@"alarm.mp3"] error:nil];
//     audioPlayer = [[DCAudioPlayer alloc] initWithAudio:ALARM_NAME ext:ALARM_FILE_EXT isUseDelegate:NO];
//    [audioPlayer setNumberOfLoops:ALARM_PLAY_INFINITE];
//    [audioPlayer play];
//---------------------------------------
    
    //最初みんなで起きるモードに行けないようにする用
    if([UserID isEqualToString:@"nothing"]){
    self.coButton.enabled = NO;
    }
    
//    
//    NSDate *fireDate = [[NSDate alloc]initWithTimeIntervalSinceNow:5];
//    
//    // 通知時間 < 現在時 なら設定しない
//    if (fireDate == nil || [fireDate timeIntervalSinceNow] <= 0) {
//        return;
//    }
//    // 設定する前に、設定済みの通知をキャンセルする
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    // 設定し直す
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    localNotification.fireDate = fireDate;
//    localNotification.alertBody = @"Fire!";
//    localNotification.timeZone = [NSTimeZone localTimeZone];
//    localNotification.soundName = @"alarm.mp3";
//    localNotification.alertAction = @"OPEN";
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    
   
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//あとでid登録おさんかったらみんなで起きるモードに行けないようにする



@end
