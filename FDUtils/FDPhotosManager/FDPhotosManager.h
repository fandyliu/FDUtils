//
//  FDPhotosManager.h
//  FDExtension
//
//  Created by QianTuFD on 16/8/9.
//  Copyright © 2016年 fandy. All rights reserved.
//
/*
 FDPhotosManager 对Photos进行管理封装
 系统相册管理
 1. 判断是否有访问相册的权限,根据不同权限执行不同的回掉
 2. 将图片保存到自己命名的相册中(如果没有创建对应的相册)
 3. 通过相册名字获得相册改变请求(如果没有会创建一个并返回)
 4. 通过相册名字获得相册(如果没有返回nil)
 */

#import <UIKit/UIKit.h>
@class PHAssetCollection, PHAssetCollectionChangeRequest;


@interface FDPhotosManager : NSObject


/****************************处理图片保存权限****************************/
/**
 *  根据该应用对图片保存权限是否授权进行回调(第一次访问会弹出是否进行授权)
 *
 *  @param authorizedHandler 授权回调
 *  @param deniedHandler     否认回调
 */
+ (void)authorizationStatusAuthorizedHandler:(void(^)())authorizedHandler deniedHandler:(void(^)())deniedHandler;

/****************************处理图片保存权限****************************/



/****************************处理图片保存到系统相簿****************************/

/**
 *  将图片保存到相册中(如果没有创建对应的相册)
 *
 *  @param image             要保存的照片
 *  @param albumName         相册名
 *  @param completionHandler 完成会掉;
 */
+ (void)saveImage:(UIImage *)image toAlbum:(NSString *)albumName completionHandler:(void(^)(BOOL success, NSError * error))completionHandler;

/**
 *  通过相册名字获得相册改变请求(如果没有会创建一个并返回)
 *
 *  @param albumName 相册名
 *
 *  @return 相册改变请求
 */
+ (PHAssetCollectionChangeRequest *)getAssetCollectionChangeRequestWithAlbum:(NSString *)albumName;

/**
 *  通过相册名字获得相册(如果没有返回nil)
 *
 *  @param albumName 相册名
 *
 *  @return 相册
 */
+ (PHAssetCollection *)getAssetCollectionWithAlbum:(NSString *)albumName;

/****************************处理图片保存到系统相簿****************************/

@end
