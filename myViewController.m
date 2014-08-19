//
//  myViewController.m
//  okoshiya
//
//  Created by kyogokutatsuya on 2014/08/18.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "myViewController.h"

@interface myViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *time_list;
}

- (IBAction)voice:(id)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *myPicker;
@end

@implementation myViewController

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
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
    //データを共有します
    time_list =@[ @"6:00",@"6:30",@"7:00",@"7:30",@"8:00"];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--ピッカーに列数を返す
-(NSInteger)numberOfComponentsInPickerView: (UIPickerView*)pickerView{
    return 1;
}

//--ピッカーに行数を返す
-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component{
    return time_list.count;
}


//ピッカーに商事する文字を返す
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return time_list[row];
}


//ピッカーで選択されたときに行う処理
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"選択=%@", time_list[row]);
    
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

- (IBAction)voice:(id)sender {
}
@end
