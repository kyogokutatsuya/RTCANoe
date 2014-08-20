//
//  AppDelegate.h
//  okoshiya
//
//  Created by hata kanae on 2014/08/12.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "DCAudioPlayer.h"
#import <AVFoundation/AVAudioPlayer.h>




@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic)MPMusicPlayerController *afterplayer;
@property float   beforevolume;


#pragma mark method prototype
- (void)setIdleTimer:(BOOL)isDisabled;


@end
