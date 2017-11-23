//
//  qvaeLib.h
//  qvaeLib
//
//  Created by Danjiro Daiwa on 2017/07/06.
//  Copyright © 2017 Danjiro Daiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
#import	<MacTypes.h>
#import "QvaeDef.h"

@interface QvaeLib : NSObject


- (id)init;
- (void)show;
- (void)qVAinit;
- (void)qVAsetWindow:(char *)fname
              qWidth:(int) qWidth
             qHeight:(int) qHeight
           qvaWindow:(void *)theWindow;
- (void)qVAsendCommand:(QVACommand)commndId;
- (QVAioType)qVAGetIoType;
- (NSString *) getIoText:(int)no;
- (int) getIoNumber:(int)no;


- (void) setIoText:(QVAioType)id
    text1:(NSString *) text1
    text2:(NSString *) text2;
- (void) setIoValue:(QVAioType)id
    value:(int) val;

- (BOOL) setIoExport:(QVAioType)id
    width:(NSString *)width
    height:(NSString *)height
    timeSec:(NSString *)time
    fps:(NSString *)fps
    transparent:(BOOL)transparent
    loop:(NSString *)loop;

- (void) setIoMessage:(int)type
                text1:(NSString *) text1
                text2:(NSString *) text2;


- (void) cancelIo;
- (int) askType:(QVAaskType)type;


- (BOOL)   setCurrentContext: (CGContextRef)context;
- (void)redraw;
- (void)timer;

- (void)zoomView:(float)scale;
- (void)panView:(CGPoint)from toPoint:(CGPoint)to;


- (void)touchesMoved:(int) qX qY:(int)qY;
- (void)touchesBegan:(int) qX qY:(int)qY;
- (void)touchesEnded:(int) qX qY:(int)qY;
- (void)touchesCancel;

@end




