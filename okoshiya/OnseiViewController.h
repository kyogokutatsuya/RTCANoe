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

@property (nonatomic)AVAudioRecorder *recorder;
@property (nonatomic)AVAudioSession *session;
@property (nonatomic)AVAudioPlayer *player;

//録音確認
@property (weak, nonatomic) IBOutlet UILabel *label;

//録音
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
- (IBAction)recordClick:(id)sender;


//再生
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)playClick:(id)sender;


@end
