//
//  myViewController.h
//  okoshiya
//
//  Created by kyogokutatsuya on 2014/08/18.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myViewController : UIViewController
@property (retain, nonatomic)NSData *recordvoice;
- (IBAction)settimebutton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *settimebutton_p;

@end
