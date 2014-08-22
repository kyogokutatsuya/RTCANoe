//
//  ViewController.h
//  okoshiya
//
//  Created by hata kanae on 2014/08/12.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>


//@interface ViewController : UIViewController<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
//- (IBAction)start;
//
//- (IBAction)stop;
//- (IBAction)listen;



#import "OnseiViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface OnseiViewController : UIViewController

@property (retain,nonatomic)AVAudioRecorder *recorder;
@property (retain,nonatomic)AVAudioSession *session;
@property (retain,nonatomic)AVAudioPlayer *player;

//録音確認
@property (retain, nonatomic) IBOutlet UILabel *label;

//録音
@property (retain, nonatomic) IBOutlet UIButton *recordButton;
- (IBAction)recordClick:(id)sender;


//再生
@property (retain, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)playClick:(id)sender;

//nextbutton
-(IBAction)onseitomy:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *next;
@end
