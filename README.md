# TimeTracker

Add, remove, and use multiple named stopwatches. 

TimeTracker is a standard document-based app, so you can save and load multiple sets of stopwatches.

Currently, only one stopwatch can be active at a given time.

The energy impact of the app, as measured from the Xcode debug gauge, ranges between 'None' and 'Low', with  an average of 10 idle wakeups per second. The app supports `NSTimer' coalescing for additional energy efficiency.

## Requirements

TimeTracker requires macOS 10.9 or later due to the aforementioned use of timer coalescing. Commenting out the `tolerance` property on the timer should allow the app to run on 10.8.