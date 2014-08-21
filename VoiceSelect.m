//
//  VoiceSelect.m
//  okoshiya
//
//  Created by kyogokutatsuya on 2014/08/18.
//  Copyright (c) 2014年 hata kanae. All rights reserved.
//

#import "VoiceSelect.h"
#import "AlarmViewController.h"

@interface VoiceSelect ()<UITableViewDataSource, UITableViewDelegate>
@property NSString *groupstr;

@end

@implementation VoiceSelect


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
    self.groupstr = [self.timegroup stringByAppendingString:@" GROUP"];
    
    self.grouptable.bounces = NO;
    for (UIView *view in self.grouptable.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            
            UIScrollView *scView = (UIScrollView *)view;
            scView.delegate = self;
            scView.bounces = NO;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//セクション数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


//headerのサイズ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIView *headerView = [[self grouptable] tableHeaderView];
    [headerView setFrame:CGRectMake(headerView.frame.origin.x
                                    , self.grouptable.contentOffset.y
                                    , headerView.frame.size.width
                                    , headerView.frame.size.height)];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    //headerの上にview作成
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    //ラベル作成
    UILabel *tablelabel = [[UILabel alloc]initWithFrame:view.frame];
    
    
    tablelabel.font = [UIFont fontWithName:@"Helvetica" size:[UIFont labelFontSize]+3];
    tablelabel.text = self.groupstr;
    tablelabel.textAlignment = NSTextAlignmentCenter;
    
    tablelabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:211.0f/255.0f blue:93.0f/255.0f alpha:1.0];
    
    
    [view addSubview:tablelabel];
    
    return  view;
}

//表示するセル
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"Cell";
    //セルを準備する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell ==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    //表示するセル
    NSString *title = [NSString stringWithFormat:@"セクション%dの%d行目", indexPath.section, indexPath.row];
    //セルのラベルに設定する
    cell.textLabel.text = title;
    //文字の色
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    //起きたらme.png寝てたらclose.pngを表示
    UIImage *image = [UIImage imageNamed:@"close.png" ];
    cell.imageView.image = image;
    
    
    //文字サイズ
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    
    return cell;
}




//選択された時に行う処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"セクション%dの%d行目", indexPath.section, indexPath.row);
    // 選択されたセルを取得
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // セルのアクセサリにチェックマークを指定
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
}
// セルの選択がはずれた時に呼び出される
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 選択がはずれたセルを取得
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // セルのアクセサリを解除する（チェックマークを外す）
    cell.accessoryType = UITableViewCellAccessoryNone;
}

//ステータスバーを非表示
-(BOOL)prefersStatusBarHidden{
    return YES;
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

- (IBAction)okosubutton:(id)sender {
    
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    NSString *token = [currentInstallation deviceToken];
    
    // [PFPush sendPushMessageToChannelInBackground:@"global" withMessage:@"Hello World!"];
    PFQuery *query = [PFInstallation query];
    //TODO: 変更
    [query whereKey:@"channels" equalTo:@"tjadm"];
    
    
    
   // NSLog(@"data bytes : %@kyogokutatsuyara", self.recordvoice);
   // NSString *hoge = [self.recordvoice base64EncodedStringWithOptions:kNilOptions];
    
    PFPush *push = [[PFPush alloc]init];
    NSDictionary *dict = @{@"content-available":token,
                           //@"content-available":hoge,
                           @"alert":@"hello world"};
    [push setQuery:query];
    [push setData:dict];
    
    
    [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"成功");
        
        }else{
            NSLog(@"失敗　%@",error);
        }
    } ];
}
@end
/*- (void)dealloc {
    [_grouptable release];
    [super dealloc];
}*/