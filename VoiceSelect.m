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
@property NSDictionary* member;

@end

@implementation VoiceSelect
NSMutableData *resData;

// クエリのエンコード
- (NSString*)getQueryStringByDic:(NSDictionary*)dic
{
    NSArray*keys = [dic allKeys];
    NSMutableArray*tmp=[NSMutableArray array];
    for (NSString*key in keys) {
        [tmp addObject:[NSString stringWithFormat:@"%@=%@",key,dic[key]]];
    }
    return [tmp componentsJoinedByString:@"&"];
}

- (void)fetchWithURL:(NSString*)urlStr withHandler:(void(^)(NSData *data, NSError *error))handler
{
    // 要求を準備
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    // 非同期通信による取得開始
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher beginFetchWithCompletionHandler:handler];
}

- (void)fetchMembers
{
    NSString *url = @"http://okoshiya.xterminal.me/voicetable.php";
    [self fetchWithURL:url withHandler:^(NSData *data, NSError *error) {
        NSError *jsonerror = nil;
        members = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonerror];
        NSLog(@"%@", members);
        [self.grouptable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
}

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
    
    members = [NSArray array];
    checkedRow = -1;
    
    NSTimer *tm = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(fetchMembers) userInfo:nil repeats:YES];
    [tm fire];
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
    NSLog(@"%@", members);
    NSLog(@"array.count = %d", (int)members.count);
    return members.count;
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
    
    self.member = members[indexPath.row];
    //表示するセル
    NSString *title = [NSString stringWithFormat:@"%@",self.member[@"id"]];
    //セルのラベルに設定する
    cell.textLabel.text = title;
    //文字の色
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    if (indexPath.row == checkedRow) cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else cell.accessoryType = UITableViewCellAccessoryNone;
    
    //起きたらme.png寝てたらclose.pngを表示
    if ([self.member[@"wakeupflg"] intValue] == 0){
        UIImage *image = [UIImage imageNamed:@"close.png" ];
        cell.imageView.image = image;
    } else {
        UIImage *image = [UIImage imageNamed:@"me.png" ];
        cell.imageView.image = image;
    }
    
    //文字サイズ
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    
    return cell;
}




//選択された時に行う処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"セクション%dの%d行目", (int)indexPath.section, (int)indexPath.row);
    
//    // 選択されたセルを取得
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    // セルのアクセサリにチェックマークを指定
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    checkedRow = (int)indexPath.row;
    [self.grouptable reloadData];
}

// セルの選択がはずれた時に呼び出される
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 選択がはずれたセルを取得
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    // セルのアクセサリを解除する（チェックマークを外す）
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    [self.grouptable reloadData];
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
    [query whereKey:@"channels" equalTo:self.member[@"id"]];
    
    
    
   // NSLog(@"data bytes : %@kyogokutatsuyara", self.recordvoice);
   // NSString *hoge = [self.recordvoice base64EncodedStringWithOptions:kNilOptions];
    
    NSLog(@"push送る前のかくにん　%@", [userDefaults objectForKey:@"UserID"]);
    PFPush *push = [[PFPush alloc]init];
    NSDictionary *dict = @{@"content-available":@"1",
                           
                           @"userid":[userDefaults objectForKey:@"UserID"],
                           @"alert":[userDefaults objectForKey:@"UserID"]};
    
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