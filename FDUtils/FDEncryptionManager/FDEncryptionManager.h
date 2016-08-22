//
//  FDEncryptionManager.h
//  FDUtils
//
//  Created by QianTuFD on 16/8/22.
//  Copyright © 2016年 fandy. All rights reserved.

/*
 AES 和 DES 加密
 
 */




#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FDAlgorithm) {
    FDAlgorithmAES,
    FDAlgorithmDES
};

@interface FDEncryptionManager : NSObject


+ (instancetype)sharedManager;

/**
 @constant   FDAlgorithmAES     高级加密标准，128位(默认)
 @constant   FDAlgorithmDES     数据加密标准
 */
@property (nonatomic, assign) FDAlgorithm algorithm;


/**
 *  加密字符串并返回base64编码字符串
 *
 *  @param string    要加密的字符串
 *  @param keyString 加密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回加密后的base64编码字符串
 */
- (NSString *)encryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;

/**
 *  解密字符串
 *
 *  @param string    加密并base64编码后的字符串
 *  @param keyString 解密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回解密后的字符串
 */
- (NSString *)decryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;

@end
