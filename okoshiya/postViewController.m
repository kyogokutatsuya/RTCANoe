//
//  postViewController.m
//  okoshiya
//
//  Created by 芹生 義雄 on 2014/08/18.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "postViewController.h"

@interface postViewController ()

@end

@implementation postViewController

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

- (IBAction)btnact:(id)sender {
    // URL指定
    NSURL *url = [NSURL URLWithString:@"http://okoshiya.xterminal.me/"];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
    // POST指定
    req.HTTPMethod = @"POST";
    // BODYに登録、設定
    NSString *body = [NSString stringWithFormat:@"a=RT CANoe"];
    req.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    CGRect rc = [[UIScreen mainScreen] applicationFrame];
    UIWebView *web = [[[UIWebView alloc] initWithFrame:CGRectMake( 0, 0, rc.size.width, rc.size.height )] autorelease];
    // リクエスト送信
    [web loadRequest:req];
    
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
