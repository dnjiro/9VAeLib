//
//  QvaeView.h
//  Qvae
//
//  Created by Danjiro Daiwa on 9/1/17.
//  Copyright (c) 2017 Danjiro Daiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "qvaeLib.h"

@interface QvaeView : UIView <AVAudioPlayerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>
{
    CGPoint lastPoint;
    int mouseSwiped;
    int timerBusy;
    QVAioType ioType;
    BOOL musicRepeat;
    BOOL soundRepeat;
}

@property (retain, nonatomic) QvaeLib *qvae;
@property (retain, nonatomic) UIImage* image;
@property (retain, nonatomic) AVAudioPlayer *musicPlayer;
@property (retain, nonatomic) AVAudioPlayer *soundPlayer;
@property (retain, nonatomic) NSURL *musicURL;
@property (retain, nonatomic) NSURL *soundURL;



- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)setQvaeFrame:(CGRect)frame;

- (QVAioType) updateQvae;
- (void)sendQvaeCommand:(QVACommand)commndId;
- (NSString *) getIoTitle;
- (NSString *) getIoMessage;
- (NSString *) getIoText:(int)no;
- (NSString *) getIoExportWidth;
- (NSString *) getIoExportHeight;
- (NSString *) getIoExportTimeSec;
- (NSString *) getIoExportFps;
- (NSString *) getIoFileName;

- (NSURL *) getIoFilePath;
- (QVAplayMode)  getIoPlayMode;
- (NSTimeInterval) getIoCurrentTime;

- (BOOL) getIoExportTransparent;
- (QVAioType) getQVAioType;


- (void) setIoText:(QVAioType)id text1:(NSString *)text text2:(NSString *)text2;
- (void) setFileName:(QVAioType)id text1:(NSString *)text;
- (void) setDownloadURL:(QVAioType)id address:(NSString *)text;
- (void) setIoURL:(QVAioType)id url:(NSURL *)url;
- (void) setIoExportImage:(QVAioType)id
                name:(NSString *)name
               width:(NSString *)width
              height:(NSString *)height
             timeSec:(NSString *)time
                 fps:(NSString *)fps
         transparent:(BOOL)transparent
                loop:(NSString *)loop;
- (void) setFontList;
- (void) setIoYesNo:(QVAioType)id value:(int)val;


- (void) cancelIo;
- (int) askType:(QVAaskType)type;


- (void) relayoutView;
- (void) refreshView;
- (void)fontFamilyChange:(NSString*)fontFamilyName;


+(QVAioType) updateView: (UIViewController *)mainView qvaeView:(QvaeView*)qvaView;


- (void)drawRect:(CGRect)rect;

@end
