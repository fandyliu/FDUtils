//
//  FDTripleDESMananger.h
//  FDUtils
//
//  Created by 刘欢 on 16/11/3.
//  Copyright © 2016年 fandy. All rights reserved.
//
/*
  3DES 加密
 
 */

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@interface FDTripleDESMananger : NSObject

/*
 24字节数组与data string 之间的转换
 1.
 Byte byte[] = {0x11, 0x22, 0x4F, 0x58, 0x88, 0x10, 0x40, 0x38, 0x28, 0x25, 0x79, 0x51, 0xCB, 0xDD, 0x55, 0x66, 0x77, 0x29, 0x73, 0x92, 0x30, 0x40, 0x36, 0xE2};
 NSData *adata = [[NSData alloc] initWithBytes:byte length:24];
 NSString *aString = [[NSString alloc] initWithData:adata encoding:NSUTF8StringEncoding];
 
 2.
 NSString *testString = @"1234567890";
 NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
 Byte *testByte = (Byte *)[testData bytes];
 for(int i=0;i<[testData length];i++)
 printf("testByte = %d\n",testByte[i]);
 
 */

/**
 3DES加密与解密

 @param plainText 加密解密字符串
 @param encryptOrDecrypt 加密或解密操作
 @param data 24字节数组的data
 @return 结果
 */
+ (NSString *)TripleDES:(NSString *)plainText andCCOperation:(CCOperation)encryptOrDecrypt anddata:(NSData*)data;



/**
 3DES加密与解密

 @param plainText 加密解密字符串
 @param encryptOrDecrypt 加密或解密操作
 @param key 24字节数组的转换为字符串
 @return 结果
 */
+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key;

@end
