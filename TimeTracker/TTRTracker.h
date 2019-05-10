//
//  TTRTracker.h
//  TimeTracker
//
//  Created by remmah on 1/23/13.
//  Copyright (c) 2013 remmah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTRTracker : NSObject
{
    NSRange range;
}
@property NSInteger trackerVersion;
@property NSTextField *totalTimeFont;
@property NSMutableString *trackerName;
@property NSInteger totalTime;
@property NSMutableString *totalTimeAsString;
//@property NSMutableAttributedString *totalTimeAsStringAttr;



@end
