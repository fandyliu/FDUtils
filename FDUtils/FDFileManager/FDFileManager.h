//
//  FDFileManager.h
//  FDExtension
//
//  Created by QianTuFD on 16/8/8.
//  Copyright © 2016年 QianTuFD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDFileManager : NSObject

/**
 *  根据str生成缓存目录全路径
 */
+ (NSString *)fd_cacheDirectoryAppendingPathComponent:(NSString *)str;
/**
 *  根据str生成文档目录全路径
 */
+ (NSString *)fd_documentDirectoryAppendingPathComponent:(NSString *)str;
/**
 *  根据str生成临时目录全路径
 */
+ (NSString *)fd_temporaryDirectoryAppendingPathComponent:(NSString *)str;


/**
 *  根据传进来的文件夹路径返回文件夹大小
 *
 */
+ (NSInteger)fd_getFileSizeOfDictionaryPath:(NSString *)dictionaryPath;

/**
 *  移除文件夹路径全部文件
 *
 */
+ (void)fd_removeAllFilesInDictionaryPath:(NSString *)dictionaryPath;

/**
 *  传入B的文件大小 返回带有 MB KB B 的字符串.
 */
+ (NSString *)fd_getBriefSize:(NSInteger)size;

@end
