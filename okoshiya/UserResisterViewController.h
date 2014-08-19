//
//  UserResisterViewController.h
//  okoshiya
//
//  Created by hata kanae on 2014/08/19.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import <UIKit/UIKit.h>

//id認証とか
@interface UserResisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userid;


- (IBAction)postidbutton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *postidbutton_p;
- (IBAction)check_vali:(id)sender;

@end
