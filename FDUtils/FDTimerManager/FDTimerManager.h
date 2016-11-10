//
//  FDTimerManager.h
//  FDUtils
//
//  Created by fandy on 15/8/29.
//  Copyright © 2015年 fandy. All rights reserved.
//

/*
 FDTimerManager, 管理NSTimer的功能为
 1. 用block进行封装,使用更加简单.
 2. 对于非repeat的Timer,执行后自动释放timer
 3. 对于repeat的Timer, 需要调用 stopTimer 方法对其进行释放;
 */

#import <Foundation/Foundation.h>

@interface FDTimerManager : NSObject



+ (void)startTimer:(NSTimeInterval)timeInterval repeat:(BOOL)repeat firedHandle:(void(^)())fireHandle;

+ (void)stopTimer;

@end
