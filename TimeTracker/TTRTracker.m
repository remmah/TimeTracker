//
//  TTRTracker.m
//  TimeTracker
//
//  Created by remmah on 1/23/13.
//  Copyright (c) 2013 remmah. All rights reserved.
//

#import "TTRTracker.h"

@implementation TTRTracker

- (id)init
{
    self = [super init];
    if (self) {
        // initialize tracker with default values
        _trackerName = [[NSMutableString alloc] initWithFormat:@"Project Name"];
        _totalTimeAsString = [[NSMutableString alloc] initWithFormat:@"000:00:00"];
        _totalTime = 0;
        _trackerVersion = 0;
        //range = NSMakeRange(0, 9);
        
        // format time string
       // _totalTimeAsStringAttr = [[NSMutableAttributedString alloc] initWithString:_totalTimeAsString];
        //[_totalTimeAsStringAttr addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"Monofonto-Regular" size:34] range:range];
        
    }
    return self;
}

@end
