//
//  ViewController.h
//  Draw9VAe
//
//  Created by Danjiro Daiwa on 11/11/17.
//  Copyright (c) 2017 Danjiro Daiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../QvaeLib/QvaeView.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate> {
    
    CGPoint lastPoint;
    NSTimer *timer;
    int timerBusy;
    
}

@property (retain, nonatomic) IBOutlet QvaeView *qvaeView;
- (IBAction)fileMenu:(id)sender;
- (IBAction)editMenu:(id)sender;
- (IBAction)viewMenu:(id)sender;
- (IBAction)alignMenu:(id)sender;
- (IBAction)objectMenu:(id)sender;
- (IBAction)inputMenu:(id)sender;
- (IBAction)helpMenu:(id)sender;


-  (void)viewWillAppear:(BOOL)animated;
//- (void) viewDidAppear:(BOOL)animated;
- (void) viewDidDisappear:(BOOL)animated;


@end
