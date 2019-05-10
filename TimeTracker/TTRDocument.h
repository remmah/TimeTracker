//
//  TTRDocument.h
//  TimeTracker
//
//  Created by remmah on 1/23/13.
//  Copyright (c) 2013 remmah. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface TTRDocument : NSDocument <NSTableViewDelegate>
{
    NSMutableArray *trackerList;    
    
    NSTimer *timer;
    BOOL stopwatchIsRunning;
    NSInteger selectedRow;

    NSInteger sessionSelection;
    NSDate *sessionStartTime;
    NSInteger totalTimeBeforeSession;
    NSInteger interimTimeCalc;
    NSInteger sessionTime;
    NSInteger hours;
    NSInteger minutes;
    NSInteger seconds;

    __weak NSTableView *_tableView;
}

// Toolbar buttons
@property (weak) IBOutlet NSToolbarItem *addButton;
@property (weak) IBOutlet NSToolbarItem *removeButton;
@property (weak) IBOutlet NSToolbarItem *runButton;
@property (weak) IBOutlet NSToolbarItem *stopButton;
@property (weak) IBOutlet NSToolbarItem *resetButton;

// Slider buttons

//

// Format attribute for the stopwatch
//@property NSMutableAttributedString *totalTimeAttr;
//@property (nonatomic, strong) IBOutlet NSTextField *totalTimeLabel;


@property NSInteger documentVersion;

- (IBAction)addTracker:(id)sender;
- (IBAction)runTheStopwatch:(id)sender;
- (IBAction)stopTheStopwatch:(id)sender;

- (void)stopwatchLoop:(NSTimer *)theTimer;
//- (void)changeStartToStop;
//- (void)changeStopToStart;

- (void)setTrackers:(NSMutableArray *)a;

@property (strong) IBOutlet NSArrayController *arrayController;

@property (weak) IBOutlet NSTableView *tableView;
@end
