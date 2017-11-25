//
//  QvaeView.m
//  Qvae
//
//  Created by Danjiro Daiwa on 9/1/17.
//  Copyright (c) 2017 Danjiro Daiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIAlertController.h>
#import "QvaeView.h"

@implementation QvaeView

@synthesize qvae;
@synthesize image;
@synthesize musicPlayer, musicURL;
@synthesize soundPlayer, soundURL;

//NSURL *urlDownload;
CGPoint tchFrm1,tchFrm2,tchTo1,tchTo2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self qvaInit];
    }
    return self;
}


- (id)initWithImage:(UIImage *)image0
{
    if ((self = [super init])) {
        image = image0;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self qvaInit];
    }
    return self;
}

/* 9VAe Initialize */
- (void)qvaInit
{
    CGRect r0 = [UIScreen mainScreen].bounds;
    
    if(!qvae){
        qvae = [[QvaeLib alloc] init];
        [qvae qVAinit];
        [self setFontList];
        [self askType:qVAnKANJset]; //Set Language to Kanji (for Japanese)
        if(r0.size.width>600){
            [self askType:qVAnMENUINset]; //Set Normal menu
        }
        
        self.multipleTouchEnabled = YES;
        timerBusy=0;
    }
}

/* 9VAe Resize */
- (void)setQvaeFrame:(CGRect)frame
{
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1,1,1,1);
    CGContextFillRect(context, frame);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [qvae touchesCancel];
    [qvae qVAsetWindow:NULL
                qWidth:frame.size.width
               qHeight:frame.size.height qvaWindow:NULL];
    
    [qvae redraw];
}

- (void) relayoutView{
}
- (void) refreshView{}
- (void)fontFamilyChange:(NSString*)fontFamilyName{
    [qvae setIoText: qVAcFONinp text1:fontFamilyName text2:@""];
}
- (QVAioType) getQVAioType
{
    return [qvae qVAGetIoType];
}

/* 9VAe Message Loop */
- (QVAioType) updateQvae
{
    QVAioType ret = [qvae qVAGetIoType];
    if(timerBusy) return 0;
    if(!ioType){
        timerBusy = 1;
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        [qvae setCurrentContext:context];
        [qvae timer];
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        CGContextRestoreGState(context);
        UIGraphicsEndImageContext();
        
        [self setNeedsDisplay];
        timerBusy = 0;
        ioType=ret;
        return ret;
    }
    return 0;
}

- (int) askType:(QVAaskType)type {
    return [qvae askType:type];
}

- (NSString *) getIoTitle {
    return [qvae getIoText:'Titl'];
}
- (NSString *) getIoMessage {
    return [qvae getIoText:'Mess'];
}
- (NSString *) getIoText:(int)no {
    return [qvae getIoText:no];
}

- (NSString *) getIoExportWidth{
    return [qvae getIoText:'Widt'];
}
- (NSString *) getIoExportHeight{
    return [qvae getIoText:'Heig'];
}
- (NSString *) getIoExportTimeSec{
    return [qvae getIoText:'Time'];
}
- (NSString *) getIoExportFps{
    return [qvae getIoText:'Fps '];
}
- (NSString *) getIoFileName{
    return [qvae getIoText:'Fnam'];
}

- (NSURL *) getIoFilePath{
   return [NSURL fileURLWithPath:[qvae getIoText:'Path']];
}
- (QVAplayMode)  getIoPlayMode{
    switch([qvae qVAGetIoType]){
        case qVAcPMSCinp:case qVAcPSNDinp:
            return [qvae getIoNumber:0];
        default:break;
    }
    return 0;
}

- (NSTimeInterval) getIoCurrentTime{
    double xx = [[qvae getIoText:2]  doubleValue];
    return xx/100.;
}

- (BOOL) getIoExportTransparent{
    return [qvae getIoText:'Tran']==NULL;
}


- (void) cancelIo{
    [qvae cancelIo];
    ioType=0;
}


- (void) setFontList{
    for (NSString *family in [UIFont familyNames]){
        //NSLog(@"Family name: %@", family);
        [qvae setIoText:qVAcFOSinp text1:family text2:@""];
    }
    
}

- (void) setIoYesNo:(QVAioType)id value:(int)val{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [qvae setCurrentContext:context];
    [qvae setIoValue:id value:val];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    [self setNeedsDisplay];
    ioType=0;
}

- (void) setIoText:(QVAioType)id text1:(NSString *)text text2:(NSString *)text2{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [qvae setCurrentContext:context];
    [qvae setIoText:id text1:text text2:text2];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    [self setNeedsDisplay];
    ioType=0;
}

- (void) setIoURL:(QVAioType)id url:(NSURL *)url{
    CFURLRef cfurl = CFBridgingRetain(url);
    //CFStringRef str = CFURLCopyPath(cfurl);

    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [qvae setCurrentContext:context];
    
    [qvae setIoText:id text1:[url lastPathComponent] text2:@"assets-library://asset/"];
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    [self setNeedsDisplay];
    ioType=0;
    CFRelease(cfurl);
}

- (void) setDownloadURL:(QVAioType)id address:(NSString *)text{
    NSURL *url = [NSURL URLWithString:text];
    NSData* data = [[NSData alloc] initWithContentsOfURL:url];
    if(data){
        [self saveData:data id:id url:url];
        return;
    }
    [self cancelIo];
    return;
}

- (void)saveData:(NSData *)data id:(QVAioType)id url:(NSURL *)url
{
    NSError *error;NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *path,*path0,*newname,*pp,*ext=@"";int kk;NSRange range;
    NSArray *array = [NSArray arrayWithObjects:@".svg",@".mp3",@".wav",nil];
    path0 = [paths objectAtIndex:0];
    for(kk=0;kk<9999;kk++){
        newname = [url lastPathComponent];
        for(ext in array){ if(!ext) break;
            range = [newname rangeOfString:ext];
            if(range.location == NSNotFound) continue;
            newname = [newname substringToIndex:range.location+4];
            break;
        }
        if(!ext) ext=@"";
        if(kk>0){
            newname = [newname stringByAppendingString:[NSString stringWithFormat:@"%03d",kk]];
            newname = [newname stringByAppendingString:ext];
        }
        for ( pp in [fm contentsOfDirectoryAtPath:path0 error:&error] ){
            if([pp containsString:newname]){
                break;
            }
        }
        if(pp==nil) break;
    }
    path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:newname];
    [[NSFileManager defaultManager] createFileAtPath:path
                                            contents:data
                                          attributes:nil];
    [self setIoText:id text1:newname text2:path0];

}

- (void)loadData:(NSURL *)url id:(QVAioType)id
{
    NSData* inData = [[NSData alloc] initWithContentsOfURL:url];
    [self performSelectorOnMainThread:@selector(saveData:id:) withObject:inData waitUntilDone:NO];
}

- (void) setFileName:(QVAioType)id text1:(NSString *)text{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *DocumentsDirPath = [paths objectAtIndex:0];
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [qvae setCurrentContext:context];
    [qvae setIoText:id text1:text text2:DocumentsDirPath];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    [self setNeedsDisplay];
    ioType=0;
}


- (void) setIoExportImage:(QVAioType)id
name:(NSString *)name
width:(NSString *)width
height:(NSString *)height
timeSec:(NSString *)time
fps:(NSString *)fps
transparent:(BOOL)transparent
loop:(NSString *)loop{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *DocumentsDirPath = [paths objectAtIndex:0];
    
    if(![qvae setIoExport:id width:width height:height timeSec:time fps:fps transparent:transparent loop:loop]){
        return; //error
    }
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);{
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        [qvae setCurrentContext:context];
        [qvae setIoText:id text1:name text2:DocumentsDirPath];//Export animated GIF
        self.image = UIGraphicsGetImageFromCurrentImageContext();
    }CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    if([self askType:qVAnLANGask]==2){
        [qvae setIoMessage:0 text1:@"Export Animated GIF" text2:@"Saved in Camera Roll."];
    }else{
        [qvae setIoMessage:0 text1:@"アニメGIF出力" text2:@"カメラロールに保存しました"];
    }
    [self setNeedsDisplay];
    ioType=0;
}

- (void)drawRect:(CGRect)rect
{
    CGRect rc=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.image drawInRect:rc
        blendMode:kCGBlendModeNormal alpha:1.0];
}

- (void)sendQvaeCommand:(QVACommand)commndId;
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [qvae setCurrentContext:context];
    [qvae qVAsendCommand:commndId];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    [self setNeedsDisplay];
}





- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 2) {
        mouseSwiped = 4;
        return;
    }
    mouseSwiped = 1;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self];
}

- (CGFloat)distanceWithPointA:(CGPoint)pointA pointB:(CGPoint)pointB
{
    CGFloat dx = fabs( pointB.x - pointA.x );
    CGFloat dy = fabs( pointB.y - pointA.y );
    return sqrt(dx * dx + dy * dy);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    int sw=0;
    if(mouseSwiped>2||[touches count] == 2){
        if(mouseSwiped<=2) mouseSwiped|=4;
        if ([touches count] == 2 && mouseSwiped>=4) {
            NSArray *twoFingers = [touches allObjects];
            UITouch *touch1 = [twoFingers objectAtIndex:0];
            UITouch *touch2 = [twoFingers objectAtIndex:1];
            tchTo1 = [touch1 locationInView:self];
            tchTo2 = [touch2 locationInView:self];
            if(mouseSwiped<8){ sw=1;//mouseSwiped|=8;
                tchFrm1 = [touch1 previousLocationInView:self];
                tchFrm2 = [touch2 previousLocationInView:self];
            }
        }
        if(!sw) return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [qvae setCurrentContext:context];
        if(mouseSwiped<2){
            [qvae touchesBegan:lastPoint.x qY:lastPoint.y];
            [qvae timer];
            [qvae timer];
        }
    if(sw){
        mouseSwiped|=8;
        [qvae touchesCancel];
    }else{
        [qvae touchesMoved:currentPoint.x qY:currentPoint.y];
    }
        [qvae timer];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    [self setNeedsDisplay];
    if(mouseSwiped<8){
        lastPoint = currentPoint;
        mouseSwiped = 2;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
       [qvae setCurrentContext:context];
        switch(mouseSwiped) {
        case 1:
            [qvae touchesBegan:lastPoint.x qY:lastPoint.y];
            [qvae timer];
            [qvae timer];
            [qvae touchesMoved:lastPoint.x qY:lastPoint.y];//One dot
            /*no break*/
        case 2:
            [qvae touchesEnded:lastPoint.x qY:lastPoint.y];
            break;
        default: //Swipe or Pinch
                if((mouseSwiped&10)==2){
                    [qvae touchesCancel];
                }
                if(mouseSwiped&8){
                    CGFloat frmDistance = [self distanceWithPointA:tchFrm1 pointB:tchFrm2];
                    CGPoint cp1,cp2;
                    cp1=CGPointMake((tchFrm1.x+tchFrm2.x)/2,(tchFrm1.y+tchFrm2.y)/2);
                    cp2=CGPointMake((tchTo1.x+tchTo2.x)/2,(tchTo1.y+tchTo2.y)/2);
                    CGFloat midDistance = [self distanceWithPointA:cp1 pointB:cp2];
                    if(frmDistance!=0 && midDistance<frmDistance){
                        CGFloat scale = [self distanceWithPointA:tchTo1 pointB:tchTo2]/frmDistance;
                        if(scale>1.1||scale<0.9){
                            [qvae zoomView:scale];
                            break;
                        }
                    }
                    [qvae panView:tchFrm1 toPoint:tchTo1];
                }
                break;
        }
        [qvae timer];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    mouseSwiped=0;
    [self setNeedsDisplay];
}

+(NSString*) labelNO:(QvaeView*)qvaView{
    if([qvaView askType:qVAnLANGask]==2){
        return @"No";
    }else return @"いいえ";
}
+(NSString*) labelYES:(QvaeView*)qvaView{
    if([qvaView askType:qVAnLANGask]==2){
        return @"Yes";
    }else return @"はい";
}
+(NSString*) labelCancel:(QvaeView*)qvaView{
    if([qvaView askType:qVAnLANGask]==2){
        return @"Cancel";
    }else return @"キャンセル";
}


+(QVAioType) updateView: (UIViewController *)mainView qvaeView:(QvaeView*)qvaView
{
    UIAlertController * alert=NULL; int id;
    UIAlertAction *actionCancel= [UIAlertAction actionWithTitle:[self labelCancel:qvaView]
            style:UIAlertActionStyleCancel
            handler:^(UIAlertAction *action) {
                    [qvaView cancelIo];
            }];
	NSString *str0=@"",*str1=@"";
    
    switch((id=[qvaView updateQvae])){
        case 0: [qvaView setNeedsDisplay]; break;
        default: [qvaView cancelIo]; break;
        case qVAcYSNCinp: //Yes No Cancel
            str0=[self labelNO:qvaView];str1=[self labelYES:qvaView];
        { alert = [UIAlertController
                   alertControllerWithTitle: [qvaView getIoText:2]
                   message: [qvaView getIoText:3]
                   preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:str1 style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [qvaView setIoYesNo:id value:1];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:str0 style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [qvaView setIoYesNo:id value:-1];
           	}]];
            [alert addAction:[UIAlertAction actionWithTitle:[self labelCancel:qvaView]
 style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [qvaView setIoYesNo:id value:0];
            }]];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
            
        case qVAcYSNOinp: //Yes No
            str0=[self labelNO:qvaView];
            str1=[self labelYES:qvaView];
            /*no break*/
        case qVAcYSOKinp: if(id==qVAcYSOKinp){ //OK Cancel
            str0=[self labelCancel:qvaView];
            str1=@"OK";
        } /*no break*/
        { alert = [UIAlertController
                   alertControllerWithTitle: [qvaView getIoText:2]
                   message: [qvaView getIoText:3]
                   preferredStyle:UIAlertControllerStyleAlert];
            if(id==qVAcYSNCinp){
                [alert addAction:[UIAlertAction actionWithTitle:[self labelCancel:qvaView] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [qvaView setIoYesNo:id value:0];
                }]];
            }
            [alert addAction:[UIAlertAction actionWithTitle:str0 style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [qvaView setIoYesNo:id value:-1];
           	}]];
            [alert addAction:[UIAlertAction actionWithTitle:str1 style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [qvaView setIoYesNo:id value:1];
            }]];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
        case qVAc2STRinp:// Input 2 texts
        { alert = [UIAlertController
                   alertControllerWithTitle: [qvaView getIoTitle]
                   message: [qvaView getIoMessage]
                   preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.text = [qvaView getIoText:0];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.keyboardType = UIKeyboardTypeDecimalPad;//小数点付き
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.layer.borderColor = [UIColor blueColor].CGColor;
                textField.layer.borderWidth = 1.f;
                textField.layer.cornerRadius = 10.0f;
            }];
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.text = [qvaView getIoText:1];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.keyboardType = UIKeyboardTypeDecimalPad;//小数点付き
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.layer.borderColor = [UIColor blueColor].CGColor;
                textField.layer.borderWidth = 1.f;
                textField.layer.cornerRadius = 10.0f;
            }];
            [alert addAction:actionCancel];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSArray * textfields = alert.textFields;
                UITextField * txt1 = textfields[0];
                UITextField * txt2 = textfields[1];
                [qvaView setIoText:id text1:txt1.text text2:txt2.text];
                
            }]];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
            
        case qVAcANNinp:// Input AnimeCast's name (Duplicate and Edit)
        case qVAcDEGinp:// Input Angle
        case qVAcWPTinp:// Input Time
        case qVAcSTRinp:// Input Text(1 line)
        {    alert = [UIAlertController
                      alertControllerWithTitle: [qvaView getIoTitle]
                      message: [qvaView getIoMessage]
                      preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.text = [qvaView getIoText:0];
                //textField.placeholder = [qvaView getIoText:0];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.layer.borderColor = [UIColor blueColor].CGColor;
                textField.layer.borderWidth = 1.f;
                textField.layer.cornerRadius = 10.0f;
                if(id==qVAcDEGinp||id==qVAcWPTinp){
                    textField.keyboardType = UIKeyboardTypeDecimalPad;//Decimal point
                }
            }];
            [alert addAction:actionCancel];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSArray * textfields = alert.textFields;
                UITextField * namefield = textfields[0];
                [qvaView setIoText:id text1:namefield.text text2:NULL];
                
            }]];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
           
        case qVAcTXTinp:// Input Text(Multiple lines)
        {
            NSString* mes =[qvaView getIoMessage];
            UITextView* tx = [[UITextView alloc]init];
            tx.frame = CGRectMake(10, 70, 250, 80);
            tx.text = [qvaView getIoText:0];
            tx.layer.borderColor = [UIColor blueColor].CGColor;
            tx.layer.borderWidth = 2.5f;
            tx.layer.cornerRadius = 10.0f;
            
            alert = [UIAlertController
                      alertControllerWithTitle: [qvaView getIoTitle]
                     message: [mes stringByAppendingString:@"\n"]
                      preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.text = [qvaView getIoText:0];
                //textField.placeholder = [qvaView getIoText:0];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
            }];
            
            [alert.view addSubview:tx];
            [alert addAction:actionCancel];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [qvaView setIoText:id text1:tx.text text2:NULL];
            }]];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
            
        case qVAcFLDinp:      // Open File
        { NSError *error;NSFileManager *fm = [NSFileManager defaultManager];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *DocumentsDirPath = [paths objectAtIndex:0];
            alert = [UIAlertController
                     alertControllerWithTitle: [qvaView getIoTitle]
                     message: [qvaView getIoMessage]
                     preferredStyle:UIAlertControllerStyleAlert];
            for ( NSString *path in [fm contentsOfDirectoryAtPath:DocumentsDirPath error:&error] ){
                if([path hasSuffix:@".svg"]||[path hasSuffix:@".eva"]){
                    [alert addAction:[UIAlertAction actionWithTitle:path style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [qvaView setFileName:id text1:path];
                    }]];
                }
             }
            [alert addAction:actionCancel];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
            
            
         case qVAcSSVinp:     // Save SVG
        case qVAcFSVinp:      // Save File
        {    alert = [UIAlertController
                      alertControllerWithTitle: [qvaView getIoTitle]
                      message: [qvaView getIoMessage]
                      preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = [qvaView getIoText:0];
                //textField.textColor = [UIColor blackColor];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
            }];
            [alert addAction:actionCancel];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSArray * textfields = alert.textFields;
                UITextField * namefield = textfields[0];
                [qvaView setFileName:id text1:namefield.text];
            }]];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
            
        case qVAcSLDinp:	// Input Sound file from URL
        case qVAcMLDinp:    // Input Music file from URL
        case qVAcURLinp:    // Input SVG from URL
        {    alert = [UIAlertController
                      alertControllerWithTitle: [qvaView getIoTitle]
                      message: [qvaView getIoMessage]
                      preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                //textField.text = [qvaView getIoText:0];
                textField.placeholder = @"http://";
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.layer.borderColor = [UIColor blueColor].CGColor;
                textField.layer.borderWidth = 1.f;
                textField.layer.cornerRadius = 10.0f;
            }];
            [alert addAction:actionCancel];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSArray * textfields = alert.textFields;
                UITextField * namefield = textfields[0];
                [qvaView setDownloadURL:id address:namefield.text];
            }]];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
            
            
        case qVAcILDinp:     // Input Image file from Album
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = qvaView;
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [mainView presentViewController:picker animated:YES completion:nil];
        }break;
            
        case qVAcALRTinp:      //YesOnly Alert
        {    alert = [UIAlertController
                      alertControllerWithTitle: [qvaView getIoText:2]
                      message: [qvaView getIoText:3]
                      preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [qvaView cancelIo];
            }]];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
            
        case qVAcPMSCinp:    // Play Music
        {
            int mode = [qvaView getIoPlayMode];
            if ([qvaView.musicPlayer isPlaying]){
                [qvaView.musicPlayer stop];
            }
            switch(mode){
                case qVAavPLAY: case qVAavPLAYfrom:
                    qvaView->musicRepeat=0;  break;
                case qVAavPLAYloop:case qVAavPLAYfromLoop:
                    qvaView->musicRepeat=1; break;
                case qVAavSTOP:
                    [qvaView.musicPlayer setCurrentTime:0]; goto end;
                case qVAavPAUSE: goto end;
                case qVAavRESUME:
                    qvaView.musicPlayer.delegate = qvaView;
                    [qvaView.musicPlayer play];
                    goto end;
            }
            //Play
            if([qvaView.musicURL isEqual:[qvaView getIoFilePath]]){
                if(mode==qVAavPLAYfrom||mode==qVAavPLAYfromLoop){
                    [qvaView.musicPlayer setCurrentTime:[qvaView getIoCurrentTime]];
                }else [qvaView.musicPlayer setCurrentTime:0];
            }else{
                @try {
                    qvaView.musicURL = [qvaView getIoFilePath];
                    qvaView.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: qvaView.musicURL error:nil];
                }
                @catch (NSException *exception) {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                                   message:exception.description
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil];
                    [alert show];
                }
            }
            qvaView.musicPlayer.delegate = qvaView;
            if(mode==qVAavPLAYfrom||mode==qVAavPLAYfromLoop){
                [qvaView.musicPlayer setCurrentTime:[qvaView getIoCurrentTime]];
            }
            [qvaView.musicPlayer play]; //[qvaView.musicPlayer prepareToPlay];
            
        }goto end;
            
            
        case qVAcPSNDinp:  // Play Sound
        {
            int mode = [qvaView getIoPlayMode];
            if ([qvaView.soundPlayer isPlaying]){
                [qvaView.soundPlayer stop];
            }
            switch(mode){
                case qVAavPLAY: case qVAavPLAYfrom:
                    qvaView->soundRepeat=0;  break;
                case qVAavPLAYloop:case qVAavPLAYfromLoop:
                    qvaView->soundRepeat=1;  break;
                case qVAavSTOP:
                    [qvaView.soundPlayer setCurrentTime:0]; goto end;
                case qVAavPAUSE: goto end;
                case qVAavRESUME:
                    qvaView.soundPlayer.delegate = qvaView;
                    [qvaView.soundPlayer play];
                    goto end;
            }
            //Play
            if([qvaView.soundURL isEqual:[qvaView getIoFilePath]]){
                if(mode==qVAavPLAYfrom||mode==qVAavPLAYfromLoop){
                    [qvaView.soundPlayer setCurrentTime:[qvaView getIoCurrentTime]];
                }else [qvaView.soundPlayer setCurrentTime:0];
            }else{
                //[qvaView.soundPlayer release];
            
                @try {
                    qvaView.soundURL = [qvaView getIoFilePath]; 
                    qvaView.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: qvaView.soundURL error:nil];
                }
                @catch (NSException *exception) {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                                   message:exception.description
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil];
                    [alert show];
                }
            }
            qvaView.soundPlayer.delegate = qvaView;
            if(mode==qVAavPLAYfrom||mode==qVAavPLAYfromLoop){
                [qvaView.soundPlayer setCurrentTime:[qvaView getIoCurrentTime]];
            }
            [qvaView.soundPlayer play]; //[qvaView.musicPlayer prepareToPlay];
            
        }goto end;
            
            
        case qVAcGF2inp:		// Export Animated GIF2 (Size, rate...)
        {
            UITextField* tx[5],*tx0,*tx1,*tx2,*tx3,*tx4; int ii;
            UISwitch *sw = [[UISwitch alloc] init];
            for(ii=1;ii<5;ii++){
                tx[ii]= [[UITextField alloc]init];
                tx[ii].layer.borderColor = [UIColor blueColor].CGColor;
                tx[ii].layer.borderWidth = 1.f;
                tx[ii].layer.cornerRadius = 10.0f;
                [tx[ii] setTextAlignment:NSTextAlignmentCenter];
                if(ii==0)  tx[ii].keyboardType = UIKeyboardTypeDefault;
                else tx[ii].keyboardType = UIKeyboardTypeDecimalPad;//小数点付き
            }
            tx[0].frame = CGRectMake(20, 70, 230, 40);
            tx[1].frame = CGRectMake(20,     61, 100, 30);
            tx[2].frame = CGRectMake(20+130, 61, 100, 30);
            tx[3].frame = CGRectMake(20,     110, 60, 30);
            tx[4].frame = CGRectMake(20+80,  110, 60, 30);
            sw.center =  CGPointMake(20+200, 110+15);
            
            tx[0].text = [qvaView getIoText:0];
            tx[1].text = [qvaView getIoExportWidth];
            tx[2].text = [qvaView getIoExportHeight];
            tx[3].text = [qvaView getIoExportTimeSec];
            tx[4].text = [qvaView getIoExportFps];
            sw.on = [qvaView getIoExportTransparent];
            tx0=tx[0];tx1=tx[1];tx2=tx[2];tx3=tx[3];tx4=tx[4];
            
            alert = [UIAlertController
                   alertControllerWithTitle: [qvaView getIoTitle]
                   message:@"Picture Size:(Width x Height)\n\n\nLength(sec):\tFrame/sec: Transparent:\n\n"
                   preferredStyle:UIAlertControllerStyleAlert];
            
            for(ii=1;ii<5;ii++) [alert.view addSubview:tx[ii]];
            [alert.view addSubview:sw];
            
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.text = [qvaView getIoFileName];
                textField.placeholder = @"File name:";
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.layer.borderColor = [UIColor blueColor].CGColor;
                textField.layer.borderWidth = 1.f;
                textField.layer.cornerRadius = 10.0f;
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.keyboardType = UIKeyboardTypeDefault;
            }];
            
            [alert addAction:actionCancel];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSArray * textFields = alert.textFields;
                UITextField * namefield = textFields[0];
                [qvaView setIoExportImage:id
                               name:namefield.text
                               width:tx1.text
                               height:tx2.text
                               timeSec:tx3.text
                               fps:tx4.text
                               transparent:sw.isOn
                               loop:@"0"
                 ];
            }]];
            [mainView presentViewController:alert animated:YES completion:nil];
        }break;
    }
    return 0;
end:
    [qvaView cancelIo];
    return 0;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController :(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSError *error;NSFileManager *fm = [NSFileManager defaultManager];
    UIImage *image1 = info[UIImagePickerControllerOriginalImage]; int kk=0;
    NSData *data = UIImagePNGRepresentation(image1);
    NSString *path,*path0,*newname,*pp;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path0 = [paths objectAtIndex:0];
    for(kk=0;kk<9999;kk++){
        newname = [self getIoFileName];
        newname = [newname stringByAppendingString:[NSString stringWithFormat:@"%03d.png",kk]];
        for ( pp in [fm contentsOfDirectoryAtPath:path0 error:&error] ){
            if([pp containsString:newname]){
                break;
            }
        }
        if(pp==nil) break;
    }
    path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:newname];
    [[NSFileManager defaultManager] createFileAtPath:path
                                            contents:data
                                          attributes:nil];
    [self setIoText:qVAcILDinp text1:newname text2:path0];

    [picker dismissViewControllerAnimated:YES completion:nil]; //picker Exit
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self cancelIo];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if([player.url isEqual:self.musicURL] && musicRepeat){
        [self.musicPlayer play];
    }
    if([player.url isEqual:self.soundURL] && soundRepeat){
        [self.soundPlayer play];
    }
    
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    
}

                                                                      
                                                                      
@end




