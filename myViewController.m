//
//  myViewController.m
//  okoshiya
//
//  Created by kyogokutatsuya on 2014/08/18.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "myViewController.h"
#import "AlarmViewController.h"
#import "VoiceRecieveViewController.h"
#import <Parse/Parse.h>

@interface myViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *time_list;
}


@property (retain, nonatomic) IBOutlet UIPickerView *myPicker;
@property NSInteger ROW;


@end

@implementation myViewController
NSString *settime;
@synthesize recordvoice;

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
    
    [[self.settimebutton_p layer] setCornerRadius:5.0];
    [self.settimebutton_p setClipsToBounds:YES];
    
    // Do any additional setup after loading the view.
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
    //データを共有します
    time_list =@[ @"6:00",@"6:30",@"7:00",@"7:30",@"8:00"];
   // NSLog(@"recive voice is : %@",self.recordvoice );
    //settime = @"7:00";
    //NSLog(@"%ld",(long)settime);
    
    //debug用
    //[self MQDumpNSData:recordvoice];//onseiviewcontrollerからrecordvoiceが届いてるか確認のため
    
    [self voicetodatabase];
    
}

//--------------------------------------------
//次のストーリーボードに値を保持しつつ渡すための準備
//--------------------------------------------
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"myviewtoalarm"] ) {
        AlarmViewController *alarmviewcontroller = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
        alarmviewcontroller.alarmsettime = settime;
       // alarmviewcontroller.recordvoice = self.recordvoice;
    }
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


//ピッカーに表示する文字を返す
-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    //  NSLog(@"%ld  %@",(long)row,time_list);
    //NSLog(@"%@",[NSString stringWithFormat:@"%@",time_list[row]]);
    return time_list[row];
    // return [NSString stringWithFormat:@"%ld", (long)row];
    
}


//ピッカーで選択されたときに行う処理
- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"選択=%@", time_list[row]);
    self.ROW = row;
    
    
}



//
////--------------------------------------------
////NSDataにデータはいってるのか確認する関数
////--------------------------------------------
-(void) MQDumpNSData:(NSData *)data
{
    // データ配列のポインタを得る
    const unsigned char *ptr = [data bytes];
    unsigned long length     = [data length];
    
    // 取得したデータ分の文字列配列を確保
    unsigned char s[length];
    
    for (int i = 0; i < length; i++) {
        // ptrポインタから文字列を取り出し、ポインタアドレスを先に進める
        s[i] = *ptr++;
    }
    
    NSLog(@"%s", s); //=> 人間が分かる形で出力される
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



//--------------------------------------------
//Settimebuttonが押されたら時間をセットしAlarmviewにいく
//--------------------------------------------
- (IBAction)settimebutton:(id)sender {
    //NSString *time;
    settime = time_list[self.ROW];
    NSLog(@"settimelog : %@",settime);
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    NSString *token = [currentInstallation deviceToken];
    
    NSString *query = [NSString stringWithFormat:@"DeviceToken=%@&settime=%@",token,settime];
    NSData *queryData = [query dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = @"http://okoshiya.xterminal.me/settimer.php";
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
    
    [self performSegueWithIdentifier:@"myviewtoalarm" sender:self];
    
}



//-------------------------------------------
//parseのデータベースに音声を登録
//-------------------------------------------
-(void)voicetodatabase{
    
    
    PFObject *voice = [PFObject objectWithClassName:@"voice"];
   
   
    PFFile *voicefile = [PFFile fileWithData:self.recordvoice];
    
    PFQuery *query = [PFQuery queryWithClassName:@"voice"];
    //クエリからUseIDがすでにあるか探してあるなら上書き
    [query whereKey:@"userid" equalTo:[userDefaults objectForKey:@"UserID"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects.count == 0) {
                voice[@"userid"] = [userDefaults objectForKey:@"UserID"];
                voice[@"voicedata"] = voicefile;
            
        }
        
        //クエリ重複
        for (PFObject *object in objects) {
            [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded)NSLog(@"delete ");
                else NSLog(@"%@",error);
            }];
        }
        
            voice[@"userid"] = [userDefaults objectForKey:@"UserID"];
            voice[@"voicedata"] = voicefile;

        
        //保存する
        [voice saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded) NSLog(@"seikou ");
            else  NSLog(@"%@",error);
        }];
        
    }];
    
    
}



@end
