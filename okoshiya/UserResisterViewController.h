//
//  UserResisterViewController.h
//  okoshiya
//
//  Created by hata kanae on 2014/08/19.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

//id認証とか
@interface UserResisterViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (retain, nonatomic) IBOutlet UITextField *userid;
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;


- (IBAction)postidbutton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *postidbutton_p;
- (IBAction)check_vali:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *checkbutton;

@end
