//
//  TTRDocument.m
//  TimeTracker
//
//  Created by remmah on 1/23/13.
//  Copyright (c) 2013 remmah. All rights reserved.
//

#import "TTRDocument.h"
#import "TTRTracker.h"

@implementation TTRDocument

- (id)init
{
    self = [super init];
    if (self) {
        //[_totalTimeLabel setFont:[NSFont fontWithName:@"Monofonto-Regular" size:34]];
        //NSLog(@"%@", [_totalTimeLabel font]);
        trackerList = [[NSMutableArray alloc] initWithObjects:[[TTRTracker alloc] init], nil];
        //[_totalTimeAttr addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"Monofonto-Regular" size:34] range:range];
    }
    return self;
}

- (IBAction)addTracker:(id)sender
{
    TTRTracker *tracker = [[TTRTracker alloc] init];
    [_arrayController add:tracker];
}


#pragma mark - IBActions
- (IBAction)runTheStopwatch:(id)sender
{
    /* check to see if stopwatch is already running
    if (stopwatchIsRunning) {
        NSLog(@"Stopwatch already running... ignoring run command");
        return;
    }
    
     check if a stopwatch is selected
    if (!selectedRow) {
        NSLog(@"No stopwatch selected... ignoring run command");
        return;
    }
    */
    
    // check if the selection has changed since stopwatch started
    if ((stopwatchIsRunning == 1) && (selectedRow != sessionSelection)) {
        // NSLog(@"Selection does not match active stopwatch: Stopping previous stopwatch");
        [self stopTheStopwatch:self];
    }
    
    [_runButton setEnabled:NO];
    [_stopButton setEnabled:YES];
    [_addButton setEnabled:NO];
    stopwatchIsRunning = 1;
    totalTimeBeforeSession = [[trackerList objectAtIndex:selectedRow] totalTime];
    // set session index in stone so we can move about while stopwatch is running
    sessionSelection = selectedRow;
    sessionStartTime = [NSDate date];
    timer = [NSTimer timerWithTimeInterval:0.1
                                    target:self
                                  selector:@selector(stopwatchLoop:)
                                  userInfo:nil
                                   repeats:YES];
    [timer setTolerance:0.1];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)stopTheStopwatch:(id)sender
{
    // Adding sessionTime to accumulatedTime back in the TKTracker:
    // sessionTimeTally is used because timeElapsedMS gets consumed
    // due to the modular aritmetic
    
    [[trackerList objectAtIndex:sessionSelection] setTotalTime:(totalTimeBeforeSession + sessionTime)];
    
    [timer invalidate];
    timer = nil;
    // new button should be enabled again here
    [_runButton setEnabled:YES];
    [_stopButton setEnabled:NO];
    stopwatchIsRunning = 0;
    
}

#pragma mark - NSTableViewDelegate
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    selectedRow = [_tableView selectedRow];
}

#pragma mark - Stopwatch methods
- (void)stopwatchLoop:(NSTimer *)theTimer
{
    // Calculate current time elapsed for this session
    sessionTime = [sessionStartTime timeIntervalSinceNow] * -1;
    
    // Add sessionTime to totalTimeBeforeSession to create sessionTimeCalc
    interimTimeCalc = sessionTime + totalTimeBeforeSession;
    
    // Use interimTimeCalc to calculate individual time units
    seconds = interimTimeCalc % 60;
    interimTimeCalc /= 60;
    minutes = interimTimeCalc % 60;
    interimTimeCalc /= 60;
    hours = interimTimeCalc % 60;
    
    // Formatting units into string for totalTimeAsString
    NSString *secondsString = [NSString stringWithFormat:@"%02ld", seconds];
    NSString *minutesString = [NSString stringWithFormat:@"%02ld", minutes];
    NSString *hoursString = [NSString stringWithFormat:@"%03ld", hours];
    
    NSString *completedTimeString = [NSString stringWithFormat:@"%@:%@:%@", hoursString, minutesString, secondsString];
    
    [[trackerList objectAtIndex:sessionSelection] setValue:completedTimeString forKey:@"totalTimeAsString"];
    
}



#pragma mark - NSDocument
- (void)setTrackers:(NSMutableArray *)a
{
    if (a == trackerList)
        return;
    trackerList = a;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"TTRDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return NO;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSLog(@"Saving...");
    return [NSKeyedArchiver archivedDataWithRootObject:trackerList];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSLog(@"Loading...");
    NSMutableArray *loadingDock = nil;
    @try {
        loadingDock = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *e) {
        NSLog(@"exception = %@", e);
        if (outError) {
            NSDictionary *d = [NSDictionary dictionaryWithObject:@"The data is corrupted" forKey:NSLocalizedFailureReasonErrorKey];
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                            code:unimpErr
                                        userInfo:d];
        }
        return NO;
    }
    [self setTrackers:loadingDock];
    return YES;

}

@end
