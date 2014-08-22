//
//  ViewController.m
//  okoshiya
//
//  Created by hata kanae on 2014/08/12.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "OnseiViewController.h"
#import "myViewController.h"

@interface OnseiViewController ()
@property (retain, nonatomic)NSString *hoge;
@end

@implementation OnseiViewController
NSData *audioData;


@synthesize session;
@synthesize recorder;
@synthesize player;

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
    self.next.enabled = NO;
    self.playButton.enabled = NO;
    // Do any additional setup after loading the view.
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(checkrecording:) userInfo:nil repeats:YES];
    //1.5秒ごとにcheckrecordingを実行を繰りかえす
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpers
-(NSMutableDictionary *)setAudioRecorder
{
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    [settings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [settings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [settings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    [settings setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    return settings;
}


//--------------------------------------------
//録音のための準備
//--------------------------------------------
-(void)recordFile
{
    // Prepare recording(Audio session)
    NSError *error = nil;
    self.session = [AVAudioSession sharedInstance];
    
    if ( session.inputAvailable )   // for iOS6 [session inputIsAvailable]  iOS5
    {
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    }
    
    if ( error != nil )
    {
        NSLog(@"Error when preparing audio session :%@", [error localizedDescription]);
        return;
    }
    [session setActive:YES error:&error];
    if ( error != nil )
    {
        NSLog(@"Error when enabling audio session :%@", [error localizedDescription]);
        return;
    }
    
    // File Path
    NSString *dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [dir stringByAppendingPathComponent:@"test.caf"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    
    // recorder = [[AVAudioRecorder alloc] initWithURL:url settings:nil error:&error];
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:[self setAudioRecorder] error:&error];
    
    //recorder.meteringEnabled = YES;
    if ( error != nil )
    {
        NSLog(@"Error when preparing audio recorder :%@", [error localizedDescription]);
        return;
    }
    
    [recorder updateMeters];
    [recorder peakPowerForChannel:0];
    [recorder recordForDuration: 3.0];//3秒で録音とめる
    [recorder record];
    self.playButton.enabled = YES;
    /*
    //cafをNSDataに変換（たぶん）
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:filePath];
    if(success) {
        audioData = [[NSData alloc] initWithContentsOfFile:filePath];
        [self MQDumpNSData:audioData];
    }
     */
    
    
}


//--------------------------------------------
//次のストーリーボードに値を保持しつつ渡すための準備
//--------------------------------------------
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"OnseitoMyview"] ) {
        myViewController *myviewcontroller = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
        
      //  NSLog(@"onsei to myview : %@",self.hoge);
        myviewcontroller.recordvoice = audioData;
       
    }
}


//--------------------------------------------
//NSDataにデータはいってるのか確認する関数
//--------------------------------------------
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


//--------------------------------------------
//録音してるか再生してるか何もしてないかのチェック部分
//--------------------------------------------

- (void)checkrecording:(NSTimer *)timer
{
    if(recorder.isRecording){
       // NSLog(@"録音なう");
        self.label.text = @"「録音中...」";
        [self.recordButton setImage:[UIImage imageNamed:@"recordbuttonon.png"]
                    forState:UIControlStateNormal];
        
    }
    else if(player.isPlaying) {
        self.label.text = @"「再生中...」";
    }
    else{
        self.label.text = @"  ";
        [self.recordButton setImage:[UIImage imageNamed:@"recordbutton.png"]
                           forState:UIControlStateNormal];
    }
}


//--------------------------------------------
//録音を止める部分
//--------------------------------------------
-(void)stopRecord
{
    if ( self.recorder != nil && self.recorder.isRecording )
    {
        [recorder stop];
        self.recorder = nil;
        
//        //cafをNSDataに変換（たぶん）
//        // File Path
//        NSString *dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        NSString *filePath = [dir stringByAppendingPathComponent:@"test.caf"];
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        BOOL success = [fileManager fileExistsAtPath:filePath];
//        if(success) {
//            audioData = [[NSData alloc] initWithContentsOfFile:filePath];
//            NSLog(@"%@",audioData);
//            [self MQDumpNSData:audioData];
//        }
    }
}



//--------------------------------------------
//再生部分の実装
//--------------------------------------------
-(void)playRecord
{
    NSError *error = nil;
    
    // File Path
    
    NSString *dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [dir stringByAppendingPathComponent:@"test.caf"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    if ( [[NSFileManager defaultManager] fileExistsAtPath:[url path]] )
    {
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        
        if ( error != nil )
        {
            NSLog(@"Error %@", [error localizedDescription]);
        }
        [self.player prepareToPlay];
        self.player.volume = 5.0;
        [self.player play];
        self.next.enabled = YES;
    }
}


//--------------------------------------------
//クリックされたら録音
//--------------------------------------------
- (IBAction)recordClick:(id)sender
{
    if ( self.recorder != nil && self.recorder.isRecording )
    {
        [self stopRecord];
       // [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    else
    {
        [self recordFile];
        //[self.recordButton setTitle:@"..." forState:UIControlStateNormal];
    }
}

//--------------------------------------------
//クリックされたら再生
//--------------------------------------------
- (IBAction)playClick:(id)sender
{
    [self playRecord];
    //cafをNSDataに変換（たぶん）
    // File Path
    NSString *dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [dir stringByAppendingPathComponent:@"test.caf"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:filePath];
    if(success) {
        audioData = [[NSData alloc] initWithContentsOfFile:filePath];
        NSLog(@"%@",audioData);
        //[self MQDumpNSData:audioData];
    }
    
   // self.hoge = [audioData base64EncodedStringWithOptions:kNilOptions];
    //NSLog(@"henkan ok  %@",self.hoge);
    
    
}


//--------------------------------------------
//myviewcontrollerへ
//--------------------------------------------
- (IBAction)onseitomy:(id)sender {
    [self performSegueWithIdentifier:@"OnseitoMyview" sender:self];
    
}





- (void)dealloc {
    [_next release];
    [super dealloc];
}
@end