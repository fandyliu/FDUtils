//
//  FDTimerManager.m
//  FDUtils
//
//  Created by fandy on 15/8/29.
//  Copyright © 2015年 fandy. All rights reserved.
//

#import "FDTimerManager.h"

@interface FDTimerManager ()

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) BOOL repeat;
@property (nonatomic, copy) void(^fireHandle)();

@end

@implementation FDTimerManager

+ (FDTimerManager *)sharedManager {
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


+ (void)startTimer:(NSTimeInterval)timeInterval repeat:(BOOL)repeat firedHandle:(void (^)())fireHandle {
    if ([self sharedManager].timer) {
        [self stopTimer];
    }
    [self sharedManager].repeat = repeat;
    
    [self sharedManager].timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(onTimer) userInfo:nil repeats:repeat];
}

+ (void)stopTimer {
    [[self sharedManager].timer invalidate];
    [self sharedManager].timer = nil;
    [self sharedManager].repeat = NO;
    [self sharedManager].fireHandle = nil;
}




+ (void)onTimer {
    if ([self sharedManager].fireHandle) {
        [self sharedManager].fireHandle();
        
        if (![self sharedManager].repeat) {
            [self stopTimer];
        }
    }else {
        [self stopTimer];
    }
}

@end
