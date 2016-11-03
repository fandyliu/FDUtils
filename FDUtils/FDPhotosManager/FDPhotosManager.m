//
//  FDPhotosManager.m
//  FDExtension
//
//  Created by fandy on 15/8/9.
//  Copyright © 2015年 fandy. All rights reserved.
//

#import "FDPhotosManager.h"
#import <Photos/Photos.h>

@implementation FDPhotosManager


#pragma mark - 授权
+ (void)authorizationStatusAuthorizedHandler:(void(^)())authorizedHandler deniedHandler:(void(^)())deniedHandler {
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                if(authorizedHandler) {
                    authorizedHandler();
                }
            }
        }];
    } else if (authorizationStatus == PHAuthorizationStatusAuthorized) {
        if(authorizedHandler) {
            authorizedHandler();
        }
    } else {
        if (deniedHandler) {
            deniedHandler();
        }
    }
}


#pragma mark - 图片
// 将图片保存到相册中(如果没有创建对应的相册)
+ (void)saveImage:(UIImage *)image toAlbum:(NSString *)albumName completionHandler:(void(^)(BOOL success, NSError * error))completionHandler {
    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    
    [photoLibrary performChanges:^{
        // 获取相册改变请求
        PHAssetCollectionChangeRequest *albumChangeRequest = [self getAssetCollectionChangeRequestWithAlbum:albumName];
        // 获取相片请求
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        PHObjectPlaceholder *assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset;
        
        [albumChangeRequest addAssets:@[assetPlaceholder]];
    } completionHandler:completionHandler];
}

// 将路径下的图片保存到相册中(如果没有创建对应的相册)
+ (void)saveImagePath:(NSString *)imagePath toAlbum:(NSString *)albumName completionHandler:(void(^)(BOOL success, NSError * error))completionHandler {
    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    
    [photoLibrary performChanges:^{
        // 获取相册改变请求
        PHAssetCollectionChangeRequest *albumChangeRequest = [self getAssetCollectionChangeRequestWithAlbum:albumName];
        // 获取相片请求
        NSURL *url = [NSURL fileURLWithPath:imagePath];
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:url];
        
        PHObjectPlaceholder *assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset;
        [albumChangeRequest addAssets:@[assetPlaceholder]];
        
    } completionHandler:completionHandler];
}

// 将图片数组保存到相册中(如果没有创建对应的相册).要保存的照片数组(子元素只能为url urlstr 或者 UIImage类型)
+ (void)saveImages:(NSArray *)images toAlbum:(NSString *)albumName completionHandler:(void(^)(BOOL success, NSError * error))completionHandler {
    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    
    [photoLibrary performChanges:^{
        // 获取相册改变请求
        PHAssetCollectionChangeRequest *albumChangeRequest = [self getAssetCollectionChangeRequestWithAlbum:albumName];
        
        [albumChangeRequest addAssets:[self getAssets:images isImage:YES]];
        
    } completionHandler:completionHandler];
}

// 将图片数组保存到相册中(如果没有创建对应的相册)
+ (NSArray *)getAssets:(NSArray *)array isImage:(BOOL)isImage{
    NSMutableArray *assets = [NSMutableArray array];
    
    
    for (id image in array) {
        PHAssetChangeRequest *assetChangeRequest = nil;
        if (isImage) {
            if ([image isKindOfClass:[NSURL class]]) {
                assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:image];
            }else if ([image isKindOfClass:[NSString class]]) {
                assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:[NSURL fileURLWithPath:image]];
            }else if([image isKindOfClass:[UIImage class]]){
                assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            }
        }else {
            //这里image 是video
            if ([image isKindOfClass:[NSURL class]]) {
                assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:image];
            }else if ([image isKindOfClass:[NSString class]]) {
                assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL fileURLWithPath:image]];
            }
        }
        
        if (assetChangeRequest == nil) {
            NSString *reason = [NSString stringWithFormat:@"\n 🍎 类名与方法名: %s (在第%d行) \n 🍏 传入images数组有误,只能传入url urlstr 或者 UIImage类型", __PRETTY_FUNCTION__, __LINE__];
            NSException *excption = [NSException exceptionWithName:@"路径错误" reason:reason userInfo:nil];
            [excption raise];
            return nil;
        }
        PHObjectPlaceholder *assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset;
        
        [assets addObject:assetPlaceholder];
        
    }
    return assets;
}



// 通过相册名字获得相册改变请求(如果没有会创建一个并返回)
+ (PHAssetCollectionChangeRequest *)getAssetCollectionChangeRequestWithAlbum:(NSString *)albumName {
    PHAssetCollection *album = [self getAssetCollectionWithAlbum:albumName];
    PHAssetCollectionChangeRequest *albumChangeRequest;
    if (album) {
        albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
    } else {
        albumChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
    }
    return albumChangeRequest;
}


// 通过相册名字获得相册(如果没有返回nil)
+ (PHAssetCollection *)getAssetCollectionWithAlbum:(NSString *)albumName {
    
    PHFetchResult *albumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *album in albumsFetchResult) {
        if ([album.localizedTitle isEqualToString:albumName]) {
            return album;
        }
    }
    return nil;
}

#pragma mark - 视频

+ (void)saveVideoPath:(NSString *)videoPath toAlbum:(NSString *)albumName completionHandler:(void(^)(BOOL success, NSError * error))completionHandler {
    
    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    
    [photoLibrary performChanges:^{
        // 获取相册改变请求
        PHAssetCollectionChangeRequest *albumChangeRequest = [self getAssetCollectionChangeRequestWithAlbum:albumName];
        // 获取相片请求
        NSURL *url = [NSURL fileURLWithPath:videoPath];
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
        
        PHObjectPlaceholder *assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset;
        [albumChangeRequest addAssets:@[assetPlaceholder]];
        
    } completionHandler:completionHandler];
}

+ (void)saveVideos:(NSArray *)videos toAlbum:(NSString *)albumName completionHandler:(void(^)(BOOL success, NSError * error))completionHandler {
    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    
    [photoLibrary performChanges:^{
        // 获取相册改变请求
        PHAssetCollectionChangeRequest *albumChangeRequest = [self getAssetCollectionChangeRequestWithAlbum:albumName];
        
        [albumChangeRequest addAssets:[self getAssets:videos isImage:NO]];
        
    } completionHandler:completionHandler];
}

#pragma mark - 删除
+ (void)deleteAssetBylocalIdentifier:(NSString *)localIdentifier fromAlbum:(NSString *)albumName completionHandler:(void(^)(BOOL success, NSError * error))completionHandler {
    PHAssetCollection *album = [self getAssetCollectionWithAlbum:albumName];
    PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:album options: nil];
    
    [assetResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([localIdentifier isEqualToString:asset.localIdentifier]) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [PHAssetChangeRequest deleteAssets:@[asset]];
            } completionHandler:completionHandler];
        }
    }];
}
@end
