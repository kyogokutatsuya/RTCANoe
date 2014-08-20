//
//  AlarmViewController.h
//  okoshiya
//
//  Created by hata kanae on 2014/08/19.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAudioPlayer.h"
#import "DCLabel.h"
#import "DCButton.h"
#import "DCUtil.h"
#import <Parse/Parse.h>

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

@interface AlarmViewController : UIViewController
@property(retain, nonatomic)NSData *recordvoice;
@property (retain, nonatomic)NSString *alarmsettime;
@property (retain, nonatomic) IBOutlet UILabel *timelabel;
- (IBAction)stopbutton:(id)sender;

@end
