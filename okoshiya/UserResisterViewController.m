//
//  UserResisterViewController.m
//  okoshiya
//
//  Created by hata kanae on 2014/08/19.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "UserResisterViewController.h"

@interface UserResisterViewController ()


@end

@implementation UserResisterViewController

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
    self.postidbutton_p.enabled = NO;
    
    [[self.postidbutton_p layer] setCornerRadius:5.0];
    [self.postidbutton_p setClipsToBounds:YES];
    [[self.checkbutton layer] setCornerRadius:5.0];
    [self.checkbutton setClipsToBounds:YES];
    
    //buttonのアクティブ時と非アクティブ時の色とか
   [self.postidbutton_p setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [self.postidbutton_p setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


//-----------------------------------
//ここにボタンおされたらサーバーにidをおくる部分をかく
//-----------------------------------
- (IBAction)postidbutton:(id)sender {
    
    
    //userDefaults更新
    [userDefaults setObject:self.userid.text forKey:@"UserID"];
    [userDefaults setInteger:1 forKey:@"flag"];
    [userDefaults synchronize];
    
    
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    NSString *token = [currentInstallation deviceToken];
    
    NSString *useriddata;
    useriddata = self.userid.text;
   // NSLog(useriddata);
    
    NSString *query = [NSString stringWithFormat:@"a=%@&DeviceToken=%@",useriddata,token];
    NSData *queryData = [query dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = @"http://okoshiya.xterminal.me";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:queryData];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:&response
                                                       error:&error];
    NSString *string = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"%@", string);
   
    
}


//idが半角英数字で4文字以上6文字以内のやつをチェック
//サーバーサイドもチェックしたいよね
- (void)textFieldEditingChanged:(UITextField*)textField {
	//LOG_METHOD;
    
	NSRange match = [textField.text rangeOfString:@"^[a-zA-Z0-9]{4,6}$" options:NSRegularExpressionSearch];
	if (match.location != NSNotFound) {
		NSLog(@"Found: %@",[textField.text substringWithRange:match]);
		self.postidbutton_p.enabled = YES;
       
	} else {
		NSLog(@"Not Found");
		self.postidbutton_p.enabled = NO;
        
	}
}
- (IBAction)check_vali:(id)sender {
    [self textFieldEditingChanged:self.userid];
}


-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.userid resignFirstResponder];
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        // キーボード表示中のみ有効
        if (self.userid.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}
- (void)dealloc {
    [_checkbutton release];
    [super dealloc];
}
@end
