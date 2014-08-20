//
//  VoiceRecieveViewController.m
//  okoshiya
//
//  Created by kyogokutatsuya on 2014/08/20.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "VoiceRecieveViewController.h"

@interface VoiceRecieveViewController ()

@end

@implementation VoiceRecieveViewController
@synthesize wakeUpTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"受け取ったデータ<%d>", wakeUpTime);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
