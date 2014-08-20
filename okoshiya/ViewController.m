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
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    //最初みんなで起きるモードに行けないようにする用
    //self.view_id_ok.enabled = NO;
    
    
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
