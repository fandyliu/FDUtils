//
//  FDFileManager.h
//  FDExtension
//
//  Created by QianTuFD on 16/8/8.
//  Copyright © 2016年 fandy. All rights reserved.
//
/*
 FDFileManager 是对系统沙盒进行管理的工具类
 1. 根据componet生成全路径,包括cache doc temp
 2. 获取指定路径下全部文件的大小
 3. 移除指定文件夹路径的全部文件
 
 4. 传入 B 的文件大小 返回带有 MB KB B 的字符串.
 */


#import <UIKit/UIKit.h>

@interface FDFileManager : NSObject

/**
 *  根据str生成缓存目录全路径
 */
+ (NSString *)cacheDirectoryAppendingPathComponent:(NSString *)str;

+ (NSString *)documentDirectoryAppendingPathComponent:(NSString *)str;

+ (NSString *)temporaryDirectoryAppendingPathComponent:(NSString *)str;




/**
 *  根据传进来的文件夹路径返回文件夹大小
 *
 */
+ (NSInteger)getFileSizeOfDictionaryPath:(NSString *)dictionaryPath;

/**
 *  移除文件夹路径全部文件
 */
+ (void)removeAllFilesInDictionaryPath:(NSString *)dictionaryPath;


/**
 *  传入B的文件大小 返回带有 MB KB B 的字符串.
 */
+ (NSString *)getBriefSize:(NSInteger)size;

@end
