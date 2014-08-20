//
//  VoiceSelect.h
//  okoshiya
//
//  Created by kyogokutatsuya on 2014/08/18.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface VoiceSelect : UIViewController <UIScrollViewDelegate>
- (IBAction)okosubutton:(id)sender;
@property (retain ,nonatomic)NSString *timegroup;
@property (retain, nonatomic) IBOutlet UITableView *grouptable;

@end
