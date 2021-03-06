//
//  VoiceSelect.h
//  okoshiya
//
//  Created by kyogokutatsuya on 2014/08/18.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "GTMHTTPFetcher.h"

@interface VoiceSelect : UIViewController <UIScrollViewDelegate>
{
    NSArray *members;
    int checkedRow;
}
- (IBAction)okosubutton:(id)sender;
@property (retain ,nonatomic)NSString *timegroup;
@property (retain, nonatomic) IBOutlet UITableView *grouptable;
@property(retain, nonatomic)NSData *recordvoice;
@end
