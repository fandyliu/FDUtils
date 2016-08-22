//
//  FDFileManager.m
//  FDExtension
//
//  Created by QianTuFD on 16/8/8.
//  Copyright © 2016年 QianTuFD. All rights reserved.
//

#import "FDFileManager.h"

@implementation FDFileManager

+ (NSString *)fd_cacheDirectoryAppendingPathComponent:(NSString *)str {
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:str];
}

+ (NSString *)fd_documentDirectoryAppendingPathComponent:(NSString *)str {
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:str];
}

+ (NSString *)fd_temporaryDirectoryAppendingPathComponent:(NSString *)str {
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:str];
}


/**
 *  根据传进来的文件夹路径返回文件夹大小
 *
 */
//+ (NSInteger)fd_getFileSizeOfDictionaryPath:(NSString *)dictionaryPath {
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    //判断是否存在
//    BOOL isDirectory = NO;
//    BOOL isExist = [fileManager fileExistsAtPath:dictionaryPath isDirectory:&isDirectory];
//    if (!isExist || !isDirectory) {
//        NSException *excption = [NSException exceptionWithName:@"路径错误" reason:@"传进来的路径不存在或者不是文件夹" userInfo:nil];
//        [excption raise];
//    }
//    //获得全部子路径文件和
//    NSArray *allSubpaths = [fileManager subpathsAtPath:dictionaryPath];
//    NSInteger totalSize = 0;
//    
//    for (NSString *subpath in allSubpaths) {
//        if ([subpath containsString:@".DS"]) continue;
//        NSString *fullPath = [dictionaryPath stringByAppendingPathComponent:subpath];
//        isExist = [fileManager fileExistsAtPath:fullPath isDirectory:&isDirectory];
//        if (isExist && !isDirectory) {
//            NSDictionary *attris = [fileManager attributesOfItemAtPath:fullPath error:nil];
//            NSInteger size = [attris fileSize];
//            totalSize += size;
//        }
//    }
//    return totalSize;
//}

//- (unsigned long long)lx_fileSize
//{
//    // 计算self这个文件夹\文件的大小
//    
//    // 文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//    
//    // 文件类型
//    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
//    NSString *fileType = attrs.fileType;
//    
//    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
//        // 获得文件夹的遍历器
//        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
//        
//        // 总大小
//        unsigned long long fileSize = 0;
//        
//        // 遍历所有子路径
//        for (NSString *subpath in enumerator) {
//            // 获得子路径的全路径
//            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
//            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
//        }
//        
//        return fileSize;
//    }
//    
//    // 文件
//    return attrs.fileSize;
//}

//- (unsigned long long)lx_fileSize
//{
//    // 计算self这个文件夹\文件的大小
//
//    // 文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//
//    // 文件类型
//    BOOL isDirectory = NO;
//    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
//    if (!exists) return 0;
//
//    if (isDirectory) { // 文件夹
//        // 获得文件夹的遍历器
//        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
//
//        // 总大小
//        unsigned long long fileSize = 0;
//
//        // 遍历所有子路径
//        for (NSString *subpath in enumerator) {
//            // 获得子路径的全路径
//            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
//            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
//        }
//
//        return fileSize;
//    }
//
//    // 文件
//    return [mgr attributesOfItemAtPath:self error:nil].fileSize;
//}



+ (NSInteger)fd_getFileSizeOfDictionaryPath:(NSString *)dictionaryPath {
    // 计算self这个文件夹\文件的大小
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件类型
    NSDictionary *attrs = [mgr attributesOfItemAtPath:dictionaryPath error:nil];
    NSString *fileType = attrs.fileType;
    
    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
        // 获得文件夹的遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:dictionaryPath];
        
        // 总大小
        unsigned long long fileSize = 0;
        
        // 遍历所有子路径
        for (NSString *subpath in enumerator) {
            // 获得子路径的全路径
            NSString *fullSubpath = [dictionaryPath stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        
        return fileSize;
    }
    // 文件
    return attrs.fileSize;
}

/**
 *  移除文件夹路径全部文件
 *
 */
+ (void)fd_removeAllFilesInDictionaryPath:(NSString *)dictionaryPath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断是否存在
    BOOL isDirectory = NO;
    BOOL isExist = [fileManager fileExistsAtPath:dictionaryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSException *excption = [NSException exceptionWithName:@"路径错误" reason:@"传进来的路径不存在或者不是文件夹" userInfo:nil];
        [excption raise];
    }
    
    //    //移除并创建新文件夹
    //    [fileManager removeItemAtPath:dictionaryPath error:nil];
    //    [fileManager createDirectoryAtPath:dictionaryPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSArray *contentsPath = [fileManager contentsOfDirectoryAtPath:dictionaryPath error:nil];
    for (NSString *path in contentsPath) {
        NSString *fullPath = [dictionaryPath stringByAppendingPathComponent:path];
        [fileManager removeItemAtPath:fullPath error:nil];
    }
    
}

+ (NSString *)fd_getBriefSize:(NSInteger)size {
    NSString *sizeStr = nil;
    if (size > 1000 * 1000) { // MB
        CGFloat sizeMB = size / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%.1fMB",sizeMB];
    } else if (size > 1000) { // kB
        CGFloat sizeKB = size / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%.1fKB",sizeKB];
    } else if (size > 0) { // B
        sizeStr = [NSString stringWithFormat:@"%ldB",size];
    }
    return sizeStr;
}

@end
