//
//  ViewController.m
//  Draw9VAe
//
//  Created by Danjiro Daiwa on 11/11/17.
//  Copyright (c) 2017 Danjiro Daiwa. All rights reserved.
//

#import "ViewController.h"
#import "Twitter/TWTweetComposeViewController.h"
#import "QvaeLib.h"
#import "QvaeDef.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize qvaeView;
//@synthesize tempDrawImage;
//@synthesize  qvae;



UILabel *label_;



- (void)viewDidLoad
{
    [super viewDidLoad];

    UIInterfaceOrientation direction = self.interfaceOrientation;
    [self willRotateToInterfaceOrientation:direction duration:0];
    
    if(timer==nil){
        //タイマー処理
        // 自動でタイマーはスタートします。
        /*NSTimer **/timer = [NSTimer
                              // タイマーイベントを発生させる間隔。「1.5」は 1.5秒 型は float
                              scheduledTimerWithTimeInterval:0.2
                              // 呼び出すメソッドの呼び出し先(selector) self はこのファイル(.m)
                              target:self
                              // 呼び出すメソッド名。「:」で自分自身(タイマーインスタンス)を渡す。
                              selector:@selector(update:)
                              // 呼び出すメソッド内で利用するデータが存在する場合は設定する。ない場合は「nil」
                              userInfo:nil
                              // 上記で設定した秒ごとにメソッドを呼び出す場合は、「YES」呼び出さない場合は「NO」
                              repeats:YES
                              ];
        
        //    label_ = [[UILabel alloc] init];
        //    [self.view addSubview:label_];
        // タイマーの状態を取得する方法、「0」: 停止中 「1」: 動作中
        [timer isValid];
        // タイマーを停止したい場合
        //[timer invalidate];
        // タイマーを開始、再開する場合
        //[timer fire];
        
    }
}

-(void) update:(NSTimer *)timer
{
    [QvaeView updateView:self qvaeView:qvaeView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void) viewDidDisappear:(BOOL)animated
{    //画面から消えたら必ずタイマーを無効化する
    //clockUpdateTimer?.invalidate()
    //timer = nil
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    //[self setQvaeView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#define Min(a,b) ((a)<=(b)?(a):(b))
#define Max(a,b) ((a)>=(b)?(a):(b))

//Rotation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect r0 = [UIScreen mainScreen].bounds;
    CGRect rc = self.qvaeView.frame;
    if(toInterfaceOrientation == UIInterfaceOrientationPortrait ||// 縦（ホームが下）
       toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){// 縦（ホームが上）
        rc.size.width =  Min(r0.size.width,r0.size.height);
        rc.size.height = Max(r0.size.width,r0.size.height)-rc.origin.y;
    }else{ // iPhone が横
        rc.size.width =  Max(r0.size.width,r0.size.height);
        rc.size.height = Min(r0.size.width,r0.size.height)
        -(r0.size.height>600? rc.origin.y:0);
    }
    [qvaeView  setQvaeFrame:rc];
}



- (IBAction)fileMenu:(id)sender {
    UIActionSheet *acSheet;
    if([qvaeView askType:qVAnLANGask]==2){
        acSheet = [[UIActionSheet alloc] initWithTitle:@"File"
                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                     otherButtonTitles:QVAmnFile];
    }else{
        acSheet = [[UIActionSheet alloc] initWithTitle:@"ファイル"
                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                     otherButtonTitles:QVAmnFileJp];
    }
    acSheet.tag = 'File'; [acSheet showInView:self.view];
}

- (IBAction)editMenu:(id)sender{
    UIActionSheet *acSheet;
    if([qvaeView askType:qVAnLANGask]==2){
        acSheet = [[UIActionSheet alloc] initWithTitle:@"Edit"
                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                     otherButtonTitles:QVAmnEdit];
    }else{
        acSheet = [[UIActionSheet alloc] initWithTitle:@"編集"
                                                         delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                otherButtonTitles:QVAmnEditJp];
    }
    acSheet.tag = 'Edit'; [acSheet showInView:self.view];
}
- (IBAction)viewMenu:(id)sender{
    UIActionSheet *acSheet;
    if([qvaeView askType:qVAnLANGask]==2){
        acSheet = [[UIActionSheet alloc] initWithTitle:@"View"
                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                     otherButtonTitles:QVAmnView];
    }else{
        acSheet = [[UIActionSheet alloc] initWithTitle:@"表示"
                                                         delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                otherButtonTitles:QVAmnViewJp];
    }
    acSheet.tag = 'View'; [acSheet showInView:self.view];
}
- (IBAction)alignMenu:(id)sender{
    UIActionSheet *acSheet;
    if([qvaeView askType:qVAnLANGask]==2){
        acSheet = [[UIActionSheet alloc] initWithTitle:@"Align"
                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                     otherButtonTitles:QVAmnAlign];
    }else{
        acSheet = [[UIActionSheet alloc] initWithTitle:@"配置"
                                                         delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                otherButtonTitles:QVAmnAlignJp];
    }
    acSheet.tag = 'Alin'; [acSheet showInView:self.view];
}
- (IBAction)objectMenu:(id)sender{
    UIActionSheet *acSheet;
    if([qvaeView askType:qVAnLANGask]==2){
        acSheet = [[UIActionSheet alloc] initWithTitle:@"Object"
                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                     otherButtonTitles:QVAmnObject];
    }else{
        acSheet = [[UIActionSheet alloc] initWithTitle:@"調整"
                                                         delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                otherButtonTitles:QVAmnObjectJp];
    }
    acSheet.tag = 'Objt'; [acSheet showInView:self.view];
}
- (IBAction)inputMenu:(id)sender{
    UIActionSheet *acSheet;
    if([qvaeView askType:qVAnLANGask]==2){
        acSheet = [[UIActionSheet alloc] initWithTitle:@"Input"
                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                     otherButtonTitles:QVAmnInput];
    }else{
        acSheet = [[UIActionSheet alloc] initWithTitle:@"ツール"
                                                         delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                otherButtonTitles:QVAmnInputJp];
    }
    acSheet.tag = 'Inpt'; [acSheet showInView:self.view];
}
- (IBAction)helpMenu:(id)sender{
    UIActionSheet *acSheet;
    if([qvaeView askType:qVAnLANGask]==2){
        acSheet = [[UIActionSheet alloc] initWithTitle:@"Help"
                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                     otherButtonTitles:QVAmnHelp];
    }else{
        acSheet = [[UIActionSheet alloc] initWithTitle:@"ヘルプ"
                                                         delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                otherButtonTitles:QVAmnHelpJp];
    }
    acSheet.tag = 'Help'; [acSheet showInView:self.view];
}



- (void)actionSheet:(UIActionSheet *)acSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    QVACommand cmdFile[]={QVAcmdFile};
    QVACommand cmdEdit[]={QVAcmdEdit};
    QVACommand cmdView[]={QVAcmdView};
    QVACommand cmdAlign[]={QVAcmdAlign};
    QVACommand cmdObject[]={QVAcmdObject};
    QVACommand cmdInput[]={QVAcmdInput};
    QVACommand cmdHelp[]={QVAcmdHelp},*cmd,qmd; int kk;
    switch(acSheet.tag){
        case 'File': cmd=cmdFile; break;
        case 'Edit': cmd=cmdEdit; break;
        case 'View': cmd=cmdView; break;
        case 'Alin': cmd=cmdAlign; break;
        case 'Objt': cmd=cmdObject; break;
        case 'Inpt': cmd=cmdInput; break;
        case 'Help': cmd=cmdHelp; break;
    }
    for(kk=0;(qmd=cmd[kk])>0;kk++) if(kk==buttonIndex){
        if(qmd==qVAnLNGi23){
            qmd = [qvaeView askType:qVAnLANGask]!=2 ? qVAnLNGi23:qVAnLNGi21;
        }
        [qvaeView sendQvaeCommand:qmd];break;
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}




@end
